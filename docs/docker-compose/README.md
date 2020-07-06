# Alfresco Content Services Docker Compose Deployment

This page describes how to quickly deploy Alfresco Content Services (ACS) using Docker Compose.

The system deployed is shown in the diagram below.

![Docker Compose Deployment Components](/docs/diagrams/docker-compose/docker-compose-components.png)

## Components

TODO: Re-organise

|Docker Image Name|Dockerfile Source Location|
|:---|:---|
|alfresco/alfresco-content-repository|[acs-packaging](https://github.com/Alfresco/acs-packaging/blob/master/docker-alfresco/Dockerfile)|
|alfresco/alfresco-acs-nginx|[acs-ingress](https://github.com/Alfresco/acs-ingress/blob/master/Dockerfile)|


1. alfresco-content-repository |  [tags](https://hub.docker.com/r/alfresco/alfresco-content-repository/tags/)
2. alfresco-pdf-renderer | [tags](https://hub.docker.com/r/alfresco/alfresco-pdf-renderer/tags/)
3. alfresco-imagemagick | [tags](https://hub.docker.com/r/alfresco/alfresco-imagemagick/tags/)
4. alfresco-libreoffice | [tags](https://hub.docker.com/r/alfresco/alfresco-libreoffice/tags/)
5. alfresco-tika | [tags](https://hub.docker.com/r/alfresco/alfresco-tika/tags/)
6. alfresco-share | [tags](https://hub.docker.com/r/alfresco/alfresco-share/tags/)
7. alfresco-search-services | [tags](https://hub.docker.com/r/alfresco/alfresco-search-services/tags/)
8. postgres | [tags](https://hub.docker.com/r/library/postgres/tags/)

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

## Configuration

TODO

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
