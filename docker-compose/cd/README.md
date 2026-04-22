# Cascading Dictionaries (CD) 

This directory contains a custom content model and an initialization script that
demonstrate the **Cascading Dictionaries** feature in Alfresco Content Services.

## Custom Dictionary Model (`model/customDictModel.xml`)

The model defines a namespace `cdict` (Custom Dictionary Model) with:

* **Content type** `cdict:content` – extends `cm:content` and mandates the three
  classification aspects below.
* **Aspects** (all inherit from `cd:classifiable`):
  | Aspect | Key properties |
  |---|---|
  | `cdict:department` | `departmentId`, `departmentName`, `departmentDictVersion` |
  | `cdict:account` | `accountNumber`, `accountName`, `accountCategory`, `accountDictVersion` |
  | `cdict:location` | `locId`, `locRegionCode`, `locRegionName`, `locCity`, `locZipCode`, `locStreet`, `locBuilding`, `locCountry`, `locDictVersion` |

The companion Spring context file `model/customDictModel-context.xml` registers
the model with the Alfresco dictionary bootstrap so it is loaded at startup.

## Initialization Script (`cd-init.py`)

A Python script that runs against a live ACS instance to:

1. Create CD definitions for the three aspects (Accounts, Departments, Locations).
2. Upload dictionary content from the JSON files under `data/`.
3. Create a sample node of type `cdict:content` in the root folder for testing.

The script is packaged as a Docker image via the `Dockerfile` and can be
executed with `docker-compose.yml` found in this directory.

## Using the Model in an ACS Compose File

### 1. Mount the model files into the repository container

Add volume mounts to the `alfresco` service so the model XML and its Spring
context are picked up at startup:

```yaml
services:
  alfresco:
    volumes:
      - ./cd/model/customDictModel.xml:/usr/local/tomcat/shared/classes/alfresco/model/customDictModel.xml
      - ./cd/model/customDictModel-context.xml:/usr/local/tomcat/shared/classes/alfresco/extension/customDictModel-context.xml
```

### 2. Enable the CD aspects via `JAVA_OPTS`

Tell ACS which aspects should be treated as cascading dictionaries:

```yaml
services:
  alfresco:
    environment:
      JAVA_OPTS: >-
        ...
        -Dcd.aspects=cdict:department,cdict:account,cdict:location
```

### 3. (Optional) Run the initialisation container

After ACS is healthy you can start the `cd-init` service to seed dictionary
data and create a sample classifiable node:

```yaml
docker compose -f docker-compose/compose.yaml up -d
# wait for the alfresco service to be healthy, then:
docker compose -f docker-compose/cd/docker-compose.yml up
```

The `cd-init` container connects to ACS at the URL specified by the
`ACS_API_URL` environment variable (defaults to `http://localhost:8080`).

## Directory Structure

```
cd/
├── cd-init.py                     # Initialisation script
├── docker-compose.yml             # Compose file for the init container
├── Dockerfile                     # Image definition for cd-init
├── requirements.txt               # Python dependencies
├── README.md                      # This file
├── data/
│   ├── accounts.json              # Sample account dictionary data
│   ├── departments.json           # Sample department dictionary data
│   └── locations.json             # Sample location dictionary data
└── model/
    ├── customDictModel.xml        # Custom dictionary content model
    └── customDictModel-context.xml # Spring context to register the model
```
