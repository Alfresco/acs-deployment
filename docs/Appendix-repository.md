# WIP

| Property | Description | Default value |
|----------|-------------|---------------|
| repository.name | The name of the repository | Main Repository|
| version.schema | Schema number | 14001 |
| dir.root | Root folder path | ./alf_data |
| dir.contentstore | Content store folder path | ${dir.root}/contentstore |
| dir.contentstore.deleted | Content soter deleted folder path | ${dir.root}/contentstore.deleted |
| dir.contentstore.bucketsPerMinute |  | 0 |
| filecontentstore.subsystem.name | ContentStore subsystem: default choice | unencryptedContentStore |
| dir.cachedcontent | The location of cached content | ${dir.root}/cachedcontent |
| system.content.maximumFileSizeLimit | The value for the maximum permitted size in bytes of all content. No value (or a negative long) will be taken to mean that no limit should be applied. |  |
| system.serverMode | The server mode. Set value in alfresco-global.properties (UNKNOWN, TEST, BACKUP, PRODUCTION) | UNKNOWN |
| dir.indexes | The location for lucene index files | ${dir.root}/lucene-indexes |
| dir.indexes.backup | The location for index backups | ${dir.root}/backup-lucene-indexes |
| dir.indexes.lock | The location for lucene index locks | ${dir.indexes}/locks |
| dir.license.external | Directory to find external license | . |
| location.license.external | Spring resource location of external license files | file://${dir.license.external}/*.lic |
| location.license.embedded | Spring resource location of embedded license files | /WEB-INF/alfresco/license/*.lic |
| location.license.shared | Spring resource location of license files on shared classpath | classpath*:/alfresco/extension/license/*.lic |
| system.webdav.servlet.enabled | WebDAV initialization properties | true |
| system.webdav.url.path.prefix | WebDAV URL path prefix | "" |
| system.webdav.storeName | WebDAV store name | ${protocols.storeName} |
| system.webdav.rootPath | WebDAV root path | ${protocols.rootPath} |
| system.webdav.renameShufflePattern | File name patterns that trigger rename shuffle detection. Pattern is used by move - tested against full path after it has been lower cased. | ``(.*/\\..*)|(.*[a-f0-9]{8}+$)|(.*\\.tmp$)|(.*atmp[0-9]+$)|(.*\\.wbk$)|(.*\\.bak$)|(.*\\~$)|(.*backup.*\\.do[ct]{1}[x]?[m]?$)|(.*\\.sb\\-\\w{8}\\-\\w{6}$)`` |
| system.webdav.activities.enabled |  | false |
| system.workflow.jbpm.comment.property.max.length |  | -1 |
| system.workflow.comment.property.max.length |  | 4000 |
| system.workflow.engine.activiti.definitions.visible | Determines if Activiti definitions are visible | true |
| system.workflow.engine.activiti.enabled | Determines if the Activiti engine is enabled | true |
| system.workflow.engine.activiti.idblocksize |  | 100 |
| system.workflow.engine.activiti.taskvariableslimit |  | 20000 |
| system.workflow.deployWorkflowsInTenant | Determines if the workflows that are deployed to the activiti engine should be deployed in the tenant-context of the thread IF the tenant-service is enabled. If set to false, all workflows deployed will be shared among tenants. Recommended setting is true unless there is a good reason to not allow deploy tenant-specific worklfows when a MT-environment is set up. | true |
| system.workflow.engine.activiti.retentionHistoricProcessInstance | Determines if historic process instance are retained in case of canceling a process instance. | false |
| system.workflow.maxAuthoritiesForPooledTasks | The maximum number of groups to check for pooled tasks. For performance reasons, this is limited to 500 by default. | 500 |
| system.workflow.maxPooledTasks | The maximum number of pooled tasks to return in a query. It may be necessary to limit this depending on UI limitations. |  -1|
| system.workflow.maxGroupReviewers | The maximum number of reviewers for "Group Review and Approve" workflow. Use '0' for unlimited. | 0 |
| index.subsystem.name |  | noindex |
| index.tracking.minRecordPurgeAgeDays | Index tracking information of a certain age is cleaned out by a scheduled job. Any clustered system that has been offline for longer than this period will need to be seeded with a more recent backup of the Lucene indexes or the indexes will have to be fully rebuilt.Use -1 to disable purging. This can be switched on at any stage. | 30 |
| index.tracking.purgeSize | Unused transactions will be purged in chunks determined by commit time boundaries. 'index.tracking.purgeSize' specifies the size of the chunk (in ms). Default is a couple of hours. | 7200000 |
| system.bootstrap.config_check.strict | Change the failure behaviour of the configuration checker | true |
| shutdown.backstop.timeout | How long should shutdown wait to complete normally before taking stronger action and calling System.exit() in ms, 10,000 is 10 seconds | 10000 |
| shutdown.backstop.enabled |  | false |
| server.singleuseronly.name | Server Single User Mode. Note: only allow named user (if blank or not set then will allow all users) assuming maxusers is not set to 0 | admin |
| server.maxusers | Server Max Users - limit number of users with non-expired tickets. Note: -1 allows any number of users, assuming not in single-user mode 0 prevents further logins, including the ability to enter single-user mode. | -1 |
| system.cache.disableMutableSharedCaches | Disables mutable shared caches. This property is used for diagnostic purposes | false |
| system.cache.disableImmutableSharedCaches | Disables immutable shared caches. These property is used for diagnostic purposes | false |
| system.cache.parentAssocs.maxSize | The maximum capacity of the parent assocs cache (the number of nodes whose parents can be cached) | 130000 |
| system.cache.parentAssocs.limitFactor | The average number of parents expected per cache entry. This parameter is multiplied by the above value to compute a limit on the total number of cached parents, which will be proportional to the cache's memory usage. The cache will be pruned when this limit is exceeded to avoid excessive memory usage. | 8 |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |
|  |  |  |


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
