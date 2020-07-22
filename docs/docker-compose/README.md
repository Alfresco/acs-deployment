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

### Minimum set of properties required

In docker-compose deployment, alfresco properties are passed to the JVM through JAVA_OPTS environment variable

#### Alfresco Content Repository

##### Database configuration

* ```db.driver``` - Database driver (e.g.: org.postgresql.Driver)
* ```db.username``` - Database username (default value: alfresco)
* ```db.password``` - Database password (default value: alfresco)
* ```db.url``` - Database connection url (e.g.: jdbc:postgresql://postgres:5432/alfresco)

##### SOLR connection details

* ```solr.host``` - The host name where the Solr instance is located (for docker-compose deployment this value can be the name of the service (e.g. solr6)).
* ```solr.port``` - This specifies the application server's http port (non-secure) on which Solr 6 is running. This is only used if Solr 6 is configured to run without secure communications. (e.g.: 8983)
* ```solr.secureComms``` - E.g.: none for http or https
* ```solr.base.url``` - This specifies the base URL for the Solr 6 web application. (E.g.: /solr)
* ```index.subsystem.name``` - The subsystem type value. (E.g.: solr6)

##### URL Generation Parameters

* ```share.host``` - Specifies the externally resolvable host name of the Alfresco Share web application URL.
* ```share.port``` - Specifies the externally resolvable port number of the Alfresco Share web application URL.
* ```alfresco.host``` - Specifies the externally resolvable host name of the web application.
* ```alfresco.port``` - Specifies the externally resolvable port number of the web application URL.


* ```aos.baseUrlOverwrite``` - http://localhost:8080/alfresco/aos

* ```messaging.broker.url``` - Specifies the ActiveMQ connector URL.

* ```deployment.method``` - Deployment method used to deploy this Alfresco instance (DEFAULT, INSTALLER, DOCKER_COMPOSE, HELM_CHART, ZIP, QUICK_START)

##### Transformers

* ```transform.service.enabled```=true
* ```transform.service.url```=http://transform-router:8095
* ```sfs.url```=http://shared-file-store:8099/
* ```localTransform.core-aio.url```=http://transform-core-aio:8090/
* ```alfresco-pdf-renderer.url```=http://transform-core-aio:8090/
* ```jodconverter.url```=http://transform-core-aio:8090/
* ```img.url```=http://transform-core-aio:8090/
* ```tika.url```=http://transform-core-aio:8090/
* ```transform.misc.url```=http://transform-core-aio:8090/
* ```csrf.filter.enabled``` - Enables/disables Cross-Site Request Forgery filters for repository (true/false)
* ```dsync.service.uris``` - Specifies the hostname of the Sync Service (or the load balancer hiding the Sync Service cluster) that Desktop Sync clients can see. For example, https://<hostname>:9090/alfresco.

#### Alfresco Share

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
