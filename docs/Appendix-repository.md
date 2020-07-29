# WIP

| Name | Format | Description |
|------|--------|-------------|
| repository.name | E.g. Main Repository |The name of the repository|
| version.schema |E.g. 14001| Schema number |
| dir.root | Absolute path location | Directory configuration |
| dir.contentstore |E.g. ${dir.root}/contentstore| Directory configuration |
| dir.contentstore.deleted || Directory configuration |
| dir.contentstore.bucketsPerMinute || Directory configuration |
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
||||
# Repository configuration

repository.name=Main Repository

# Schema number
version.schema=14001

# Directory configuration

dir.root=./alf_data

dir.contentstore=${dir.root}/contentstore
dir.contentstore.deleted=${dir.root}/contentstore.deleted
dir.contentstore.bucketsPerMinute=0

# ContentStore subsystem: default choice
filecontentstore.subsystem.name=unencryptedContentStore

# The location of cached content
dir.cachedcontent=${dir.root}/cachedcontent

# The value for the maximum permitted size in bytes of all content.
# No value (or a negative long) will be taken to mean that no limit should be applied.
# See content-services-context.xml
system.content.maximumFileSizeLimit=

#
# The server mode. Set value in alfresco-global.properties
# UNKNOWN | TEST | BACKUP | PRODUCTION
#
system.serverMode=UNKNOWN

# The location for lucene index files
dir.indexes=${dir.root}/lucene-indexes

# The location for index backups
dir.indexes.backup=${dir.root}/backup-lucene-indexes

# The location for lucene index locks
dir.indexes.lock=${dir.indexes}/locks

#Directory to find external license
dir.license.external=.
# Spring resource location of external license files
location.license.external=file://${dir.license.external}/*.lic
# Spring resource location of embedded license files    
location.license.embedded=/WEB-INF/alfresco/license/*.lic
# Spring resource location of license files on shared classpath
location.license.shared=classpath*:/alfresco/extension/license/*.lic

# WebDAV initialization properties
system.webdav.servlet.enabled=true
system.webdav.url.path.prefix=
system.webdav.storeName=${protocols.storeName}
system.webdav.rootPath=${protocols.rootPath}
# File name patterns that trigger rename shuffle detection
# pattern is used by move - tested against full path after it has been lower cased.
system.webdav.renameShufflePattern=(.*/\\..*)|(.*[a-f0-9]{8}+$)|(.*\\.tmp$)|(.*atmp[0-9]+$)|(.*\\.wbk$)|(.*\\.bak$)|(.*\\~$)|(.*backup.*\\.do[ct]{1}[x]?[m]?$)|(.*\\.sb\\-\\w{8}\\-\\w{6}$)
system.webdav.activities.enabled=false


system.workflow.jbpm.comment.property.max.length=-1
system.workflow.comment.property.max.length=4000

#Determines if Activiti definitions are visible
system.workflow.engine.activiti.definitions.visible=true


# Determines if the Activiti engine is enabled
system.workflow.engine.activiti.enabled=true
system.workflow.engine.activiti.idblocksize=100
system.workflow.engine.activiti.taskvariableslimit=20000

# Determines if the workflows that are deployed to the activiti engine should 
# be deployed in the tenant-context of the thread IF the tenant-service is enabled
# If set to false, all workflows deployed will be shared among tenants. Recommended
# setting is true unless there is a good reason to not allow deploy tenant-specific 
# worklfows when a MT-environment is set up. 
system.workflow.deployWorkflowsInTenant=true
#Determines if historic process instance are retained in case of canceling a process instance
system.workflow.engine.activiti.retentionHistoricProcessInstance=false

# The maximum number of groups to check for pooled tasks. For performance
# reasons, this is limited to 500 by default.
system.workflow.maxAuthoritiesForPooledTasks=500

# The maximum number of pooled tasks to return in a query. It may be necessary
# to limit this depending on UI limitations.
system.workflow.maxPooledTasks=-1

# The maximum number of reviewers for "Group Review and Approve" workflow. 
# Use '0' for unlimited.
system.workflow.maxGroupReviewers=0

index.subsystem.name=noindex

# ######################################### #
# Index Tracking Configuration              #
# ######################################### #
#
# Index tracking information of a certain age is cleaned out by a scheduled job.
# Any clustered system that has been offline for longer than this period will need to be seeded
# with a more recent backup of the Lucene indexes or the indexes will have to be fully rebuilt.
# Use -1 to disable purging.  This can be switched on at any stage.
index.tracking.minRecordPurgeAgeDays=30
# Unused transactions will be purged in chunks determined by commit time boundaries. 'index.tracking.purgeSize' specifies the size
# of the chunk (in ms). Default is a couple of hours.
index.tracking.purgeSize=7200000

# Change the failure behaviour of the configuration checker
system.bootstrap.config_check.strict=true


#
# How long should shutdown wait to complete normally before 
# taking stronger action and calling System.exit()
# in ms, 10,000 is 10 seconds
#
shutdown.backstop.timeout=10000
shutdown.backstop.enabled=false

# Server Single User Mode
# note:
#   only allow named user (note: if blank or not set then will allow all users)
#   assuming maxusers is not set to 0
#server.singleuseronly.name=admin

# Server Max Users - limit number of users with non-expired tickets
# note: 
#   -1 allows any number of users, assuming not in single-user mode
#   0 prevents further logins, including the ability to enter single-user mode
server.maxusers=-1

#
# Disable all shared caches (mutable and immutable)
#    These properties are used for diagnostic purposes
system.cache.disableMutableSharedCaches=false
system.cache.disableImmutableSharedCaches=false

# The maximum capacity of the parent assocs cache (the number of nodes whose parents can be cached)
system.cache.parentAssocs.maxSize=130000

# The average number of parents expected per cache entry. This parameter is multiplied by the above
# value to compute a limit on the total number of cached parents, which will be proportional to the
# cache's memory usage. The cache will be pruned when this limit is exceeded to avoid excessive
# memory usage.
system.cache.parentAssocs.limitFactor=8

#
# Properties to limit resources spent on individual searches
#
# The maximum time spent pruning results
system.acl.maxPermissionCheckTimeMillis=10000
# The maximum number of search results to perform permission checks against
system.acl.maxPermissionChecks=1000

# The maximum number of filefolder list results
system.filefolderservice.defaultListMaxResults=5000
# DEPRECATED: Use 'system.auditableData.preserve'
system.preserve.modificationData=false
# The default to preserve all cm:auditable data on a node when the process is not directly driven by a user action
system.auditableData.preserve=${system.preserve.modificationData}
# Specific control of how the FileFolderService treats cm:auditable data when performing moves
system.auditableData.FileFolderService=${system.auditableData.preserve}
# Specific control of whether ACL changes on a node trigger the cm:auditable aspect
system.auditableData.ACLs=${system.auditableData.preserve}

# Properties to control read permission evaluation for acegi
system.readpermissions.optimise=true
system.readpermissions.bulkfetchsize=1000

