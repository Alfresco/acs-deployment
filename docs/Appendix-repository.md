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
| system.webdav.renameShufflePattern | File name patterns that trigger rename shuffle detection. Pattern is used by move - tested against full path after it has been lower cased. | `(.*/\\..*)|(.*[a-f0-9]{8}+$)|(.*\\.tmp$)|(.*atmp[0-9]+$)|(.*\\.wbk$)|(.*\\.bak$)|(.*\\~$)|(.*backup.*\\.do[ct]{1}[x]?[m]?$)|(.*\\.sb\\-\\w{8}\\-\\w{6}$)` |
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
| system.preserve.modificationData | DEPRECATED: Use `system.auditableData.preserve` | false |
| system.auditableData.preserve | The default to preserve all cm:auditable data on a node when the process is not directly driven by a user action. | ${system.preserve.modificationData} |
| system.auditableData.FileFolderService | Specific control of how the FileFolderService treats cm:auditable data when performing moves | ${system.auditableData.preserve} |
| system.auditableData.ACLs | Specific control of whether ACL changes on a node trigger the cm:auditable aspect | ${system.auditableData.preserve} |
| system.readpermissions.optimise | Property to control read permission evaluation for acegi | true |
| system.readpermissions.bulkfetchsize | Property to control read permission evaluation for acegi | 1000 |
| system.maximumStringLength | Manually control how the system handles maximum string lengths. Any zero or negative value is ignored. Only change this after consulting support or reading the appropriate Javadocs for org.alfresco.repo.domain.schema.SchemaBootstrap for V2.1.2. Before database migration, the string value storage may need to be adjusted using the scheduled job | -1 |
| system.maximumStringLength.jobCronExpression |  | `* * * * * ? 2099` |
| system.maximumStringLength.jobQueryRange |  | 10000 |
| system.maximumStringLength.jobThreadCount |  | 4 |
| system.hibernateMaxExecutions | Limit hibernate session size by trying to amalgamate events for the L2 session invalidation. *1.* Hibernate works as is up to this size. *2.* After the limit is hit events that can be grouped invalidate the L2 cache by type and not instance. Events may not group if there are post action listener registered (this is not the case with the default distribution) | 20000 |
| system.enableTimestampPropagation | Determine if modification timestamp propagation from child to parent nodes is respected or not. Even if 'true', the functionality is only supported for child associations that declare the 'propagateTimestamps' element in the dictionary definition. | true |
| system.integrity.enabled | Enable system model integrity checking. WARNING: Changing this is unsupported; bugs may corrupt data | true |
| system.integrity.failOnViolation | Do integrity violations fail transactions. WARNING: Changing this is unsupported; bugs may corrupt data | true |
| system.integrity.maxErrorsPerTransaction | The number of errors to report when violations are detected | 5 |
| system.integrity.trace | Add call stacks to integrity events so that errors are logged with possible causes. WARNING: This is expensive and should only be switched on for diagnostic purposes | false |
| system.content.eagerOrphanCleanup | Decide if content should be removed from the system immediately after being orphaned. Do not change this unless you have examined the impact it has on your backup procedures. | false |
| system.content.orphanProtectDays | The number of days to keep orphaned content in the content stores. This has no effect on the 'deleted' content stores, which are not automatically emptied. | 14 |
| system.content.deletionFailureAction | The action to take when a store or stores fails to delete orphaned content. IGNORE: Just log a warning. The binary remains and the record is expunged. KEEP_URL: Log a warning and create a URL entry with orphan time 0. It won't be processed or removed. | IGNORE |
| system.content.orphanCleanup.cronExpression | The CRON expression to trigger the deletion of resources associated with orphaned content. | `0 0 4 * * ?` |
| lucene.maxAtomicTransformationTime | Millisecond threshold for text transformations. Slower transformers will force the text extraction to be asynchronous | 100 |
| lucene.query.maxClauses | The maximum number of clauses that are allowed in a lucene query  | 10000 |
| lucene.indexer.batchSize | The size of the queue of nodes waiting for index. Events are generated as nodes are changed, this is the maximum size of the queue used to coalesce event. When this size is reached the lists of nodes will be indexed. <http://issues.alfresco.com/browse/AR-1280>:  Setting this high is the workaround as of 1.4.3.  | 1000000 |
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
| index.backup.cronExpression |  | `0 0 3 * * ?` |
| lucene.defaultAnalyserResourceBundleName |  | alfresco/model/dataTypeAnalyzers |
| transformer.Archive.includeContents | When transforming archive files (.zip etc) into text representations (such as for full text indexing), should the files within the archive be processed too? If enabled, transformation takes longer, but searches of the files find more. | false |
| db.schema.name | Database configuration |  |
| db.schema.stopAfterSchemaBootstrap | Database configuration | false |
| db.schema.update | Database configuration | true |
| db.schema.update.lockRetryCount | Database configuration | 24 |
| db.schema.update.lockRetryWaitSeconds | Database configuration |  |
| db.schema.update.lockRetryWaitSeconds| Database configuration | 5 |
| db.driver | Database configuration | org.gjt.mm.mysql.Driver |
| db.name | Database configuration | alfresco |
| db.url | Database configuration | jdbc:mysql:///${db.name} |
| db.username | Database configuration | alfresco |
| db.password | Database configuration | alfresco |
| db.pool.initial | Database configuration | 10 |
| db.pool.max | Database configuration | 275 |
| db.txn.isolation | Database configuration | -1 |
| db.pool.statements.enable | Database configuration | true |
| db.pool.statements.max | Database configuration | 40 |
| db.pool.min | Database configuration | 10 |
| db.pool.idle | Database configuration | 10 |
| db.pool.wait.max | Database configuration | 5000 |
| db.pool.validate.query | Database configuration |  |
| db.pool.evict.interval | Database configuration | 600000 |
| db.pool.evict.idle.min | Database configuration | 1800000 |
| db.pool.evict.num.tests | note: for `db.pool.evict.num.tests` see <http://commons.apache.org/dbcp/configuration.html> (numTestsPerEvictionRun) and also following extract from "org.apache.commons.pool.impl.GenericKeyedObjectPool" (1.5.5). The number of objects to examine during each run of the idle object evictor thread (if any). When a negative value is supplied, `ceil({@link #getNumIdle})/abs({@link #getNumTestsPerEvictionRun})` tests will be run.  I.e., when the value is `-n`, roughly one `n`th of the idle objects will be tested per run. | -1 |
| db.pool.evict.validate | Database configuration | false |
| db.pool.validate.borrow | Database configuration | true |
| db.pool.validate.return | Database configuration | false |
| db.pool.abandoned.detect | Database configuration | false |
| db.pool.abandoned.time | Database configuration | 300 |
| db.pool.abandoned.log | `db.pool.abandoned.log=true` (logAbandoned) adds overhead (<http://commons.apache.org/dbcp/configuration.html>) and also requires db.pool.abandoned.detect=true (removeAbandoned) | false |
| audit.enabled | Audit configuration | true |
| audit.tagging.enabled | Audit configuration | true |
| audit.alfresco-access.enabled | Audit configuration | false |
| audit.alfresco-access.sub-actions.enabled | Audit configuration | false |
| audit.cmischangelog.enabled | Audit configuration | false |
| audit.dod5015.enabled | Audit configuration | false |
| audit.config.strict | Setting this flag to true will force startup failure when invalid audit configurations are detected. | false |
| audit.filter.alfresco-access.default.enabled | Audit map filter for AccessAuditor - restricts recorded events to user driven events | false |
| audit.filter.alfresco-access.transaction.user | Audit configuration | ~System;~null;.* |
| audit.filter.alfresco-access.transaction.type | Audit configuration | cm:folder;cm:content;st:site |
| audit.filter.alfresco-access.transaction.path | Audit configuration | \~/sys:archivedItem;~/ver:;.* |
| system.store | System Configuration | system://system |
| system.descriptor.childname | System Configuration | sys:descriptor |
| system.descriptor.current.childname | System Configuration | sys:descriptor-current |
| alfresco_user_store.store | User config | user://alfrescoUserStore |
| alfresco_user_store.system_container.childname | User config | sys:system |
| alfresco_user_store.user_container.childname | User config | sys:people |
| alfresco_user_store.adminusername | Note: default admin username - should not be changed after installation | admin |
| alfresco_user_store.adminpassword | Initial password - editing this will not have any effect once the repository is installed | 209c6174da490caeb422f3fa5a7ae634 |
| alfresco_user_store.guestusername | Note: default guest username - should not be changed after installation | guest |
| home_folder_provider_synchronizer.enabled | Used to move home folders to a new location | false |
| home_folder_provider_synchronizer.override_provider | Used to move home folders to a new location |  |
| home_folder_provider_synchronizer.keep_empty_parents | Used to move home folders to a new location | false |
| spaces.archive.store | Spaces Archive Configuration | archive://SpacesStore |
| spaces.store | Spaces Configuration | workspace://SpacesStore |
| spaces.company_home.childname | Spaces Configuration | app:company_home |
| spaces.guest_home.childname | Spaces Configuration | app:guest_home |
| spaces.dictionary.childname | Spaces Configuration | app:dictionary |
| spaces.templates.childname | Spaces Configuration | app:space_templates |
| spaces.imap_attachments.childname | Spaces Configuration | cm:Imap Attachments |
| spaces.imap_home.childname | Spaces Configuration | cm:Imap Home |
| spaces.imapConfig.childname | Spaces Configuration | app:imap_configs |
| spaces.imap_templates.childname | Spaces Configuration | app:imap_templates |
| spaces.scheduled_actions.childname | Spaces Configuration | cm:Scheduled Actions |
| spaces.emailActions.childname | Spaces Configuration | app:email_actions |
| spaces.searchAction.childname | Spaces Configuration | cm:search |
| spaces.templates.content.childname | Spaces Configuration | app:content_templates |
| spaces.templates.email.childname | Spaces Configuration | app:email_templates |
| spaces.templates.email.invite1.childname | Spaces Configuration | app:invite_email_templates |
| spaces.templates.email.notify.childname | Spaces Configuration | app:notify_email_templates |
| spaces.templates.email.following.childname | Spaces Configuration | app:following |
| spaces.templates.rss.childname | Spaces Configuration | app:rss_templates |
| spaces.savedsearches.childname | Spaces Configuration | app:saved_searches |
| spaces.scripts.childname | Spaces Configuration | app:scripts |
| spaces.content_forms.childname | Spaces Configuration | app:forms |
| spaces.user_homes.childname | Spaces Configuration | app:user_homes |
| spaces.user_homes.regex.key | Spaces Configuration | userName |
| spaces.user_homes.regex.pattern | Spaces Configuration |  |
| spaces.user_homes.regex.group_order | Spaces Configuration |  |
| spaces.sites.childname | Spaces Configuration | st:sites |
| spaces.templates.email.invite.childname | Spaces Configuration | cm:invite |
| spaces.templates.email.activities.childname | Spaces Configuration | cm:activities |
| spaces.rendition.rendering_actions.childname | Spaces Configuration | app:rendering_actions |
| spaces.replication.replication_actions.childname | Spaces Configuration | app:replication_actions |
| spaces.transfers.childname | Spaces Configuration | app:transfers |
| spaces.transfer_groups.childname | Spaces Configuration | app:transfer_groups |
| spaces.transfer_temp.childname | Spaces Configuration | app:temp |
| spaces.inbound_transfer_records.childname | Spaces Configuration | app:inbound_transfer_records |
| spaces.webscripts.childname | Spaces Configuration | cm:webscripts |
| spaces.extension_webscripts.childname | Spaces Configuration | cm:extensionwebscripts |
| spaces.models.childname | Spaces Configuration | app:models |
| spaces.workflow.definitions.childname | Spaces Configuration | app:workflow_defs |
| spaces.templates.email.workflowemailnotification.childname | Spaces Configuration | cm:workflownotification |
| spaces.nodetemplates.childname | Spaces Configuration | app:node_templates |
| spaces.shared.childname | Spaces Configuration | app:shared |
| spaces.solr_facets.root.childname | Spaces Configuration | srft:facets |
| spaces.smartfolders.childname | Spaces Configuration | app:smart_folders |
| spaces.smartdownloads.childname | Spaces Configuration | app:smart_downloads |
| spaces.transfer_summary_report.location | Spaces Configuration | \/${spaces.company_home.childname}/${spaces.dictionary.childname}/${spaces.transfers.childname}/${spaces.inbound_transfer_records.childname} |
| spaces.quickshare.link_expiry_actions.childname | Spaces Configuration | app:quick_share_link_expiry_actions |
| version.store.initialVersion | ADM VersionStore Configuration | true |
| version.store.enableAutoVersioning | ADM VersionStore Configuration | true |
| version.store.enableAutoVersionOnUpdateProps | ADM VersionStore Configuration | false |
| version.store.deprecated.lightWeightVersionStore | ADM VersionStore Configuration | workspace://lightWeightVersionStore |
| version.store.version2Store | ADM VersionStore Configuration | workspace://version2Store |
| version.store.versionComparatorClass | Optional Comparator\<Version\> class name to sort versions. Set to: org.alfresco.repo.version.common.VersionLabelComparator. If upgrading from a version that used unordered sequences in a cluster.  |  |
| system.system_container.childname | Folders for storing people | sys:system |
| system.people_container.childname | Folders for storing people | sys:people |
| system.authorities_container.childname | Folders for storing people | sys:authorities |
| system.zones_container.childname | Folders for storing people | sys:zones |
| system.workflow_container.childname | Folders for storing workflow related info | sys:workflow |
| system.remote_credentials_container.childname | Folder for storing shared remote credentials | sys:remote_credentials |
| system.syncset_definition_container.childname | Folder for storing syncset definitions | sys:syncset_definitions |
| system.downloads_container.childname | Folder for storing download archives | sys:downloads |
| system.certificate_container.childname | Folder for storing IdP's certificate definitions | sys:samlcertificate |
| user.name.caseSensitive | Are user names case sensitive? | false |
| domain.name.caseSensitive | Are domain names case sensitive? | false |
| domain.separator |  |  |
| xforms.formatCaption | Format caption extracted from the XML Schema. | true |
| system.usages.enabled | ECM content usages/quotas | false |
| system.usages.clearBatchSize | ECM content usages/quotas | 0 |
| system.usages.updateBatchSize | ECM content usages/quotas | 50 |
| repo.remote.endpoint | Repository endpoint - used by Activity Service | /service |
| create.missing.people | Some authentication mechanisms may need to create people in the repository on demand. This enables that feature. If disabled an error will be generated for missing people. If enabled then a person will be created and persisted. | ${server.transaction.allow-writes} |
| home.folder.creation.eager | Create home folders (unless disabled, see next property) as people are created (true) or create them lazily (false) | true |
| home.folder.creation.disabled | Disable home folder creation - if true then home folders are not created (neither eagerly nor lazily) | false |
| policy.content.update.ignoreEmpty | Should we consider zero byte content to be the same as no content when firing content update policies? Prevents 'premature' firing of inbound content rules for some clients such as Mac OS X Finder | true |
| alfresco.rmi.services.port | Default value of alfresco.rmi.services.host is 0.0.0.0 which means 'listen on all adapters'. This allows connections to JMX both remotely and locally. | 50500 |
| alfresco.rmi.services.external.host |  | localhost |
| alfresco.rmi.services.host |  | 0.0.0.0 |
| alfresco.rmi.services.retries | If the RMI address is in-use, how many retries should be done before aborting. Default value of alfresco.rmi.services.retries is 0 which means 'Don't retry if the address is in-use'. | 4 |
| alfresco.rmi.services.retryInterval | How long in milliseconds to wait after a failed server socket bind, before retrying | 250 |
| monitor.rmi.service.port | RMI service ports for the individual services. These eight services are available remotely. Assign individual ports for each service for best performance or run several services on the same port, you can even run everything on 50500 if running through a firewall. Specify 0 to use a random unused port. | 50508 |
| monitor.rmi.service.enabled | enable or disable individual RMI services | false |
| mbean.server.locateExistingServerIfPossible | Should the Mbean server bind to an existing server. Set to true for most application servers. false for WebSphere clusters. | true |
| img.root | External executable locations | ./ImageMagick |
| img.dyn | External executable locations | ${img.root}/lib |
| img.exe | External executable locations | ${img.root}/bin/convert |
| img.url | Legacy imageMagick transformer url to T-Engine to service transform requests via http. Disabled by default. |  |
| img.startupRetryPeriodSeconds | When img.url is set, this value indicates the amount of time to wait after a connection failure before retrying the connection to allow a docker container to (re)start. | 60 |
| renditionService2.enabled | Rendition Service 2 | true |
| system.thumbnail.generate | Thumbnail Service | true |
| system.thumbnail.definition.default.timeoutMs | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.definition.default.readLimitTimeMs | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.definition.default.maxSourceSizeKBytes | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.definition.default.readLimitKBytes | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.definition.default.pageLimit | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | 1 |
| system.thumbnail.definition.default.maxPages | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.pdf | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.txt | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.docx | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.xlsx | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.pptx | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.odt | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.ods | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.odp | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.retryPeriod | Configuration for handling of failing thumbnails. See NodeEligibleForRethumbnailingEvaluator's javadoc for details. Retry periods limit the frequency with which the repository will attempt to create Share thumbnails for content nodes which have previously failed in their thumbnail attempts. These periods are in seconds. `604800s = 60s * 60m * 24h * 7d = 1 week` | 60 |
| system.thumbnail.retryCount | Configuration for handling of failing thumbnails | 2 |
| system.thumbnail.quietPeriod | Configuration for handling of failing thumbnails | 604800 |
| system.thumbnail.quietPeriodRetriesEnabled | Configuration for handling of failing thumbnails | true |
| system.thumbnail.redeployStaticDefsOnStartup | Configuration for handling of failing thumbnails | true |
| content.metadataExtracter.default.timeoutMs | The default timeout for metadata mapping extracters | 20000 |
| tika.url | Legacy tika url to T-Engines to service transform requests via http. Disabled by default. |  |
| transform.misc.url | Legacy misc transformer url to T-Engines to service transform requests via http. Disabled by default. |  |
| tika.startupRetryPeriodSeconds | When the legacy tika .url is set, this value indicates the amount of time to wait after a connection failure before retrying the connection to allow a docker container to (re)start. | 60 |
| transform.misc.startupRetryPeriodSeconds | When the legacy misc transformer .url is set, this value indicates the amount of time to wait after a connection failure before retrying the connection to allow a docker container to (re)start. | 60 |
| localTransform.core-aio.url | Local transformer urls to T-engines to service transform requests via http. Enabled by default. | <http://localhost:8090/> |
| localTransform.core-aio.startupRetryPeriodSeconds | When a local transformer .url is set, this value indicates the amount of time to wait after a connection failure before retrying the connection to allow a docker container to (re)start. | 60 |
| content.metadataExtracter.pdf.maxDocumentSizeMB |  | 10 |
| content.metadataExtracter.pdf.maxConcurrentExtractionsCount |  | 5 |
| content.metadataExtracter.pdf.overwritePolicy | The default overwrite policy for PdfBoxMetadataExtracter | PRAGMATIC |
| content.transformer.PdfBox.extractBookmarksText | True if bookmarks content should be extracted for PDFBox | true |
| V2.1-A.fixes.to.schema | Property to enable upgrade from 2.1-A | 0 |
| authentication.chain | The default authentication chain | alfrescoNtlm1:alfrescoNtlm |
| authentication.ticket.ticketsExpire | Do authentication tickets expire or live for ever? | true |
| authentication.ticket.expiryMode | If ticketsEpire is true then how they should expire? Valid values are: `AFTER_INACTIVITY`, `AFTER_FIXED_TIME`, `DO_NOT_EXPIRE`. The default is `AFTER_FIXED_TIME` | AFTER_INACTIVITY |
| authentication.ticket.validDuration | If `authentication.ticket.ticketsExpire` is true and `authentication.ticket.expiryMode` is `AFTER_FIXED_TIME` or `AFTER_INACTIVITY`, this controls the minimum period for which tickets are valid. The default is PT1H for one hour. | PT1H |
| authentication.ticket.useSingleTicketPerUser | Use one ticket for all user sessions. For the pre 4.2 behaviour of one ticket per session set this to false. | true |
| authentication.alwaysAllowBasicAuthForAdminConsole.enabled |  | true |
| authentication.getRemoteUserTimeoutMilliseconds |  | 10000 |
| ftp.enabled | FTP access | false |
| protocols.storeName | Default root path for protocols | ${spaces.store} |
| protocols.rootPath | Default root path for protocols | /${spaces.company_home.childname} |
| opencmis.connector.default.store | OpenCMIS property | ${spaces.store} |
| opencmis.connector.default.rootPath | OpenCMIS property | /${spaces.company_home.childname} |
| opencmis.connector.default.typesDefaultMaxItems | OpenCMIS property | 500 |
| opencmis.connector.default.typesDefaultDepth | OpenCMIS property | -1 |
| opencmis.connector.default.objectsDefaultMaxItems | OpenCMIS property | 10000 |
| opencmis.connector.default.objectsDefaultDepth | OpenCMIS property | 100 |
| opencmis.connector.default.contentChangesDefaultMaxItems | OpenCMIS property | 10000 |
| opencmis.connector.default.openHttpSession | OpenCMIS property | false |
| opencmis.activities.enabled | OpenCMIS property | true |
| opencmis.bulkUpdateProperties.maxItemsSize | OpenCMIS property | 1000 |
| opencmis.bulkUpdateProperties.batchSize | OpenCMIS property | 20 |
| opencmis.bulkUpdateProperties.workerThreads | OpenCMIS property | 2 |
| opencmis.maxContentSizeMB | OpenCMIS property | 4096 |
| opencmis.memoryThresholdKB | OpenCMIS property | 4096 |
| opencmis.context.override | URL generation overrides. If true, the context path of OpenCMIS generated urls will be set to "opencmis.context.value", otherwise it will be taken from the request url | false |
| opencmis.context.value | URL generation overrides |  |
| opencmis.servletpath.override | If true, the servlet path of OpenCMIS generated urls will be set to "opencmis.servletpath.value", otherwise it will be taken from the request url | false |
| opencmis.servletpath.value | URL generation overrides |  |
| opencmis.server.override | URL generation overrides | false |
| opencmis.server.value | URL generation overrides |  |
| imap.server.enabled | IMAP property | false |
| imap.server.port | IMAP property | 143 |
| imap.server.attachments.extraction.enabled | IMAP property | true |
| imap.config.home.store | Default IMAP mount points | ${spaces.store} |
| imap.config.home.rootPath | Default IMAP mount points | /${spaces.company_home.childname} |
| imap.config.home.folderPath | Default IMAP mount points | ${spaces.imap_home.childname} |
| imap.config.server.mountPoints | Default IMAP mount points | AlfrescoIMAP |
| imap.config.server.mountPoints.default.mountPointName | Default IMAP mount points | IMAP |
| imap.config.server.mountPoints.default.modeName | Default IMAP mount points | ARCHIVE |
| imap.config.server.mountPoints.default.store | Default IMAP mount points | ${spaces.store} |
| imap.config.server.mountPoints.default.rootPath | Default IMAP mount points | ${protocols.rootPath} |
| imap.config.server.mountPoints.value.AlfrescoIMAP.mountPointName | Default IMAP mount points | Alfresco IMAP |
| imap.config.server.mountPoints.value.AlfrescoIMAP.modeName | Default IMAP mount points | MIXED |
| imap.attachments.mode | `SEPARATE` -- All attachments for each email will be extracted to separate folder. `COMMON` -- All attachments for all emails will be extracted to one folder. `SAME` -- Attachments will be extracted to the same folder where email lies. | SEPARATE |
| imap.attachments.folder.store | Imap extraction settings | ${spaces.store} |
| imap.attachments.folder.rootPath | Imap extraction settings | /${spaces.company_home.childname} |
| imap.attachments.folder.folderPath | Imap extraction settings | ${spaces.imap_attachments.childname} |
| activities.feed.max.idRange | Feed max ID range to limit maximum number of entries | 1000000 |
| activities.feed.max.size | Feed max size (number of entries) | 200 |
| activities.feed.max.ageMins | Feed max age (eg. 44640 mins > 31 days) | 44640 |
| activities.feed.generator.jsonFormatOnly |  | true |
| activities.feed.fetchBatchSize |  | 250 |
| activities.feedNotifier.batchSize |  | 200 |
| activities.feedNotifier.numThreads |  | 2 |
| subsystems.test.beanProp.default.longProperty | Subsystem unit test values. Will not have any effect on production servers | 123456789123456789 |
| subsystems.test.beanProp.default.anotherStringProperty | Subsystem unit test values. Will not have any effect on production servers | Global Default |
| subsystems.test.beanProp | Subsystem unit test values. Will not have any effect on production servers | inst1,inst2,inst3 |
| subsystems.test.beanProp.value.inst2.boolProperty | Subsystem unit test values. Will not have any effect on production servers | true |
| subsystems.test.beanProp.value.inst3.anotherStringProperty | Subsystem unit test values. Will not have any effect on production servers | Global Instance Default |
| subsystems.test.simpleProp2 | Subsystem unit test values. Will not have any effect on production servers | true |
| subsystems.test.simpleProp3 | Subsystem unit test values. Will not have any effect on production servers | Global Default3 |
| default.async.action.threadPriority | Default Async Action Thread Pool | 1 |
| default.async.action.corePoolSize | Default Async Action Thread Pool | 8 |
| default.async.action.maximumPoolSize | Default Async Action Thread Pool | 20 |
| deployment.service.numberOfSendingThreads | Deployment Service | 5 |
| deployment.service.corePoolSize | Deployment Service | 2 |
| deployment.service.maximumPoolSize | Deployment Service | 3 |
| deployment.service.threadPriority | Deployment Service | 5 |
| deployment.service.targetLockRefreshTime | How long to wait in mS before refreshing a target lock - detects shutdown servers | 60000 |
| deployment.service.targetLockTimeout | How long to wait in mS from the last communication before deciding that deployment has failed, possibly the destination is no longer available? | 3600000 |
| deployment.method | Deployment method used to deploy this Alfresco instance (`DEFAULT`, `INSTALLER`, `DOCKER_COMPOSE`, `HELM_CHART`, `ZIP`, `QUICK_START`) | DEFAULT |
| notification.email.siteinvite | Should send emails as part of invitation process. | true |
| site.invite.moderated.workflowId | Moderated invite Activiti workflow | activiti$activitiInvitationModerated |
| site.invite.nominated.workflowId | Add intneral users Activiti workflow (use activiti$activitiInvitationNominated to revert to requiring accept of invite for internal users) | activiti$activitiInvitationNominatedAddDirect |
| site.invite.nominatedExternal.workflowId | Add external users Activiti workflow | activiti$activitiInvitationNominated |
| replication.enabled | Replication Service | false |
| transferservice.receiver.enabled | Transfer Service | false |
| transferservice.receiver.stagingDir | Transfer Service | ${java.io.tmpdir}/alfresco-transfer-staging |
| transferservice.receiver.lockRefreshTime | How long to wait in mS before refreshing a transfer lock - detects shutdown servers. Default 1 minute. | 60000 |
| transferservice.receiver.lockRetryCount | How many times to attempt retry the transfer lock | 3 |
| transferservice.receiver.lockRetryWait | How long to wait, in mS, before retrying the transfer lock | 100 |
| transferservice.receiver.lockTimeOut | How long to wait, in mS, since the last contact with from the client before timing out a transfer. Needs to be long enough to cope with network delays and "thinking time" for both source and destination. Default 5 minutes. | 300000 |
| orphanReaper.lockRefreshTime | OrphanReaper | 60000 |
| orphanReaper.lockTimeOut | OrphanReaper | 3600000 |
| security.anyDenyDenies | Security | true |
| security.postProcessDenies | Whether to post-process denies. Only applies to solr4+ when `anyDenyDenies` is true. | false |
| dir.keystore | Encryption properties. Default keystores location | classpath:alfresco/keystore |
| encryption.keySpec.class | General encryption parameters | org.alfresco.encryption.DESEDEKeyGenerator |
| encryption.keyAlgorithm | General encryption parameters | AES |
| encryption.cipherAlgorithm | General encryption parameters | AES/CBC/PKCS5Padding |
| encryption.keystore.location | Secret key keystore configuration | ${dir.keystore}/keystore |
| encryption.keystore.keyMetaData.location | Configuration via metadata is deprecated |  |
| encryption.keystore.provider |  |  |
| encryption.keystore.type |  | pkcs12 |
| encryption.keystore.backup.location | Backup secret key keystore configuration | ${dir.keystore}/backup-keystore |
| encryption.keystore.backup.keyMetaData.location | Configuration via metadata is deprecated |  |
| encryption.keystore.backup.provider |  |  |
| encryption.keystore.backup.type |  | pkcs12 |
| encryption.bootstrap.reencrypt | Should encryptable properties be re-encrypted with new encryption keys on botstrap? | false |
| encryption.mac.messageTimeout | mac/md5 encryption | 30000 |
| encryption.mac.algorithm | mac/md5 encryption | HmacSHA1 |
| encryption.ssl.keystore.location | ssl encryption | ${dir.keystore}/ssl.keystore |
| encryption.ssl.keystore.provider | ssl encryption |  |
| encryption.ssl.keystore.type | ssl encryption | JCEKS |
| encryption.ssl.keystore.keyMetaData.location | Configuration via metadata is deprecated |  |
| encryption.ssl.truststore.location |  | ${dir.keystore}/ssl.truststore |
| encryption.ssl.truststore.provider |  |  |
| encryption.ssl.truststore.type |  | JCEKS |
| encryption.ssl.truststore.keyMetaData.location | Configuration via metadata is deprecated |  |
| encryption.reencryptor.chunkSize | Re-encryptor properties | 100 |
| encryption.reencryptor.numThreads | Re-encryptor properties | 2 |
| solr.host | SOLR connection details (e.g. for JMX) | localhost |
| solr.port | SOLR connection details (e.g. for JMX) | 8983 |
| solr.port.ssl | SOLR connection details (e.g. for JMX) | 8984 |
| solr.solrUser | SOLR connection details (e.g. for JMX) | solr |
| solr.solrPassword | SOLR connection details (e.g. for JMX) | solr |
| solr.secureComms | SOLR connection details (e.g. for JMX). `none`, `https` | https |
| solr.cmis.alternativeDictionary | SOLR connection details (e.g. for JMX) | DEFAULT_DICTIONARY |
| solr.max.total.connections | SOLR connection details (e.g. for JMX) | 40 |
| solr.max.host.connections | SOLR connection details (e.g. for JMX) | 40 |
| solr.solrConnectTimeout | Solr connect timeout in ms | 5000 |
| solr.solrPingCronExpression | cron expression defining how often the Solr Admin client (used by JMX) pings Solr if it goes away | `0 0/5 * * * ? *` |
| solr.store.mappings | Default SOLR store mappings mappings | solrMappingAlfresco,solrMappingArchive |
| solr.store.mappings.value.solrMappingAlfresco.httpClientFactory | Default SOLR store mappings mappings | solrHttpClientFactory |
| solr.store.mappings.value.solrMappingAlfresco.baseUrl | Default SOLR store mappings mappings | /solr/alfresco |
| solr.store.mappings.value.solrMappingAlfresco.protocol | Default SOLR store mappings mappings | workspace |
| solr.store.mappings.value.solrMappingAlfresco.identifier | Default SOLR store mappings mappings | SpacesStore |
| solr.store.mappings.value.solrMappingArchive.httpClientFactory | Default SOLR store mappings mappings | solrHttpClientFactory |
| solr.store.mappings.value.solrMappingArchive.baseUrl | Default SOLR store mappings mappings | /solr/archive |
| solr.store.mappings.value.solrMappingArchive.protocol | Default SOLR store mappings mappings | archive |
| solr.store.mappings.value.solrMappingArchive.identifier | Default SOLR store mappings mappings | SpacesStore |
| solr4.store.mappings | Default SOLR 4 store mappings mappings | solrMappingAlfresco,solrMappingArchive |
| solr4.store.mappings.value.solrMappingAlfresco.httpClientFactory | Default SOLR 4 store mappings mappings | solrHttpClientFactory |
| solr4.store.mappings.value.solrMappingAlfresco.baseUrl | Default SOLR 4 store mappings mappings | /solr4/alfresco |
| solr4.store.mappings.value.solrMappingAlfresco.protocol | Default SOLR 4 store mappings mappings | workspace |
| solr4.store.mappings.value.solrMappingAlfresco.identifier | Default SOLR 4 store mappings mappings | SpacesStore |
| solr4.store.mappings.value.solrMappingArchive.httpClientFactory | Default SOLR 4 store mappings mappings | solrHttpClientFactory |
| solr4.store.mappings.value.solrMappingArchive.baseUrl | Default SOLR 4 store mappings mappings | /solr4/archive |
| solr4.store.mappings.value.solrMappingArchive.protocol | Default SOLR 4 store mappings mappings | archive |
| solr4.store.mappings.value.solrMappingArchive.identifier | Default SOLR 4 store mappings mappings | SpacesStore |
| solr6.store.mappings | Default SOLR 6 store mappings mappings | solrMappingAlfresco,solrMappingArchive,solrMappingHistory |
| solr6.store.mappings.value.solrMappingAlfresco.httpClientFactory | Default SOLR 6 store mappings mappings | solrHttpClientFactory |
| solr6.store.mappings.value.solrMappingAlfresco.baseUrl | Default SOLR 6 store mappings mappings | /solr/alfresco |
| solr6.store.mappings.value.solrMappingAlfresco.protocol | Default SOLR 6 store mappings mappings | workspace |
| solr6.store.mappings.value.solrMappingAlfresco.identifier | Default SOLR 6 store mappings mappings | SpacesStore |
| solr6.store.mappings.value.solrMappingArchive.httpClientFactory | Default SOLR 6 store mappings mappings | solrHttpClientFactory |
| solr6.store.mappings.value.solrMappingArchive.baseUrl | Default SOLR 6 store mappings mappings | /solr/archive |
| solr6.store.mappings.value.solrMappingArchive.protocol | Default SOLR 6 store mappings mappings | archive |
| solr6.store.mappings.value.solrMappingArchive.identifier | Default SOLR 6 store mappings mappings | SpacesStore |
| solr6.store.mappings.value.solrMappingHistory.httpClientFactory | Default SOLR 6 store mappings mappings | solrHttpClientFactory |
| solr6.store.mappings.value.solrMappingHistory.baseUrl | Default SOLR 6 store mappings mappings | /solr/history |
| solr6.store.mappings.value.solrMappingHistory.protocol | Default SOLR 6 store mappings mappings | workspace |
| solr6.store.mappings.value.solrMappingHistory.identifier | Default SOLR 6 store mappings mappings | history |
| urlshortening.bitly.username | URL Shortening Properties | brianalfresco |
| urlshortening.bitly.api.key | URL Shortening Properties | R_ca15c6c89e9b25ccd170bafd209a0d4f |
| urlshortening.bitly.url.length | URL Shortening Properties | 20 |
| bulkImport.batch.numThreads | Bulk Filesystem Importer. The number of threads to employ in a batch import | 4 |
| bulkImport.batch.batchSize | The size of a batch in a batch import i.e. the number of files to import in a transaction/thread | 20 |
| system.content.caching.cacheOnInbound | Caching Content Store | true |
| system.content.caching.maxDeleteWatchCount | Caching Content Store | 1 |
| system.content.caching.contentCleanup.cronExpression | Clean up every day at 3 am | `0 0 3 * * ?` |
| system.content.caching.minFileAgeMillis |  | 60000 |
| system.content.caching.maxUsageMB |  | 4096 |
| system.content.caching.maxFileSizeMB | maxFileSizeMB - 0 means no max file size. | 0 |
| system.content.caching.panicThresholdPct | When the CachingContentStore is about to write a cache file but the disk usage is in excess of panicThresholdPct (default 90%) then the cache file is not written and the cleaner is started (if not already running) in a new thread. | 90 |
| system.content.caching.cleanThresholdPct | When a cache file has been written that results in cleanThresholdPct (default 80%) of maxUsageBytes being exceeded then the cached content cleaner is invoked (if not already running) in a new thread. | 80 |
| system.content.caching.targetUsagePct | An aggressive cleaner is run till the targetUsagePct (default 70%) of maxUsageBytes is achieved | 70 |
| system.content.caching.normalCleanThresholdSec | Threshold in seconds indicating a minimal gap between normal cleanup starts | 0 |
| mybatis.useLocalCaches |  | false |
| fileFolderService.checkHidden.enabled |  | true |
| ticket.cleanup.cronExpression |  | `0 0 * * * ?` |
| download.cleaner.startDelayMilliseconds | Download Service Cleanup | 3600000 |
| download.cleaner.repeatIntervalMilliseconds | Download Service Cleanup | 3600000 |
| download.cleaner.maxAgeMins | Download Service Cleanup | 60 |
| download.cleaner.batchSize | Download Service Cleanup. -1 or 0 for not using batches | 1000 |
| download.cleaner.cleanAllSysDownloadFolders | You could set this to false for new installations greater then ACS 6.2 see MNT-20212 | true |
| download.maxContentSize | Download Service Limits, in bytes | 2152852358 |
| trashcan.MaxSize | Max size of view trashcan files | 1000 |
| authority.useBridgeTable | Use bridge tables for caching authority evaluation. | true |
| authority.findAuthorityLimit | Limit the number of results from findAuthority query | 10000 |
| system.quickshare.enabled | Enable QuickShare - if false then the QuickShare-specific REST APIs will return 403 Forbidden | true |
| system.quickshare.email.from.default |  | noreply@alfresco.com |
| system.quickshare.expiry_date.enforce.minimum.period | By default the difference between the quick share expiry date and the current time must be at least 1 day (24 hours). However, this can be changed to at least 1 hour or 1 minute for testing purposes. For example, setting the value to MINUTES, means the service will calculate the difference between NOW and the given expiry date in terms of minutes and checks for the difference to be greater than 1 minute. `DAYS` | `HOURS` | `MINUTES` | DAYS |
| mail.service.corePoolSize | Oubound Mail | 8 |
| mail.service.maximumPoolSize | Oubound Mail | 20 |
| nodes.bulkLoad.cachingThreshold |  | 10 |
| dir.contentstore.tenants | Multi-Tenancy. If `dir.contentstore.tenants` is set then tenants are not co-mingled and all content roots will appear below this container (in \<tenantdomain\> sub-folder) and when creating a tenant the `contentRootPath` (root content store directory for a given tenant) will be ignored |  |
| alfresco.authentication.gateway.host | Gateway authentication is disabled if empty host is specified |  |
| alfresco.authentication.gateway.protocol | Gateway Authentication | https |
| alfresco.authentication.gateway.port | Gateway Authentication | 443 |
| alfresco.authentication.gateway.outboundHeaders | Gateway Authentication | Authorization,key |
| alfresco.authentication.gateway.inboundHeaders | Gateway Authentication | X-Alfresco-Authenticator-Key,X-Alfresco-Remote-User |
| alfresco.authentication.gateway.prefixUrl | Gateway Authentication | /publicapi |
| alfresco.authentication.gateway.bufferSize | Gateway Authentication | 2048 |
| alfresco.authentication.gateway.connectTimeout | Gateway Authentication | 10000 |
| alfresco.authentication.gateway.readTimeout | Gateway Authentication | 120000 |
| alfresco.authentication.gateway.httpTcpNodelay | Gateway Authentication | true |
| alfresco.authentication.gateway.httpConnectionStalecheck | Gateway Authentication | true |
| webscripts.encryptTempFiles | Webscripts config | false |
| webscripts.tempDirectoryName | Webscripts config | Alfresco-WebScripts |
| webscripts.memoryThreshold | Webscripts config (4mb) | 4194304 |
| webscripts.setMaxContentSize | Webscripts config (4gb) | 5368709120 |
| system.metadata-query-indexes.ignored | Property to enable index upgrade for metadata query (MDQ). The indexes are not added unless this value is changed. Adding each the supporting indexes may take several hours depending on the size of the database. The required indexes may be added in stages. See: `classpath:alfresco/dbscripts/upgrade/4.2/${db.script.dialect}/metadata-query-indexes.sql` . See: `classpath:alfresco/dbscripts/upgrade/5.1/${db.script.dialect}/metadata-query-indexes-2.sql` | true |
| system.metadata-query-indexes-more.ignored |  | true |
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

repo.scheme   Specifies the repository URL scheme. The default value is http repo.scheme.
repo.hostname  Specifies the repository hostname. The default value is localhost.
messaging.broker.host   Specifies the ActiveMQ broker hostname.
messaging.broker.port   Specifies the ActiveMQ broker port.
sql.db.url  Specifies the sync database URL.
sql.db.username  Specifies the sync database username.
sql.db.password   Specifies the sync database password.

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

### Alfresco Content Repository

#### Database configuration

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

* ```aos.baseUrlOverwrite``` - <http://localhost:8080/alfresco/aos>
* ```messaging.broker.url``` - Specifies the ActiveMQ connector URL.
* ```deployment.method``` - Deployment method used to deploy this Alfresco instance (DEFAULT, INSTALLER, DOCKER_COMPOSE, HELM_CHART, ZIP, QUICK_START)

##### Transformers

* ```transform.service.enabled```=true
* ```transform.service.url```=<http://transform-router:8095>
* ```sfs.url```=<http://shared-file-store:8099/>
* ```localTransform.core-aio.url```=<http://transform-core-aio:8090/>
* ```alfresco-pdf-renderer.url```=<http://transform-core-aio:8090/>
* ```jodconverter.url```=<http://transform-core-aio:8090/>
* ```img.url```=<http://transform-core-aio:8090/>
* ```tika.url```=<http://transform-core-aio:8090/>
* ```transform.misc.url```=<http://transform-core-aio:8090/>
* ```csrf.filter.enabled``` - Enables/disables Cross-Site Request Forgery filters for repository (true/false)
* ```dsync.service.uris``` - Specifies the hostname of the Sync Service (or the load balancer hiding the Sync Service cluster) that Desktop Sync clients can see. For example, `https://<hostname>:9090/alfresco`.
