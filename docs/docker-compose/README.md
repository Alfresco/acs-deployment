# Alfresco Content Services Docker Compose Deployment

This page describes how to quickly deploy Alfresco Content Services (ACS) using Docker Compose.

The system deployed is shown in the diagram below.

![Docker Compose Deployment Components](/docs/docker-compose/diagrams/docker-compose-components.png)

## Considerations

The Docker Compose file is undergoing continual development and improvement, and should not be used "as is" for your production environments, but should help you save time and effort deploying Alfresco Content Services for your organisation.

## Prerequisites

* [Docker](https://www.docker.com/products/docker-desktop)
* [Docker Compose](https://docs.docker.com/compose/install)
* Quay.io credentials requested by logging a ticket with [Alfresco Support](https://support.alfresco.com/)

## Deploy

1. Clone this repository or download the [docker-compose](../../docker-compose/docker-compose.yml) file.
2. Navigate to the folder where the _docker-compose.yml_ file is located.
3. Log in to Quay.io with your credentials: ```docker login quay.io```
4. Run ```docker-compose up```
5. Navigate to the Admin Console and apply your trial license:
   * [http://<machine_ip>:8080/alfresco/service/enterprise/admin/admin-license](http://localhost:8080/alfresco/service/enterprise/admin/admin-license) (```<machine_ip>``` will usually just be ```localhost```)
   * Default username and password is ```admin```
   * See [Uploading a new license](https://docs.alfresco.com/6.1/tasks/at-adminconsole-license.html) for more details
6. Open the following URLs in your browser to check that everything starts up:
   * Administration and REST APIs: [http://<machine_ip>:8080/alfresco](http://localhost:8080/alfresco)
   * Alfresco Digital Workspace: [http://<machine_ip>:8080/workspace](http://localhost:8080/workspace)
   * Share: [http://<machine_ip>:8080/share](http://localhost:8080/share)
   * Search administration: [http://<machine_ip>:8083/solr](http://localhost:8083/solr)

### Notes

Make sure that exposed ports are open on your host. Check the _docker-compose.yml_ file to determine the exposed ports - refer to the ```host:container``` port definitions. You'll see they include 5432, 8080, 8083 and others.

If Docker is running on your local machine, the IP address will be just _localhost_.

If you're using the [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows), run the following command to find the IP address:
```bash
docker-machine ip
```

## Configure

#### Alfresco Content Repository

| Name | Format | Description |
|------|--------|-------------|
| JAVA_TOOL_OPTIONS | "-Dparam=value ..." | Adding this environment variable, allows to set sensible values (like passwords) that are not passed as arguments to the Java Process. |
| JAVA_OPTS | "-Dparam=value ..." | A set of properties that are picked up by the JVM inside the container |


#### Alfresco Search Services (solr6)

| Name | Format | Description |
|------|--------|-------------|
| SOLR_ALFRESCO_HOST | Alfresco host (e.g. alfresco) | Solr needs to know how to register itself with Alfresco |
| SOLR_ALFRESCO_PORT | Alfresco port (e.g. 8080) | Solr needs to know how to register itself with Alfresco |
| SOLR_SOLR_HOST | Search host (e.g. alfresco) | Alfresco needs to know how to call solr |
| SOLR_SOLR_PORT | Search host (e.g. 8983) | Alfresco needs to know how to call solr |
| SOLR_CREATE_ALFRESCO_DEFAULTS | e.g. alfresco,archive | Create the default alfresco and archive cores |
| SOLR_OPTS | "-Dparam=value ..." | Options to pass when starting the Java process. |
| SOLR_HEAP | Memory amount (e.g. 2g) | The Java heap assigned to Solr. |
| SOLR_JAVA_MEM | "-Xms... -Xmx..." | The exact memory settings for Solr. Note that SOLR_HEAP takes precedence over this. |
| MAX_SOLR_RAM_PERCENTAGE | Integer | The percentage of available memory to assign to Solr. Note that SOLR_HEAP and SOLR_JAVA_MEM take precedence over this. |
| SEARCH_LOG_LEVEL | ERROR, WARN, INFO, DEBUG or TRACE | The root logger level. |
| ENABLE_SPELLCHECK | true or false | Whether spellchecking is enabled or not. |
| DISABLE_CASCADE_TRACKING | true or false | Whether cascade tracking is enabled or not. Disabling cascade tracking will improve performance, but result in some feature loss (e.g. path queries). |
| ALFRESCO_SECURE_COMMS | https or none | Whether communication with the repository is secured. See below. |
| SOLR_SSL_... | --- | These variables are also used to configure SSL. See below. |


## Cleanup

To bring the system down and cleanup the containers run the following command:

```bash
docker-compose down
```

## Troubleshooting

If you have issues running ```docker-compose up``` after deleting a previous Docker Compose cluster, try replacing step 4 with the following command:

```bash
docker-compose down && docker-compose build --no-cache && docker-compose up
```