#
# Manually control how the system handles maximum string lengths.
#    Any zero or negative value is ignored.
#    Only change this after consulting support or reading the appropriate Javadocs for
#        org.alfresco.repo.domain.schema.SchemaBootstrap for V2.1.2.
#    Before database migration, the string value storage may need to be adjusted using the scheduled job
system.maximumStringLength=-1
system.maximumStringLength.jobCronExpression=* * * * * ? 2099
system.maximumStringLength.jobQueryRange=10000
system.maximumStringLength.jobThreadCount=4

#
# Limit hibernate session size by trying to amalgamate events for the L2 session invalidation
# - hibernate works as is up to this size 
# - after the limit is hit events that can be grouped invalidate the L2 cache by type and not instance
# events may not group if there are post action listener registered (this is not the case with the default distribution)
system.hibernateMaxExecutions=20000

#
# Determine if modification timestamp propagation from child to parent nodes is respected or not.
# Even if 'true', the functionality is only supported for child associations that declare the
# 'propagateTimestamps' element in the dictionary definition.
system.enableTimestampPropagation=true

#
# Enable system model integrity checking.
# WARNING: Changing this is unsupported; bugs may corrupt data
system.integrity.enabled=true
# Do integrity violations fail transactions
# WARNING: Changing this is unsupported; bugs may corrupt data
system.integrity.failOnViolation=true
# The number of errors to report when violations are detected
system.integrity.maxErrorsPerTransaction=5
# Add call stacks to integrity events so that errors are logged with possible causes
# WARNING: This is expensive and should only be switched on for diagnostic purposes
system.integrity.trace=false

#
# Decide if content should be removed from the system immediately after being orphaned.
# Do not change this unless you have examined the impact it has on your backup procedures.
system.content.eagerOrphanCleanup=false
# The number of days to keep orphaned content in the content stores.
#    This has no effect on the 'deleted' content stores, which are not automatically emptied.
system.content.orphanProtectDays=14
# The action to take when a store or stores fails to delete orphaned content
#    IGNORE: Just log a warning.  The binary remains and the record is expunged
#    KEEP_URL: Log a warning and create a URL entry with orphan time 0.  It won't be processed or removed.
system.content.deletionFailureAction=IGNORE
# The CRON expression to trigger the deletion of resources associated with orphaned content.
system.content.orphanCleanup.cronExpression=0 0 4 * * ?

# #################### #
# Lucene configuration #
# #################### #
#
# Millisecond threshold for text transformations
# Slower transformers will force the text extraction to be asynchronous
#
lucene.maxAtomicTransformationTime=100
#
# The maximum number of clauses that are allowed in a lucene query 
#
lucene.query.maxClauses=10000
#
# The size of the queue of nodes waiting for index
# Events are generated as nodes are changed, this is the maximum size of the queue used to coalesce event
# When this size is reached the lists of nodes will be indexed
#
# http://issues.alfresco.com/browse/AR-1280:  Setting this high is the workaround as of 1.4.3. 
#
lucene.indexer.batchSize=1000000
fts.indexer.batchSize=1000
#
# Index cache sizes
#
lucene.indexer.cacheEnabled=true
lucene.indexer.maxDocIdCacheSize=100000
lucene.indexer.maxDocumentCacheSize=100
lucene.indexer.maxIsCategoryCacheSize=-1
lucene.indexer.maxLinkAspectCacheSize=10000
lucene.indexer.maxParentCacheSize=100000
lucene.indexer.maxPathCacheSize=100000
lucene.indexer.maxTypeCacheSize=10000
#
# Properties for merge (not this does not affect the final index segment which will be optimised) 
# Max merge docs only applies to the merge process not the resulting index which will be optimised.
#
lucene.indexer.mergerMaxMergeDocs=1000000
lucene.indexer.mergerMergeFactor=5
lucene.indexer.mergerMaxBufferedDocs=-1
lucene.indexer.mergerRamBufferSizeMb=16
#
# Properties for delta indexes (not this does not affect the final index segment which will be optimised) 
# Max merge docs only applies to the index building process not the resulting index which will be optimised.
#
lucene.indexer.writerMaxMergeDocs=1000000
lucene.indexer.writerMergeFactor=5
lucene.indexer.writerMaxBufferedDocs=-1
lucene.indexer.writerRamBufferSizeMb=16
#
# Target number of indexes and deltas in the overall index and what index size to merge in memory
#
lucene.indexer.mergerTargetIndexCount=8
lucene.indexer.mergerTargetOverlayCount=5
lucene.indexer.mergerTargetOverlaysBlockingFactor=2
lucene.indexer.maxDocsForInMemoryMerge=60000
lucene.indexer.maxRamInMbForInMemoryMerge=16
lucene.indexer.maxDocsForInMemoryIndex=60000
lucene.indexer.maxRamInMbForInMemoryIndex=16
#
# Other lucene properties
#
lucene.indexer.termIndexInterval=128
lucene.indexer.useNioMemoryMapping=true
# over-ride to false for pre 3.0 behaviour
lucene.indexer.postSortDateTime=true
lucene.indexer.defaultMLIndexAnalysisMode=EXACT_LANGUAGE_AND_ALL
lucene.indexer.defaultMLSearchAnalysisMode=EXACT_LANGUAGE_AND_ALL
#
# The number of terms from a document that will be indexed
#
lucene.indexer.maxFieldLength=10000

# Should we use a 'fair' locking policy, giving queue-like access behaviour to
# the indexes and avoiding starvation of waiting writers? Set to false on old
# JVMs where this appears to cause deadlock
lucene.indexer.fairLocking=true

#
# Index locks (mostly deprecated and will be tidied up with the next lucene upgrade)
#
lucene.write.lock.timeout=10000
lucene.commit.lock.timeout=100000
lucene.lock.poll.interval=100

lucene.indexer.useInMemorySort=true
lucene.indexer.maxRawResultSetSizeForInMemorySort=1000
lucene.indexer.contentIndexingEnabled=true

index.backup.cronExpression=0 0 3 * * ?

lucene.defaultAnalyserResourceBundleName=alfresco/model/dataTypeAnalyzers


# When transforming archive files (.zip etc) into text representations (such as
#  for full text indexing), should the files within the archive be processed too?
# If enabled, transformation takes longer, but searches of the files find more.
transformer.Archive.includeContents=false

# Database configuration
db.schema.name=
db.schema.stopAfterSchemaBootstrap=false
db.schema.update=true
db.schema.update.lockRetryCount=24
db.schema.update.lockRetryWaitSeconds=5
db.driver=org.gjt.mm.mysql.Driver
db.name=alfresco
db.url=jdbc:mysql:///${db.name}
db.username=alfresco
db.password=alfresco
db.pool.initial=10
db.pool.max=275
db.txn.isolation=-1
db.pool.statements.enable=true
db.pool.statements.max=40
db.pool.min=10
db.pool.idle=10
db.pool.wait.max=5000

