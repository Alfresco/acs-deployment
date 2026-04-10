import requests
import json
import logging
import os
import base64

# --- Logging Configuration ---
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')

logger = logging.getLogger(__name__)

ACS_API_URL = os.environ.get('ACS_API_URL')
BASE_URL = f"{ACS_API_URL}/alfresco/api/-default-/public"
AUTH_BASE_URL = f"{BASE_URL}/authentication/versions/1"
SEARCH_BASE_URL = f"{BASE_URL}/search/versions/1"
USERNAME = os.environ.get('USERNAME')
PASSWORD = os.environ.get('PASSWORD')


def get_auth_ticket(username: str, password: str) -> str:
    url = f"{AUTH_BASE_URL}/tickets"
    headers = {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }
    payload = {
        "userId": username,
        "password": password
    }

    response = requests.post(url, headers=headers, data=json.dumps(payload))
    response.raise_for_status()

    ticket = response.json()["entry"]["id"]
    logger.info(f"Authentication successful. Ticket: {ticket}")
    return base64.b64encode(f"{ticket}".encode()).decode()


ALFRESCO_BASE_URL = f"{BASE_URL}/alfresco/versions/1"


def find_root_node(ticket: str) -> dict:
    url = f"{ALFRESCO_BASE_URL}/nodes/-root-"
    headers = {
        "Authorization": f"Basic {ticket}",
        "Accept": "application/json"
    }

    response = requests.get(url, headers=headers)
    response.raise_for_status()

    folder = response.json()["entry"]
    logger.info(f"Found root folder: id={folder['id']}, name={folder['name']}")
    return folder

def create_classification_node(ticket: str, root_node_id: str, name: str) -> dict:
    url = f"{ALFRESCO_BASE_URL}/nodes/{root_node_id}/children"
    headers = {
        "Authorization": f"Basic {ticket}",
        "Accept": "application/json",
        "Content-Type": "application/json"
    }
    payload = {
        "name": name,
        "nodeType": "cdict:content"
    }

    response = requests.post(url, headers=headers, data=json.dumps(payload))
    response.raise_for_status()

    node = response.json()["entry"]
    logger.info(f"Created classification node: id={node['id']}, name={node['name']}")
    return node


def create_cd_definition(ticket: str, cd_name: str, cd_aspect: str, key_property: str, version_property: str) -> dict:
    url = f"{ALFRESCO_BASE_URL}/cascading-dictionaries"
    headers = {
        "Authorization": f"Basic {ticket}",
        "Accept": "application/json",
        "Content-Type": "application/json"
    }
    payload = {
        "name": cd_name,
        "aspect": cd_aspect,
        "keyProperty": key_property,
        "versionProperty": version_property
    }

    response = requests.post(url, headers=headers, data=json.dumps(payload))
    response.raise_for_status()

    res = response.json()["entry"]
    logger.info(f"Created CD definition for aspect {cd_aspect}: createdAt={res['createdAt']}")
    return res


def upload_cd_content(ticket: str, cd_aspect: str, filename: str) -> dict:
    url = f"{ALFRESCO_BASE_URL}/cascading-dictionaries/{cd_aspect}/content?majorVersion=true"
    headers = {
        "Authorization": f"Basic {ticket}",
        "Accept": "application/json",
        "Content-Type": "application/json"
    }

    with open(filename, 'r') as f:
        data = json.load(f)

    response = requests.post(url, headers=headers, data=json.dumps(data))
    response.raise_for_status()

    res = response.json()["entry"]
    logger.info(f"Uploaded CD content for aspect {cd_aspect}: version={res['version']} modifiedAt={res['modifiedAt']}")
    return res


if __name__ == "__main__":
    _encoded_ticket = get_auth_ticket(USERNAME, PASSWORD)
    logger.info(f"Obtained authentication ticket: {_encoded_ticket}")

    # Adding example dictionaries to CD definitions folder
    create_cd_definition(_encoded_ticket, "Accounts", "cdict:account", "cdict:accountNumber", "cdict:accountDictVersion")
    upload_cd_content(_encoded_ticket, "cdict:account", "data/accounts.json")

    create_cd_definition(_encoded_ticket, "Departments", "cdict:department", "cdict:departmentId", "cdict:departmentDictVersion")
    upload_cd_content(_encoded_ticket, "cdict:department", "data/departments.json")

    create_cd_definition(_encoded_ticket,"Locations", "cdict:location", "cdict:locId", "cdict:locDictVersion")
    upload_cd_content(_encoded_ticket, "cdict:location", "data/locations.json")

    #Adding example node ready to classification to root folder
    _root_folder = find_root_node(_encoded_ticket)
    logger.info(f"Root folder id: {_root_folder['id']}")
    _cl_node = create_classification_node(_encoded_ticket, _root_folder["id"], "Classification Example")
    logger.info(f"Created classification node id: {_cl_node['id']}")
