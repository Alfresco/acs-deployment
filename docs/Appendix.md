# WIP



## Alfresco Content Services

## Alfresco Digital Workspace
## Alfresco Share
## Alfresco Search Services
## Alfresco Sync Service

repo.scheme 	Specifies the repository URL scheme. The default value is http repo.scheme.
repo.hostname 	Specifies the repository hostname. The default value is localhost.
messaging.broker.host 	Specifies the ActiveMQ broker hostname.
messaging.broker.port 	Specifies the ActiveMQ broker port.
sql.db.url 	Specifies the sync database URL.
sql.db.username 	Specifies the sync database username.
sql.db.password 	Specifies the sync database password.


|Property|Description|
|:---|:---|
|repo.scheme|Specifies the repository URL scheme. The default value is http repo.scheme.|
|repo.hostname|Specifies the repository hostname. The default value is localhost.|
|messaging.broker.host|Specifies the ActiveMQ broker hostname.|
|messaging.broker.port|Specifies the ActiveMQ broker port.|
|sql.db.url|Specifies the sync database URL.|
|sql.db.username|Specifies the sync database username.|
|sql.db.password|Specifies the sync database password.|

## Alfresco Process Service


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