db.pool.validate.query=
db.pool.evict.interval=600000
db.pool.evict.idle.min=1800000
#
# note: for 'db.pool.evict.num.tests' see http://commons.apache.org/dbcp/configuration.html (numTestsPerEvictionRun)
#       and also following extract from "org.apache.commons.pool.impl.GenericKeyedObjectPool" (1.5.5)
#
#       * The number of objects to examine during each run of the idle object evictor thread (if any).
#       * When a negative value is supplied, <code>ceil({@link #getNumIdle})/abs({@link #getNumTestsPerEvictionRun})</code>
#       * tests will be run.  I.e., when the value is <code>-n</code>, roughly one <code>n</code>th of the
#       * idle objects will be tested per run.
#
db.pool.evict.num.tests=-1

db.pool.evict.validate=false
db.pool.validate.borrow=true
db.pool.validate.return=false

db.pool.abandoned.detect=false
db.pool.abandoned.time=300
#
# db.pool.abandoned.log=true (logAbandoned) adds overhead (http://commons.apache.org/dbcp/configuration.html)
# and also requires db.pool.abandoned.detect=true (removeAbandoned)
#
db.pool.abandoned.log=false


# Audit configuration
audit.enabled=true
audit.tagging.enabled=true
audit.alfresco-access.enabled=false
audit.alfresco-access.sub-actions.enabled=false
audit.cmischangelog.enabled=false
audit.dod5015.enabled=false
# Setting this flag to true will force startup failure when invalid audit configurations are detected
audit.config.strict=false
# Audit map filter for AccessAuditor - restricts recorded events to user driven events 
audit.filter.alfresco-access.default.enabled=false
audit.filter.alfresco-access.transaction.user=~System;~null;.*
audit.filter.alfresco-access.transaction.type=cm:folder;cm:content;st:site
audit.filter.alfresco-access.transaction.path=~/sys:archivedItem;~/ver:;.*


# System Configuration
system.store=system://system
system.descriptor.childname=sys:descriptor
system.descriptor.current.childname=sys:descriptor-current

# User config
alfresco_user_store.store=user://alfrescoUserStore
alfresco_user_store.system_container.childname=sys:system
alfresco_user_store.user_container.childname=sys:people

# note: default admin username - should not be changed after installation
alfresco_user_store.adminusername=admin

# Initial password - editing this will not have any effect once the repository is installed
alfresco_user_store.adminpassword=209c6174da490caeb422f3fa5a7ae634

# note: default guest username - should not be changed after installation
alfresco_user_store.guestusername=guest

# Used to move home folders to a new location
home_folder_provider_synchronizer.enabled=false
home_folder_provider_synchronizer.override_provider=
home_folder_provider_synchronizer.keep_empty_parents=false

# Spaces Archive Configuration
spaces.archive.store=archive://SpacesStore

# Spaces Configuration
spaces.store=workspace://SpacesStore
spaces.company_home.childname=app:company_home
spaces.guest_home.childname=app:guest_home
spaces.dictionary.childname=app:dictionary
spaces.templates.childname=app:space_templates
spaces.imap_attachments.childname=cm:Imap Attachments
spaces.imap_home.childname=cm:Imap Home
spaces.imapConfig.childname=app:imap_configs
spaces.imap_templates.childname=app:imap_templates
spaces.scheduled_actions.childname=cm:Scheduled Actions
spaces.emailActions.childname=app:email_actions
spaces.searchAction.childname=cm:search
spaces.templates.content.childname=app:content_templates
spaces.templates.email.childname=app:email_templates
spaces.templates.email.invite1.childname=app:invite_email_templates
spaces.templates.email.notify.childname=app:notify_email_templates
spaces.templates.email.following.childname=app:following
spaces.templates.rss.childname=app:rss_templates
spaces.savedsearches.childname=app:saved_searches
spaces.scripts.childname=app:scripts
spaces.content_forms.childname=app:forms
spaces.user_homes.childname=app:user_homes
spaces.user_homes.regex.key=userName
spaces.user_homes.regex.pattern=
spaces.user_homes.regex.group_order=
spaces.sites.childname=st:sites
spaces.templates.email.invite.childname=cm:invite
spaces.templates.email.activities.childname=cm:activities
spaces.rendition.rendering_actions.childname=app:rendering_actions
spaces.replication.replication_actions.childname=app:replication_actions
spaces.transfers.childname=app:transfers
spaces.transfer_groups.childname=app:transfer_groups
spaces.transfer_temp.childname=app:temp
spaces.inbound_transfer_records.childname=app:inbound_transfer_records
spaces.webscripts.childname=cm:webscripts
spaces.extension_webscripts.childname=cm:extensionwebscripts
spaces.models.childname=app:models
spaces.workflow.definitions.childname=app:workflow_defs
spaces.templates.email.workflowemailnotification.childname=cm:workflownotification
spaces.nodetemplates.childname=app:node_templates
spaces.shared.childname=app:shared
spaces.solr_facets.root.childname=srft:facets
spaces.smartfolders.childname=app:smart_folders
spaces.smartdownloads.childname=app:smart_downloads
spaces.transfer_summary_report.location=/${spaces.company_home.childname}/${spaces.dictionary.childname}/${spaces.transfers.childname}/${spaces.inbound_transfer_records.childname}
spaces.quickshare.link_expiry_actions.childname=app:quick_share_link_expiry_actions


# ADM VersionStore Configuration
version.store.initialVersion=true
version.store.enableAutoVersioning=true
version.store.enableAutoVersionOnUpdateProps=false
version.store.deprecated.lightWeightVersionStore=workspace://lightWeightVersionStore
version.store.version2Store=workspace://version2Store

# Optional Comparator<Version> class name to sort versions.
# Set to: org.alfresco.repo.version.common.VersionLabelComparator
# if upgrading from a version that used unordered sequences in a cluster. 
version.store.versionComparatorClass=

# Folders for storing people
system.system_container.childname=sys:system
system.people_container.childname=sys:people
system.authorities_container.childname=sys:authorities
system.zones_container.childname=sys:zones

# Folders for storing workflow related info
system.workflow_container.childname=sys:workflow

# Folder for storing shared remote credentials
system.remote_credentials_container.childname=sys:remote_credentials

# Folder for storing syncset definitions
system.syncset_definition_container.childname=sys:syncset_definitions

# Folder for storing download archives
system.downloads_container.childname=sys:downloads

# Folder for storing IdP's certificate definitions
system.certificate_container.childname=sys:samlcertificate

# Are user names case sensitive?
user.name.caseSensitive=false
domain.name.caseSensitive=false
domain.separator=

#Format caption extracted from the XML Schema.
xforms.formatCaption=true

# ECM content usages/quotas
system.usages.enabled=false
system.usages.clearBatchSize=0
system.usages.updateBatchSize=50

# Repository endpoint - used by Activity Service
repo.remote.endpoint=/service

# Some authentication mechanisms may need to create people
# in the repository on demand. This enables that feature.
# If disabled an error will be generated for missing
# people. If enabled then a person will be created and
# persisted.
create.missing.people=${server.transaction.allow-writes}

