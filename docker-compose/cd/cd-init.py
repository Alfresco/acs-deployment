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


def find_cd_definition_node(ticket: str) -> dict:
    url = f"{SEARCH_BASE_URL}/search"
    headers = {
        "Authorization": f"Basic {ticket}",
        "Accept": "application/json",
        "Content-Type": "application/json"
    }
    payload = {
        "query": {
            "query": "(PATH:'//app:company_home//app:dictionary//app:cd_definitions')",
            "language": "afts"
        },
        "paging": {
            "skipCount": 0,
            "maxItems": 25
        },
        "sort": [
            {
                "type": "SCORE",
                "field": "score",
                "ascending": False
            }
        ]
    }

    response = requests.post(url, headers=headers, data=json.dumps(payload))
    response.raise_for_status()

    entries = response.json()["list"]["entries"]
    if not entries:
        raise ValueError("CD definitions node not found")

    folder = entries[0]["entry"]
    logger.info(f"Found CD definitions node: id={folder['id']}, name={folder['name']}")
    return folder


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


def create_cd_definition_node(ticket: str, cd_def_folder_id: str, cd_name: str, cd_aspect: str, key_property: str, version_property: str) -> dict:
    url = f"{ALFRESCO_BASE_URL}/nodes/{cd_def_folder_id}/children?majorVersion=true"
    headers = {
        "Authorization": f"Basic {ticket}",
        "Accept": "application/json",
        "Content-Type": "application/json"
    }
    payload = {
        "name": cd_name,
        "nodeType": "cd:definition",
        "properties": {
            "cd:aspect": cd_aspect,
            "cd:keyProperty": key_property,
            "cd:versionProperty": version_property
        }
    }

    response = requests.post(url, headers=headers, data=json.dumps(payload))
    response.raise_for_status()

    node = response.json()["entry"]
    logger.info(f"Created CD definition node: id={node['id']}, name={node['name']}, aspect={node['properties']['cd:aspect']}")
    return node


def upload_cd_definition_content(ticket: str, node_id: str, filename: str) -> dict:
    url = f"{ALFRESCO_BASE_URL}/nodes/{node_id}/content?majorVersion=true"
    headers = {
        "Authorization": f"Basic {ticket}",
        "Accept": "application/json",
        "Content-Type": "application/json"
    }

    with open(filename, 'rb') as f:
        response = requests.put(url, headers=headers, data=f)
    response.raise_for_status()

    node = response.json()["entry"]
    logger.info(f"Uploaded content to node: id={node['id']}, name={node['name']}, version={node['properties']['cm:versionLabel']}")
    return node


if __name__ == "__main__":
    _encoded_ticket = get_auth_ticket(USERNAME, PASSWORD)
    logger.info(f"Obtained authentication ticket: {_encoded_ticket}")

    # Adding example dictionaries to CD definitions folder
    _cd_def_folder = find_cd_definition_node(_encoded_ticket)
    logger.info(f"CD definitions folder id: {_cd_def_folder['id']}")

    _account_node = create_cd_definition_node(_encoded_ticket, _cd_def_folder['id'], "Accounts", "{http://www.alfresco.org/model/customdictionarymodel/1.0}account", "accountNumber", "accountDictVersion")
    logger.info(f"Created node id: {_account_node['id']}")
    _uploaded_node = upload_cd_definition_content(_encoded_ticket, _account_node['id'], "data/accounts.json")
    logger.info(f"Uploaded content, new version: {_uploaded_node['properties']['cm:versionLabel']}")

    _department_node = create_cd_definition_node(_encoded_ticket, _cd_def_folder['id'], "Departments", "{http://www.alfresco.org/model/customdictionarymodel/1.0}department", "departmentId", "departmentDictVersion")
    logger.info(f"Created node id: {_account_node['id']}")
    _uploaded_node = upload_cd_definition_content(_encoded_ticket, _department_node['id'], "data/departments.json")
    logger.info(f"Uploaded content, new version: {_uploaded_node['properties']['cm:versionLabel']}")

    _location_node = create_cd_definition_node(_encoded_ticket, _cd_def_folder['id'], "Locations", "{http://www.alfresco.org/model/customdictionarymodel/1.0}location", "locId", "locDictVersion")
    logger.info(f"Created node id: {_account_node['id']}")
    _uploaded_node = upload_cd_definition_content(_encoded_ticket, _location_node['id'], "data/locations.json")
    logger.info(f"Uploaded content, new version: {_uploaded_node['properties']['cm:versionLabel']}")

    #Adding example node ready to classification to root folder
    _root_folder = find_root_node(_encoded_ticket)
    logger.info(f"Root folder id: {_root_folder['id']}")
    _cl_node = create_classification_node(_encoded_ticket, _root_folder["id"], "Classification Example")
    logger.info(f"Created classification node id: {_cl_node['id']}")


