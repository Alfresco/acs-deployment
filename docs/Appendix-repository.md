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
| system.acl.maxPermissionCheckTimeMillis | Property to limit resources spent on individual searches. The maximum time spent pruning results. | 10000 |
| system.acl.maxPermissionChecks | Property to limit resources spent on individual searches.The maximum number of search results to perform permission checks against. | 1000 |
| system.filefolderservice.defaultListMaxResults | The maximum number of filefolder list results | 5000 |
| system.preserve.modificationData | DEPRECATED: Use 'system.auditableData.preserve' | false |
| system.auditableData.preserve | The default to preserve all cm:auditable data on a node when the process is not directly driven by a user action. | ${system.preserve.modificationData} |
| system.auditableData.FileFolderService | Specific control of how the FileFolderService treats cm:auditable data when performing moves | ${system.auditableData.preserve} |
| system.auditableData.ACLs | Specific control of whether ACL changes on a node trigger the cm:auditable aspect | ${system.auditableData.preserve} |
| system.readpermissions.optimise | Property to control read permission evaluation for acegi | true |
| system.readpermissions.bulkfetchsize | Property to control read permission evaluation for acegi | 1000 |
| system.maximumStringLength | Manually control how the system handles maximum string lengths. Any zero or negative value is ignored. Only change this after consulting support or reading the appropriate Javadocs for org.alfresco.repo.domain.schema.SchemaBootstrap for V2.1.2. Before database migration, the string value storage may need to be adjusted using the scheduled job | -1 |
| system.maximumStringLength.jobCronExpression |  | * * * * * ? 2099 |
| system.maximumStringLength.jobQueryRange |  | 10000 |
| system.maximumStringLength.jobThreadCount |  | 4 |
| system.hibernateMaxExecutions | Limit hibernate session size by trying to amalgamate events for the L2 session invalidation<br/>* hibernate works as is up to this size<br/>* after the limit is hit events that can be grouped invalidate the L2 cache by type and not instance.<br/>Events may not group if there are post action listener registered (this is not the case with the default distribution) | 20000 |
| system.enableTimestampPropagation | Determine if modification timestamp propagation from child to parent nodes is respected or not. Even if 'true', the functionality is only supported for child associations that declare the 'propagateTimestamps' element in the dictionary definition. | true |
| system.integrity.enabled | Enable system model integrity checking. WARNING: Changing this is unsupported; bugs may corrupt data | true |
| system.integrity.failOnViolation | Do integrity violations fail transactions. WARNING: Changing this is unsupported; bugs may corrupt data | true |
| system.integrity.maxErrorsPerTransaction | The number of errors to report when violations are detected | 5 |
| system.integrity.trace | Add call stacks to integrity events so that errors are logged with possible causes. WARNING: This is expensive and should only be switched on for diagnostic purposes | false |
| system.content.eagerOrphanCleanup | Decide if content should be removed from the system immediately after being orphaned. Do not change this unless you have examined the impact it has on your backup procedures. | false |
| system.content.orphanProtectDays | The number of days to keep orphaned content in the content stores. This has no effect on the 'deleted' content stores, which are not automatically emptied. | 14 |
| system.content.deletionFailureAction | The action to take when a store or stores fails to delete orphaned content. IGNORE: Just log a warning. The binary remains and the record is expunged. KEEP_URL: Log a warning and create a URL entry with orphan time 0. It won't be processed or removed. | IGNORE |
| system.content.orphanCleanup.cronExpression | The CRON expression to trigger the deletion of resources associated with orphaned content. | 0 0 4 * * ? |
| lucene.maxAtomicTransformationTime | Millisecond threshold for text transformations. Slower transformers will force the text extraction to be asynchronous | 100 |
| lucene.query.maxClauses | The maximum number of clauses that are allowed in a lucene query  | 10000 |
| lucene.indexer.batchSize | The size of the queue of nodes waiting for index. Events are generated as nodes are changed, this is the maximum size of the queue used to coalesce event. When this size is reached the lists of nodes will be indexed. http://issues.alfresco.com/browse/AR-1280:  Setting this high is the workaround as of 1.4.3.  | 1000000 |
| fts.indexer.batchSize |  | 1000 |
| lucene.indexer.cacheEnabled | Index cache sizes | true |
| lucene.indexer.maxDocIdCacheSize |  | 100000 |
| lucene.indexer.maxDocumentCacheSize |  | 100 |
| lucene.indexer.maxIsCategoryCacheSize |  | -1 |
| lucene.indexer.maxLinkAspectCacheSize |  | 10000 |
| lucene.indexer.maxParentCacheSize |  | 100000 |
| lucene.indexer.maxPathCacheSize |  | 100000 |
| lucene.indexer.maxTypeCacheSize |  | 10000 |
| lucene.indexer.mergerMaxMergeDocs | Properties for merge (not this does not affect the final index segment which will be optimised). Max merge docs only applies to the merge process not the resulting index which will be optimised. | 1000000 |
| lucene.indexer.mergerMergeFactor |  | 5 |
| lucene.indexer.mergerMaxBufferedDocs |  | -1 |
| lucene.indexer.mergerRamBufferSizeMb |  | 16 |
| lucene.indexer.writerMaxMergeDocs | Properties for delta indexes (not this does not affect the final index segment which will be optimised). Max merge docs only applies to the index building process not the resulting index which will be optimised. | 1000000 |
| lucene.indexer.writerMergeFactor |  | 5 |
| lucene.indexer.writerMaxBufferedDocs |  | -1 |
| lucene.indexer.writerRamBufferSizeMb |  | 16 |
| lucene.indexer.mergerTargetIndexCount | Target number of indexes and deltas in the overall index and what index size to merge in memory | 8 |
| lucene.indexer.mergerTargetOverlayCount |  | 5 |
| lucene.indexer.mergerTargetOverlaysBlockingFactor |  | 2 |
| lucene.indexer.maxDocsForInMemoryMerge |  | 60000 |
| lucene.indexer.maxRamInMbForInMemoryMerge |  | 16 |
| lucene.indexer.maxDocsForInMemoryIndex |  | 60000 |
| lucene.indexer.maxRamInMbForInMemoryIndex |  | 16 |
| lucene.indexer.termIndexInterval |  | 128 |
| lucene.indexer.useNioMemoryMapping |  | true |
| lucene.indexer.postSortDateTime | over-ride to false for pre 3.0 behaviour | true |
| lucene.indexer.defaultMLIndexAnalysisMode |  | EXACT_LANGUAGE_AND_ALL |
| lucene.indexer.defaultMLSearchAnalysisMode |  | EXACT_LANGUAGE_AND_ALL |
| lucene.indexer.maxFieldLength | The number of terms from a document that will be indexed | 10000 |
| lucene.indexer.fairLocking | Should we use a 'fair' locking policy, giving queue-like access behaviour to the indexes and avoiding starvation of waiting writers? Set to false on old JVMs where this appears to cause deadlock | true |
| lucene.write.lock.timeout | Index locks (mostly deprecated and will be tidied up with the next lucene upgrade) | 10000 |
| lucene.commit.lock.timeout |  | 100000 |
| lucene.lock.poll.interval |  | 100 |
| lucene.indexer.useInMemorySort |  | true |
| lucene.indexer.maxRawResultSetSizeForInMemorySort |  | 1000 |
| lucene.indexer.contentIndexingEnabled |  | true |
| index.backup.cronExpression |  | 0 0 3 * * ? |
| lucene.defaultAnalyserResourceBundleName |  | alfresco/model/dataTypeAnalyzers |
| transformer.Archive.includeContents | When transforming archive files (.zip etc) into text representations (such as for full text indexing), should the files within the archive be processed too? If enabled, transformation takes longer, but searches of the files find more. | false |
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