# Create home folders (unless disabled, see next property) as people are created (true) or create them lazily (false)
home.folder.creation.eager=true
# Disable home folder creation - if true then home folders are not created (neither eagerly nor lazily)
home.folder.creation.disabled=false

# Should we consider zero byte content to be the same as no content when firing
# content update policies? Prevents 'premature' firing of inbound content rules
# for some clients such as Mac OS X Finder
policy.content.update.ignoreEmpty=true

# Default value of alfresco.rmi.services.host is 0.0.0.0 which means 'listen on all adapters'.
# This allows connections to JMX both remotely and locally.
#
alfresco.rmi.services.port=50500
alfresco.rmi.services.external.host=localhost
alfresco.rmi.services.host=0.0.0.0

# If the RMI address is in-use, how many retries should be done before aborting
# Default value of alfresco.rmi.services.retries is 0 which means 'Don't retry if the address is in-use'
alfresco.rmi.services.retries=4
# How long in milliseconds to wait after a failed server socket bind, before retrying
alfresco.rmi.services.retryInterval=250

# RMI service ports for the individual services.
# These eight services are available remotely.
#
# Assign individual ports for each service for best performance 
# or run several services on the same port, you can even run everything on 50500 if 
# running through a firewall.
#
# Specify 0 to use a random unused port.
# 
monitor.rmi.service.port=50508

#
# enable or disable individual RMI services
#
monitor.rmi.service.enabled=false


# Should the Mbean server bind to an existing  server.   Set to true for most application servers.
# false for WebSphere clusters.
mbean.server.locateExistingServerIfPossible=true

# External executable locations
img.root=./ImageMagick
img.dyn=${img.root}/lib
img.exe=${img.root}/bin/convert

# Legacy imageMagick transformer url to T-Engine to service transform requests via http. Disabled by default.
img.url=

# When img.url is set, this value indicates the amount of time to wait after a connection failure
# before retrying the connection to allow a docker container to (re)start.
img.startupRetryPeriodSeconds=60

# Rendition Service 2
renditionService2.enabled=true

# Thumbnail Service
system.thumbnail.generate=true

# Default thumbnail limits
# When creating thumbnails, only use the first pageLimit pages
system.thumbnail.definition.default.timeoutMs=-1
system.thumbnail.definition.default.readLimitTimeMs=-1
system.thumbnail.definition.default.maxSourceSizeKBytes=-1
system.thumbnail.definition.default.readLimitKBytes=-1
system.thumbnail.definition.default.pageLimit=1
system.thumbnail.definition.default.maxPages=-1

# Max mimetype sizes to create thumbnail icons
system.thumbnail.mimetype.maxSourceSizeKBytes.pdf=-1
system.thumbnail.mimetype.maxSourceSizeKBytes.txt=-1
system.thumbnail.mimetype.maxSourceSizeKBytes.docx=-1
system.thumbnail.mimetype.maxSourceSizeKBytes.xlsx=-1
system.thumbnail.mimetype.maxSourceSizeKBytes.pptx=-1
system.thumbnail.mimetype.maxSourceSizeKBytes.odt=-1
system.thumbnail.mimetype.maxSourceSizeKBytes.ods=-1
system.thumbnail.mimetype.maxSourceSizeKBytes.odp=-1

# Configuration for handling of failing thumbnails.
# See NodeEligibleForRethumbnailingEvaluator's javadoc for details.
#
# Retry periods limit the frequency with which the repository will attempt to create Share thumbnails
# for content nodes which have previously failed in their thumbnail attempts.
# These periods are in seconds.
#
# 604800s = 60s * 60m * 24h * 7d = 1 week
system.thumbnail.retryPeriod=60
system.thumbnail.retryCount=2
system.thumbnail.quietPeriod=604800
system.thumbnail.quietPeriodRetriesEnabled=true
system.thumbnail.redeployStaticDefsOnStartup=true

# The default timeout for metadata mapping extracters
content.metadataExtracter.default.timeoutMs=20000

# Legacy tika and misc transformer url to T-Engines to service transform requests via http. Disabled by default.
tika.url=
transform.misc.url=

# When the legacy tika and misc transformer .url is set, this value indicates the amount of time to wait after a connection failure
# before retrying the connection to allow a docker container to (re)start.
tika.startupRetryPeriodSeconds=60
transform.misc.startupRetryPeriodSeconds=60

# Local transformer urls to T-engines to service transform requests via http. Enabled by default.
localTransform.core-aio.url=http://localhost:8090/

# When a local transformer .url is set, this value indicates the amount of time to wait after a connection failure
# before retrying the connection to allow a docker container to (re)start.
localTransform.core-aio.startupRetryPeriodSeconds=60

#
content.metadataExtracter.pdf.maxDocumentSizeMB=10
content.metadataExtracter.pdf.maxConcurrentExtractionsCount=5

# The default overwrite policy for PdfBoxMetadataExtracter
content.metadataExtracter.pdf.overwritePolicy=PRAGMATIC

#True if bookmarks content should be extracted for PDFBox
content.transformer.PdfBox.extractBookmarksText=true

# Property to enable upgrade from 2.1-A
V2.1-A.fixes.to.schema=0
#V2.1-A.fixes.to.schema=82

# The default authentication chain
authentication.chain=alfrescoNtlm1:alfrescoNtlm

# Do authentication tickets expire or live for ever?
authentication.ticket.ticketsExpire=true

# If ticketsEpire is true then how they should expire?
# Valid values are: AFTER_INACTIVITY, AFTER_FIXED_TIME, DO_NOT_EXPIRE
# The default is AFTER_FIXED_TIME
authentication.ticket.expiryMode=AFTER_INACTIVITY

# If authentication.ticket.ticketsExpire is true and
# authentication.ticket.expiryMode is AFTER_FIXED_TIME or AFTER_INACTIVITY,
# this controls the minimum period for which tickets are valid. 
# The default is PT1H for one hour.
authentication.ticket.validDuration=PT1H

# Use one ticket for all user sessions
# For the pre 4.2 behaviour of one ticket per session set this to false.
authentication.ticket.useSingleTicketPerUser=true

authentication.alwaysAllowBasicAuthForAdminConsole.enabled=true
authentication.getRemoteUserTimeoutMilliseconds=10000

# FTP access
ftp.enabled=false

# Default root path for protocols
protocols.storeName=${spaces.store}
protocols.rootPath=/${spaces.company_home.childname}

# OpenCMIS
opencmis.connector.default.store=${spaces.store}
opencmis.connector.default.rootPath=/${spaces.company_home.childname}
opencmis.connector.default.typesDefaultMaxItems=500
opencmis.connector.default.typesDefaultDepth=-1
opencmis.connector.default.objectsDefaultMaxItems=10000
opencmis.connector.default.objectsDefaultDepth=100
opencmis.connector.default.contentChangesDefaultMaxItems=10000
opencmis.connector.default.openHttpSession=false
opencmis.activities.enabled=true
opencmis.bulkUpdateProperties.maxItemsSize=1000
opencmis.bulkUpdateProperties.batchSize=20
opencmis.bulkUpdateProperties.workerThreads=2
opencmis.maxContentSizeMB=4096
opencmis.memoryThresholdKB=4096

# URL generation overrides

# if true, the context path of OpenCMIS generated urls will be set to "opencmis.context.value", otherwise it will be taken from the request url
opencmis.context.override=false
opencmis.context.value=
# if true, the servlet path of OpenCMIS generated urls will be set to "opencmis.servletpath.value", otherwise it will be taken from the request url
opencmis.servletpath.override=false
opencmis.servletpath.value=
opencmis.server.override=false
opencmis.server.value=

# IMAP
imap.server.enabled=false
imap.server.port=143
imap.server.attachments.extraction.enabled=true

# Default IMAP mount points
imap.config.home.store=${spaces.store}
imap.config.home.rootPath=/${spaces.company_home.childname}
imap.config.home.folderPath=${spaces.imap_home.childname}
imap.config.server.mountPoints=AlfrescoIMAP
imap.config.server.mountPoints.default.mountPointName=IMAP
imap.config.server.mountPoints.default.modeName=ARCHIVE
imap.config.server.mountPoints.default.store=${spaces.store}
imap.config.server.mountPoints.default.rootPath=${protocols.rootPath}
imap.config.server.mountPoints.value.AlfrescoIMAP.mountPointName=Alfresco IMAP
imap.config.server.mountPoints.value.AlfrescoIMAP.modeName=MIXED

#Imap extraction settings
#imap.attachments.mode:
#   SEPARATE -- All attachments for each email will be extracted to separate folder.
#   COMMON -- All attachments for all emails will be extracted to one folder.
#   SAME -- Attachments will be extracted to the same folder where email lies.
imap.attachments.mode=SEPARATE
imap.attachments.folder.store=${spaces.store}
imap.attachments.folder.rootPath=/${spaces.company_home.childname}
imap.attachments.folder.folderPath=${spaces.imap_attachments.childname}

# Activities Feed - refer to subsystem

# Feed max ID range to limit maximum number of entries
activities.feed.max.idRange=1000000
# Feed max size (number of entries)
activities.feed.max.size=200
# Feed max age (eg. 44640 mins => 31 days)
activities.feed.max.ageMins=44640

activities.feed.generator.jsonFormatOnly=true
activities.feed.fetchBatchSize=250
activities.feedNotifier.batchSize=200
activities.feedNotifier.numThreads=2

# Subsystem unit test values. Will not have any effect on production servers
subsystems.test.beanProp.default.longProperty=123456789123456789
subsystems.test.beanProp.default.anotherStringProperty=Global Default
subsystems.test.beanProp=inst1,inst2,inst3
subsystems.test.beanProp.value.inst2.boolProperty=true
subsystems.test.beanProp.value.inst3.anotherStringProperty=Global Instance Default
subsystems.test.simpleProp2=true
subsystems.test.simpleProp3=Global Default3

# Default Async Action Thread Pool
default.async.action.threadPriority=1
default.async.action.corePoolSize=8
default.async.action.maximumPoolSize=20

# Deployment Service
deployment.service.numberOfSendingThreads=5
deployment.service.corePoolSize=2
deployment.service.maximumPoolSize=3
deployment.service.threadPriority=5
# How long to wait in mS before refreshing a target lock - detects shutdown servers
deployment.service.targetLockRefreshTime=60000
# How long to wait in mS from the last communication before deciding that deployment has failed, possibly 
# the destination is no longer available?
deployment.service.targetLockTimeout=3600000
# Deployment method used to deploy this Alfresco instance (DEFAULT, INSTALLER, DOCKER_COMPOSE, HELM_CHART, ZIP, QUICK_START)
deployment.method=DEFAULT

#Invitation Service
# Should send emails as part of invitation process.
notification.email.siteinvite=true
# Moderated invite Activiti workflow
site.invite.moderated.workflowId=activiti$activitiInvitationModerated
# Add intneral users Activiti workflow (use activiti$activitiInvitationNominated to revert to requiring accept of invite for internal users)
site.invite.nominated.workflowId=activiti$activitiInvitationNominatedAddDirect
# Add external users Activiti workflow
site.invite.nominatedExternal.workflowId=activiti$activitiInvitationNominated

# Replication Service
replication.enabled=false

# Transfer Service
transferservice.receiver.enabled=false
transferservice.receiver.stagingDir=${java.io.tmpdir}/alfresco-transfer-staging
#
# How long to wait in mS before refreshing a transfer lock - detects shutdown servers
# Default 1 minute.
transferservice.receiver.lockRefreshTime=60000
#
# How many times to attempt retry the transfer lock
transferservice.receiver.lockRetryCount=3
# How long to wait, in mS, before retrying the transfer lock        
transferservice.receiver.lockRetryWait=100
#
# How long to wait, in mS, since the last contact with from the client before 
# timing out a transfer.   Needs to be long enough to cope with network delays and "thinking 
# time" for both source and destination.    Default 5 minutes.
transferservice.receiver.lockTimeOut=300000

# OrphanReaper 
orphanReaper.lockRefreshTime=60000
orphanReaper.lockTimeOut=3600000


# security
security.anyDenyDenies=true
# Whether to post-process denies. Only applies to solr4+ when anyDenyDenies is true.
security.postProcessDenies=false

#
# Encryption properties
#
# default keystores location
dir.keystore=classpath:alfresco/keystore

# general encryption parameters
encryption.keySpec.class=org.alfresco.encryption.DESEDEKeyGenerator
encryption.keyAlgorithm=AES
encryption.cipherAlgorithm=AES/CBC/PKCS5Padding

# secret key keystore configuration
encryption.keystore.location=${dir.keystore}/keystore
# configuration via metadata is deprecated
encryption.keystore.keyMetaData.location=
encryption.keystore.provider=
encryption.keystore.type=pkcs12

# backup secret key keystore configuration
encryption.keystore.backup.location=${dir.keystore}/backup-keystore
# configuration via metadata is deprecated
encryption.keystore.backup.keyMetaData.location=
encryption.keystore.backup.provider=
encryption.keystore.backup.type=pkcs12

# Should encryptable properties be re-encrypted with new encryption keys on botstrap?
encryption.bootstrap.reencrypt=false

# mac/md5 encryption
encryption.mac.messageTimeout=30000
encryption.mac.algorithm=HmacSHA1

# ssl encryption
encryption.ssl.keystore.location=${dir.keystore}/ssl.keystore
encryption.ssl.keystore.provider=
encryption.ssl.keystore.type=JCEKS
# configuration via metadata is deprecated
encryption.ssl.keystore.keyMetaData.location=
encryption.ssl.truststore.location=${dir.keystore}/ssl.truststore
encryption.ssl.truststore.provider=
encryption.ssl.truststore.type=JCEKS
# configuration via metadata is deprecated
encryption.ssl.truststore.keyMetaData.location=

# Re-encryptor properties
encryption.reencryptor.chunkSize=100
encryption.reencryptor.numThreads=2

# SOLR connection details (e.g. for JMX)
solr.host=localhost
solr.port=8983
solr.port.ssl=8984
solr.solrUser=solr
solr.solrPassword=solr
# none, https
solr.secureComms=https
solr.cmis.alternativeDictionary=DEFAULT_DICTIONARY

solr.max.total.connections=40
solr.max.host.connections=40

# Solr connection timeouts
# solr connect timeout in ms
solr.solrConnectTimeout=5000

# cron expression defining how often the Solr Admin client (used by JMX) pings Solr if it goes away
solr.solrPingCronExpression=0 0/5 * * * ? *


#Default SOLR store mappings mappings
solr.store.mappings=solrMappingAlfresco,solrMappingArchive
solr.store.mappings.value.solrMappingAlfresco.httpClientFactory=solrHttpClientFactory
solr.store.mappings.value.solrMappingAlfresco.baseUrl=/solr/alfresco
solr.store.mappings.value.solrMappingAlfresco.protocol=workspace
solr.store.mappings.value.solrMappingAlfresco.identifier=SpacesStore
solr.store.mappings.value.solrMappingArchive.httpClientFactory=solrHttpClientFactory
solr.store.mappings.value.solrMappingArchive.baseUrl=/solr/archive
solr.store.mappings.value.solrMappingArchive.protocol=archive
solr.store.mappings.value.solrMappingArchive.identifier=SpacesStore

#Default SOLR 4 store mappings mappings
solr4.store.mappings=solrMappingAlfresco,solrMappingArchive
solr4.store.mappings.value.solrMappingAlfresco.httpClientFactory=solrHttpClientFactory
solr4.store.mappings.value.solrMappingAlfresco.baseUrl=/solr4/alfresco
solr4.store.mappings.value.solrMappingAlfresco.protocol=workspace
solr4.store.mappings.value.solrMappingAlfresco.identifier=SpacesStore
solr4.store.mappings.value.solrMappingArchive.httpClientFactory=solrHttpClientFactory
solr4.store.mappings.value.solrMappingArchive.baseUrl=/solr4/archive
solr4.store.mappings.value.solrMappingArchive.protocol=archive
solr4.store.mappings.value.solrMappingArchive.identifier=SpacesStore

#Default SOLR 6 store mappings mappings
solr6.store.mappings=solrMappingAlfresco,solrMappingArchive,solrMappingHistory
solr6.store.mappings.value.solrMappingAlfresco.httpClientFactory=solrHttpClientFactory
solr6.store.mappings.value.solrMappingAlfresco.baseUrl=/solr/alfresco
solr6.store.mappings.value.solrMappingAlfresco.protocol=workspace
solr6.store.mappings.value.solrMappingAlfresco.identifier=SpacesStore
solr6.store.mappings.value.solrMappingArchive.httpClientFactory=solrHttpClientFactory
solr6.store.mappings.value.solrMappingArchive.baseUrl=/solr/archive
solr6.store.mappings.value.solrMappingArchive.protocol=archive
solr6.store.mappings.value.solrMappingArchive.identifier=SpacesStore
solr6.store.mappings.value.solrMappingHistory.httpClientFactory=solrHttpClientFactory
solr6.store.mappings.value.solrMappingHistory.baseUrl=/solr/history
solr6.store.mappings.value.solrMappingHistory.protocol=workspace
solr6.store.mappings.value.solrMappingHistory.identifier=history

#
# URL Shortening Properties
#
urlshortening.bitly.username=brianalfresco
urlshortening.bitly.api.key=R_ca15c6c89e9b25ccd170bafd209a0d4f
urlshortening.bitly.url.length=20

#
# Bulk Filesystem Importer
#

# The number of threads to employ in a batch import
bulkImport.batch.numThreads=4

# The size of a batch in a batch import i.e. the number of files to import in a
# transaction/thread
bulkImport.batch.batchSize=20


#
# Caching Content Store
#
system.content.caching.cacheOnInbound=true
system.content.caching.maxDeleteWatchCount=1
# Clean up every day at 3 am
system.content.caching.contentCleanup.cronExpression=0 0 3 * * ?
system.content.caching.minFileAgeMillis=60000
system.content.caching.maxUsageMB=4096
# maxFileSizeMB - 0 means no max file size.
system.content.caching.maxFileSizeMB=0
# When the CachingContentStore is about to write a cache file but the disk usage is in excess of panicThresholdPct
# (default 90%) then the cache file is not written and the cleaner is started (if not already running) in a new thread.
system.content.caching.panicThresholdPct=90
# When a cache file has been written that results in cleanThresholdPct (default 80%) of maxUsageBytes
# being exceeded then the cached content cleaner is invoked (if not already running) in a new thread.
system.content.caching.cleanThresholdPct=80
# An aggressive cleaner is run till the targetUsagePct (default 70%) of maxUsageBytes is achieved
system.content.caching.targetUsagePct=70
# Threshold in seconds indicating a minimal gap between normal cleanup starts
system.content.caching.normalCleanThresholdSec=0

mybatis.useLocalCaches=false

fileFolderService.checkHidden.enabled=true


ticket.cleanup.cronExpression=0 0 * * * ?

#
# Download Service Cleanup
#
download.cleaner.startDelayMilliseconds=3600000
# 1 hour
download.cleaner.repeatIntervalMilliseconds=3600000
download.cleaner.maxAgeMins=60
# -1 or 0 for not using batches
download.cleaner.batchSize=1000

# you could set this to false for new installations greater then ACS 6.2
# see MNT-20212
download.cleaner.cleanAllSysDownloadFolders=true

#
# Download Service Limits, in bytes
#
download.maxContentSize=2152852358

# Max size of view trashcan files
#
trashcan.MaxSize=1000

#
# Use bridge tables for caching authority evaluation.
#
authority.useBridgeTable=true

# Limit the number of results from findAuthority query
authority.findAuthorityLimit=10000

# enable QuickShare - if false then the QuickShare-specific REST APIs will return 403 Forbidden
system.quickshare.enabled=true
system.quickshare.email.from.default=noreply@alfresco.com
# By default the difference between the quick share expiry date and the current time must be at least 1 day (24 hours).
# However, this can be changed to at least 1 hour or 1 minute for testing purposes. For example,
# setting the value to MINUTES, means the service will calculate the difference between NOW and the given expiry date
# in terms of minutes and checks for the difference to be greater than 1 minute.
# DAYS | HOURS | MINUTES
system.quickshare.expiry_date.enforce.minimum.period=DAYS

# Oubound Mail
mail.service.corePoolSize=8
mail.service.maximumPoolSize=20

nodes.bulkLoad.cachingThreshold=10

# Multi-Tenancy

# if "dir.contentstore.tenants" is set then
#     tenants are not co-mingled and all content roots will appear below this container (in <tenantdomain> sub-folder)
#     and when creating a tenant the "contentRootPath" (root content store directory for a given tenant) will be ignored
dir.contentstore.tenants=

# Gateway Authentication
# gateway authentication is disabled if empty host is specified
alfresco.authentication.gateway.host=
alfresco.authentication.gateway.protocol=https
alfresco.authentication.gateway.port=443
alfresco.authentication.gateway.outboundHeaders=Authorization,key
alfresco.authentication.gateway.inboundHeaders=X-Alfresco-Authenticator-Key,X-Alfresco-Remote-User
alfresco.authentication.gateway.prefixUrl=/publicapi
alfresco.authentication.gateway.bufferSize=2048
alfresco.authentication.gateway.connectTimeout=10000
alfresco.authentication.gateway.readTimeout=120000
alfresco.authentication.gateway.httpTcpNodelay=true
alfresco.authentication.gateway.httpConnectionStalecheck=true

# webscripts config
webscripts.encryptTempFiles=false
webscripts.tempDirectoryName=Alfresco-WebScripts
# 4mb
webscripts.memoryThreshold=4194304
# 4gb
webscripts.setMaxContentSize=5368709120

# Property to enable index upgrade for metadata query (MDQ)
#
# The indexes are not added unless this value is changed
# Adding each the supporting indexes may take several hours depending on the size of the database.
# The required indexes may be added in stages. 
# See: classpath:alfresco/dbscripts/upgrade/4.2/${db.script.dialect}/metadata-query-indexes.sql
# See: classpath:alfresco/dbscripts/upgrade/5.1/${db.script.dialect}/metadata-query-indexes-2.sql
system.metadata-query-indexes.ignored=true
system.metadata-query-indexes-more.ignored=true

#
# Do we defer running the shared folder patch?
#
system.patch.sharedFolder.deferred=false
# Default value is run new years day 2030 i.e. not run.
system.patch.sharedFolder.cronExpression=0 0 0 ? 1 1 2030

#
# Default values for deferring the running of the addUnmovableAspect patch
#
system.patch.addUnmovableAspect.deferred=false
system.patch.addUnmovableAspect.cronExpression=0 0 0 ? 1 1 2030

# Property to enable removal of all JBPM related data from the database
#
# The tables are not removed from the databasen unless explicitly requested by setting this property to false.
# See: classpath:alfresco/dbscripts/upgrade/5.2/${db.script.dialect}/remove-jbpm-tables-from-db.sql
system.remove-jbpm-tables-from-db.ignored=true

#
# Use a canned query when requested to search for people if " [hint:useCQ]" is provided in search term
#
people.search.honor.hint.useCQ=true

# Delays cron jobs after bootstrap to allow server to fully come up before jobs start
system.cronJob.startDelayMilliseconds=60000

# Schedule for reading mimetype config definitions dynamically. Initially checks every 10 seconds and then switches to
# every hour after the configuration is read successfully. If there is a error later reading the config, the
# checks return to every 10 seconds.
mimetype.config.cronExpression=0 30 0/1 * * ?
mimetype.config.initialAndOnError.cronExpression=0/10 * * * * ?

# Optional property to specify an external file or directory that will be read for mimetype definitions from YAML
# files (possibly added to a volume via k8 ConfigMaps).
mimetype.config.dir=shared/classes/alfresco/extension/mimetypes

# Schedule for reading rendition config definitions dynamically. Initially checks every 10 seconds and then switches to
# every hour after the configuration is read successfully. If there is a error later reading the config, the
# checks return to every 10 seconds.
rendition.config.cronExpression=2 30 0/1 * * ?
rendition.config.initialAndOnError.cronExpression=0/10 * * * * ?

# Optional property to specify an external file or directory that will be read for rendition definitions from YAML
# files (possibly added to a volume via k8 ConfigMaps).
rendition.config.dir=shared/classes/alfresco/extension/transform/renditions

# Optional property to specify an external file or directory that will be read for transformer json config.
local.transform.pipeline.config.dir=shared/classes/alfresco/extension/transform/pipelines

# Used to disable transforms locally.
local.transform.service.enabled=true

# Schedule for reading local transform config, so that T-Engines and local pipeline config is dynamically
# picked up, or reintegrated after an outage. Initially checks every 10 seconds and then switches to every hour
# after the configuration is read successfully. If there is a error later reading the config, the checks return to
# every 10 seconds.
local.transform.service.cronExpression=4 30 0/1 * * ?
local.transform.service.initialAndOnError.cronExpression=0/10 * * * * ?

# Used to disable transforms that extend AbstractContentTransformer2
legacy.transform.service.enabled=true

#
# Check that the declared mimetype (of the Node) is the same as the derived
# mimetype of the content (via Tika) before a transformation takes place.
# Only files in the repository (not intermediate files in a transformer
# pipeline) are checked. This property provides a trade off between a
# security check and a relatively expensive (Tika) operation.
#
# There are a few issues with the Tika mimetype detection. So that transformations
# still take place where the detected mimetype is not the same as the declared mimetype,
# another property (transformer.strict.mimetype.check.whitelist.mimetypes) contains pairs
# of declared and detected mimetypes that should be allowed. This parameter value is a
# sequence of ; separated pairs. The declared and derived mimetypes are also ; separated.
#
transformer.strict.mimetype.check=true

# A white list of declared and detected mimetypes, that don't match, but should still be transformed.
transformer.strict.mimetype.check.whitelist.mimetypes=application/eps;application/postscript;application/illustrator;application/pdf;application/x-tar;application/x-gtar;application/acp;application/zip;application/vnd.stardivision.math;application/x-tika-msoffice

#
# Enable transformation retrying if the file has MIME type differ than file extension.
# Ignored if transformer.strict.mimetype.check is true as these transformations
# will not take place.
#
content.transformer.retryOn.different.mimetype=true

#
# Lock timeout configuration
#
system.lockTryTimeout=100
system.lockTryTimeout.DictionaryDAOImpl=10000
system.lockTryTimeout.MessageServiceImpl=${system.lockTryTimeout}
system.lockTryTimeout.PolicyComponentImpl=${system.lockTryTimeout}


# Scheduled job to clean up unused properties from the alf_prop_xxx tables.
# Default setting of "0 0 3 ? * SAT" is to run every Saturday at 3am.
attributes.propcleaner.cronExpression=0 0 3 ? * SAT

# Control Alfresco JMX connectivity
alfresco.jmx.connector.enabled=false

# Dissallow Attribute Service Entries with "Serializable" objects in key Segments
# Please, see MNT-11895 for details.
system.propval.uniquenessCheck.enabled=true

# Requests for ephemeral (in-memory) locks with expiry times (in seconds) greater
# than this value will result in persistent locks being created instead. By default
# this value is equal to the maximum allowed expiry for ephemeral locks, therefore
# this feature is disabled by default. Setting this to -1 would mean that ALL
# requests for ephemeral locks would result in persistent locks being created. 
alfresco.ephemeralLock.expiryThresh=172800

# SurfConfigFolder Patch
#
# Do we defer running the surf-config folder patch?
#
system.patch.surfConfigFolder.deferred=false
# Default value. i.e. never run. It can be triggered using JMX
system.patch.surfConfigFolder.cronExpression=* * * * * ? 2099

#
# Solr Facets Config Properties
#
solr_facets.root.path=/app:company_home/app:dictionary
solr_facets.root=${solr_facets.root.path}/${spaces.solr_facets.root.childname}
solr_facets.inheritanceHierarchy=default,custom

models.enforceTenantInNamespace=false

# Allowed protocols for links
links.protocosl.white.list=http,https,ftp,mailto

# Fixed ACLs
# Required for fixing MNT-15368 - Time Consumed for Updating Folder Permission
# ADMAccessControlListDAO.setFixedAcls called on a large folder hierarchy will take a long time for its execution.
# For this reason now method can also be called asynchronously if transaction reaches system.fixedACLs.maxTransactionTime.
# In this case setFixedAcls method recursion will be stopped and unfinished nodes will be marked with ASPECT_PENDING_FIX_ACL.
# Pending nodes will be processed by FixedAclUpdater, programmatically called but also configured as a scheduled job.
system.fixedACLs.maxTransactionTime=10000
# fixedACLsUpdater - lock time to live
system.fixedACLsUpdater.lockTTL=10000
# fixedACLsUpdater - maximum number of nodes to process per execution
system.fixedACLsUpdater.maxItemBatchSize=100
# fixedACLsUpdater - the number of threads to use
system.fixedACLsUpdater.numThreads=4
# fixedACLsUpdater cron expression - fire at midnight every day
system.fixedACLsUpdater.cronExpression=0 0 0 * * ? 

cmis.disable.hidden.leading.period.files=false

#Smart Folders Config Properties
smart.folders.enabled=false

#Smart reference config
smart.reference.classpath.hash=${smart.folders.config.vanilla.processor.classpath}->1,${smart.folders.config.system.templates.classpath}->2

#Smart store config

#Company home relative download associations of smart entries 
smart.download.associations.folder=${spaces.dictionary.childname}/${spaces.smartdownloads.childname}

#Generic virtualization methods config

#Vanilla JSON templates javascript processor classpath. A java script processor used to 
#covert JSON templates to internal smart folder definitions.

smart.folders.config.vanilla.processor.classpath=/org/alfresco/repo/virtual/node/vanilla.js

#System virtualization method config

#System virtualization method aspect.
smart.folders.config.system.aspect=smf:systemConfigSmartFolder
#System virtualization method aspect defined template location property.
smart.folders.config.system.aspect.template.location.property=smf:system-template-location
#Classpath to be explored for *.json entries defining system templates.
smart.folders.config.system.templates.classpath=/org/alfresco/repo/virtual/node
#A company home relative name or qname path location of repository system templates.
smart.folders.config.system.templates.path=${spaces.dictionary.childname}/${spaces.smartfolders.childname}
#Content sub type of repository system templates.
smart.folders.config.system.templates.template.type=smf:smartFolderTemplate

#Custom virtualization method config

#Custom virtualization method aspect.
smart.folders.config.custom.aspect=smf:customConfigSmartFolder
#Custom virtualization method aspect template content association.
smart.folders.config.custom.aspect.template.association=smf:custom-template-association


#Type virtualization method config

#A company home relative name or qname path location of the type mapped templates.
smart.folders.config.type.templates.path=${spaces.dictionary.childname}/${spaces.smartfolders.childname}
#Type and aspect qname regular expression filter. 
smart.folders.config.type.templates.qname.filter=none

# Preferred password encoding, md4, sha256, bcrypt10
system.preferred.password.encoding=md4

# Upgrade Password Hash Job
system.upgradePasswordHash.jobBatchSize=100
system.upgradePasswordHash.jobQueryRange=10000
system.upgradePasswordHash.jobThreadCount=4
system.upgradePasswordHash.jobCronExpression=* * * * * ? 2099

system.api.discovery.enabled=true

# Maximum query size for category/tag fetch when not explicitly set by paging parameters
category.queryFetchSize=5000

# Brute force protection
authentication.protection.enabled=true
authentication.protection.limit=10
authentication.protection.periodSeconds=6

system.email.sender.default=noreply@alfresco.com
# reset password workflow will expire in an hour
system.reset-password.endTimer=PT1H
system.reset-password.sendEmailAsynchronously=true

# HeartBeat 
heartbeat.target.url=
heartbeat.enabled=true

# CSRF filter overrides
csrf.filter.enabled=true
csrf.filter.referer=
csrf.filter.referer.always=false
csrf.filter.origin=
csrf.filter.origin.always=false

# CORS settings
cors.enabled=false
cors.allowed.origins=
cors.allowed.methods=GET,POST,HEAD,OPTIONS,PUT,DELETE
cors.allowed.headers=Authorization,Content-Type,Cache-Control,X-Requested-With,accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers,X-CSRF-Token
cors.exposed.headers=Access-Control-Allow-Origin,Access-Control-Allow-Credentials
cors.support.credentials=true
cors.preflight.maxage=10

# Alfresco Rest Api-Explorer
api-explorer.url=

# Events subsystem
events.subsystem.autoStart=false
# Messaging subsystem
messaging.subsystem.autoStart=true


# Raw events
acs.repo.rendition.events.endpoint=jms:acs-repo-rendition-events?jmsMessageType=Text

# Transform request events
acs.repo.transform.request.endpoint=jms:acs-repo-transform-request?jmsMessageType=Text

# If enabled doesn't allow to set content properties via NodeService
contentPropertyRestrictions.enabled=true
contentPropertyRestrictions.whitelist=

# Repo events2
# Type and aspect filters which should be excluded
# Note: System folders node types are added by default
repo.event2.filter.nodeTypes=sys:*, fm:*, cm:thumbnail, cm:failedThumbnail, cm:rating, rma:rmsite include_subtypes
repo.event2.filter.nodeAspects=sys:*
repo.event2.filter.childAssocTypes=rn:rendition
# Comma separated list of users which should be excluded
# Note: username's case-sensitivity depends on the {user.name.caseSensitive} setting
repo.event2.filter.users=System, null
# Topic name
repo.event2.topic.endpoint=amqp:topic:alfresco.repo.event2

# MNT-21083
# --DELETE_NOT_EXISTS - default settings
system.delete_not_exists.batchsize=100000
system.delete_not_exists.delete_batchsize=1000
system.delete_not_exists.read_only=false
system.delete_not_exists.timeout_seconds=-1
system.prop_table_cleaner.algorithm=V2

# Configure the expiration time of the direct access url. This is the length of time in seconds that the link is valid for.
# Note: It is up to the actual ContentStore implementation if it can fulfil this request or not.
alfresco.content.directAccessUrl.lifetimeInSec=300


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
