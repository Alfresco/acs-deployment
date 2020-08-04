# Alfresco Content Services Property Reference

The table below shows the full list of properties (exluding module specific properties) that can be figured via alfresco-global.properties ordered alphabetically.
 
| Property | Description | Default value |
|----------|-------------|---------------|
| acs.repo.rendition.events.endpoint | Raw events | jms:acs-repo-rendition-events?jmsMessageType=Text |
| acs.repo.transform.request.endpoint | Transform request events | jms:acs-repo-transform-request?jmsMessageType=Text |
| activities.feed.fetchBatchSize | | 250 |
| activities.feed.generator.jsonFormatOnly | | true |
| activities.feed.max.ageMins | Feed max age (eg. 44640 mins > 31 days)| 44640 |
| activities.feed.max.idRange | Feed max ID range to limit maximum number of entries | 1000000 |
| activities.feed.max.size | Feed max size (number of entries) | 200 |
| activities.feedNotifier.batchSize | | 200 |
| activities.feedNotifier.numThreads | | 2 |
| alfresco.authentication.gateway.bufferSize | Gateway Authentication | 2048 |
| alfresco.authentication.gateway.connectTimeout | Gateway Authentication | 10000 |
| alfresco.authentication.gateway.host | Gateway authentication is disabled if empty host is specified | |
| alfresco.authentication.gateway.httpConnectionStalecheck | Gateway Authentication | true |
| alfresco.authentication.gateway.httpTcpNodelay | Gateway Authentication | true |
| alfresco.authentication.gateway.inboundHeaders | Gateway Authentication | X-Alfresco-Authenticator-Key,X-Alfresco-Remote-User |
| alfresco.authentication.gateway.outboundHeaders | Gateway Authentication | Authorization,key |
| alfresco.authentication.gateway.port | Gateway Authentication | 443 |
| alfresco.authentication.gateway.prefixUrl | Gateway Authentication | /publicapi |
| alfresco.authentication.gateway.protocol | Gateway Authentication | https |
| alfresco.authentication.gateway.readTimeout | Gateway Authentication | 120000 |
| alfresco.cluster.enabled | | true |
| alfresco.cluster.hostname | | ${localname} 
| alfresco.cluster.interface | | 
| alfresco.cluster.max.init.retries | | 50 |
| alfresco.cluster.memberchange.dropInvalidatingCaches | | true |
| alfresco.cluster.nodetype | | "Repository server" |
| alfresco.cluster.specify.interface | | false |
| alfresco.clusterCheck.timeout | | 4000 |
| alfresco.ephemeralLock.expiryThresh | Requests for ephemeral (in-memory) locks with expiry times (in seconds) greater than this value will result in persistent locks being created instead. By default this value is equal to the maximum allowed expiry for ephemeral locks, therefore this feature is disabled by default. Setting this to -1 would mean that ALL requests for ephemeral locks would result in persistent locks being created. | 172800 |
| alfresco.events.include | | CONTENTPUT, NODEMOVED, NODEADDED, NODEREMOVED, NODERENAMED, NODECHECKOUTCANCELLED, NODECHECKEDOUT, NODECHECKEDIN, AUTHADDEDTOGROUP, AUTHREMOVEDFROMGROUP, GROUPDELETED, INHERITPERMISSIONSDISABLED, INHERITPERMISSIONSENABLED, LOCALPERMISSIONGRANTED, LOCALPERMISSIONREVOKED, RECORDCREATED, RECORDREJECTED, FILECLASSIFIED, FILEUNCLASSIFIED, NODELOCKED, NODEUNLOCKED |
| alfresco.hazelcast.autoinc.port | | false |
| alfresco.hazelcast.bind.any | | false |
| alfresco.hazelcast.configLocation | | classpath:alfresco/hazelcast/hazelcast-tcp.xml |
| alfresco.hazelcast.mancenter.enabled | | false |
| alfresco.hazelcast.mancenter.url | | http://localhost:8080/mancenter |
| alfresco.hazelcast.max.no.heartbeat.seconds | | 15 |
| alfresco.hazelcast.port | | 5701 |
| alfresco.jmx.connector.enabled | Control Alfresco JMX connectivity | false |
| alfresco.restApi.basicAuthScheme | | false |
| alfresco.rmi.services.external.host | | localhost |
| alfresco.rmi.services.host | | 0.0.0.0 |
| alfresco.rmi.services.port | Default value of alfresco.rmi.services.host is 0.0.0.0 which means 'listen on all adapters'. This allows connections to JMX both remotely and locally. | 50500 |
| alfresco.rmi.services.retries | If the RMI address is in-use, how many retries should be done before aborting. Default value of alfresco.rmi.services.retries is 0 which means 'Don't retry if the address is in-use'. | 4 |
| alfresco.rmi.services.retryInterval | How long in milliseconds to wait after a failed server socket bind, before retrying | 250 |
| alfresco_user_store.adminpassword | Initial password - editing this will not have any effect once the repository is installed | ******** |
| alfresco_user_store.adminusername | Note: default admin username - should not be changed after installation | admin |
| alfresco_user_store.guestusername | Note: default guest username - should not be changed after installation | guest |
| alfresco_user_store.store | User config | user://alfrescoUserStore |
| alfresco_user_store.system_container.childname | User config | sys:system |
| alfresco_user_store.user_container.childname | User config | sys:people |
| api-explorer.url | Alfresco Rest Api-Explorer |
| attributes.propcleaner.cronExpression | Scheduled job to clean up unused properties from the alf_prop_xxx tables. Default setting of 0 0 3 ? * SAT is to run every Saturday at 3am. | 0 0 3 ? * SAT |
| audit.alfresco-access.enabled | Audit configuration | false |
| audit.alfresco-access.sub-actions.enabled | Audit configuration | false |
| audit.cmischangelog.enabled | Audit configuration | false |
| audit.config.strict | Setting this flag to true will force startup failure when invalid audit configurations are detected. | false |
| audit.dod5015.enabled | Audit configuration | false |
| audit.enabled | Audit configuration | true |
| audit.filter.alfresco-access.default.enabled | Audit map filter for AccessAuditor - restricts recorded events to user driven events | false |
| audit.filter.alfresco-access.transaction.path | Audit configuration | ~/sys:archivedItem;~/ver:;.* |
| audit.filter.alfresco-access.transaction.type | Audit configuration | cm:folder;cm:content;st:site |
| audit.filter.alfresco-access.transaction.user | Audit configuration | ~System;~null;.* |
| audit.tagging.enabled | Audit configuration | true |
| authentication.alwaysAllowBasicAuthForAdminConsole.enabled | | true |
| authentication.chain | he default authentication chain | alfrescoNtlm1:alfrescoNtlm |
| authentication.getRemoteUserTimeoutMilliseconds | | 10000 |
| authentication.protection.enabled | Brute force protection | true |
| authentication.protection.limit | Brute force protection | 10 |
| authentication.protection.periodSeconds | Brute force protection | 6 |
| authentication.ticket.expiryMode | If ticketsEpire is true then how they should expire? Valid values are: AFTER_INACTIVITY, AFTER_FIXED_TIME, DO_NOT_EXPIRE. The default is AFTER_FIXED_TIME | AFTER_INACTIVITY |
| authentication.ticket.ticketsExpire | Do authentication tickets expire or live for ever? | true |
| authentication.ticket.useSingleTicketPerUser | Use one ticket for all user sessions. For the pre 4.2 behaviour of one ticket per session set this to false. | true |
| authentication.ticket.validDuration | If authentication.ticket.ticketsExpire is true and authentication.ticket.expiryMode is AFTER_FIXED_TIME or AFTER_INACTIVITY, this controls the minimum period for which tickets are valid. The default is PT1H for one hour. | PT1H |
| authority.findAuthorityLimit | 	Limit the number of results from findAuthority query | 10000 |
| authority.useBridgeTable | Use bridge tables for caching authority evaluation. | true |
| authorization.audit.day | | 2 |
| authorization.audit.hour | | 3 |
| authorization.audit.minute | | 0 |
| authorization.locales.previous | |
| bulkImport.batch.batchSize | The size of a batch in a batch import i.e. the number of files to import in a transaction/thread | 20 |
| bulkImport.batch.numThreads | Bulk Filesystem Importer. The number of threads to employ in a batch import | 4 |
| cache.aclEntitySharedCache.backup-count | | 1 |
| cache.aclEntitySharedCache.cluster.type | | fully-distributed |
| cache.aclEntitySharedCache.eviction-policy | | LRU |
| cache.aclEntitySharedCache.maxIdleSeconds | | 0 |
| cache.aclEntitySharedCache.maxItems | | 50000 |
| cache.aclEntitySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.aclEntitySharedCache.readBackupData | | false |
| cache.aclEntitySharedCache.timeToLiveSeconds | | 0 |
| cache.aclEntitySharedCache.tx.maxItems | | 50000 |
| cache.aclEntitySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.aclSharedCache.backup-count | | 1 |
| cache.aclSharedCache.cluster.type | | fully-distributed |
| cache.aclSharedCache.eviction-policy | | LRU |
| cache.aclSharedCache.maxIdleSeconds | | 0 |
| cache.aclSharedCache.maxItems | | 50000 |
| cache.aclSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.aclSharedCache.readBackupData | | false |
| cache.aclSharedCache.timeToLiveSeconds | | 0 |
| cache.aclSharedCache.tx.maxItems | | 20000 |
| cache.aclSharedCache.tx.statsEnabled |  | ${caches.tx.statsEnabled} |
| cache.activitiTokensCache.backup-count | | 1 |
| cache.activitiTokensCache.cluster.type | | fully-distributed |
| cache.activitiTokensCache.eviction-percentage | | 1 |
| cache.activitiTokensCache.eviction-policy | | NONE |
| cache.activitiTokensCache.maxIdleSeconds | | 3600 |
| cache.activitiTokensCache.maxItems | | 0 |
| cache.activitiTokensCache.merge-policy | | hz.ADD_NEW_ENTRY |
| cache.activitiTokensCache.timeToLiveSeconds | | 0 |
| cache.authenticationSharedCache.backup-count | | 1 |
| cache.authenticationSharedCache.cluster.type | | fully-distributed |
| cache.authenticationSharedCache.eviction-policy | | LRU |
| cache.authenticationSharedCache.maxIdleSeconds | | 0 |
| cache.authenticationSharedCache.maxItems | | 5000 |
| cache.authenticationSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.authenticationSharedCache.readBackupData | | false |
| cache.authenticationSharedCache.timeToLiveSeconds | | 0 |
| cache.authenticationSharedCache.tx.maxItems | | 1000 |
| cache.authenticationSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.authorityEntitySharedCache.tx.maxItems | | 50000 |
| cache.authorityEntitySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.authoritySharedCache.backup-count | | 1 |
| cache.authoritySharedCache.cluster.type | | invalidating |
| cache.authoritySharedCache.eviction-policy | | LRU |
| cache.authoritySharedCache.maxIdleSeconds | | 0 |
| cache.authoritySharedCache.maxItems | | 10000 |
| cache.authoritySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.authoritySharedCache.readBackupData | | false |
| cache.authoritySharedCache.timeToLiveSeconds | | 0 |
| cache.authoritySharedCache.tx.maxItems | | 10000 |
| cache.authoritySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.authorityToChildAuthoritySharedCache.backup-count | | 1 |
| cache.authorityToChildAuthoritySharedCache.cluster.type | | invalidating |
| cache.authorityToChildAuthoritySharedCache.eviction-policy | | LRU |
| cache.authorityToChildAuthoritySharedCache.maxIdleSeconds | | 0 |
| cache.authorityToChildAuthoritySharedCache.maxItems | | 40000 |
| cache.authorityToChildAuthoritySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.authorityToChildAuthoritySharedCache.readBackupData | | false |
| cache.authorityToChildAuthoritySharedCache.timeToLiveSeconds | | 0 |
| cache.authorityToChildAuthoritySharedCache.tx.maxItems | | 40000 |
| cache.authorityToChildAuthoritySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.authorizationCache.backup-count | | 1 |
| cache.authorizationCache.cluster.type | | fully-distributed |
| cache.authorizationCache.eviction-policy | | LRU |
| cache.authorizationCache.maxIdleSeconds | | 0 |
| cache.authorizationCache.maxItems | | 10000 |
| cache.authorizationCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.authorizationCache.readBackupData | | false |
| cache.authorizationCache.timeToLiveSeconds | | 300 |
| cache.authorizationCache.tx.maxItems | | 1000 |
| cache.authorizationCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.cachingContentStoreCache.backup-count | | 1 |
| cache.cachingContentStoreCache.cluster.type | | local |
| cache.cachingContentStoreCache.eviction-policy | | LRU |
| cache.cachingContentStoreCache.maxIdleSeconds | | 14400 |
| cache.cachingContentStoreCache.maxItems | | 5000 |
| cache.cachingContentStoreCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.cachingContentStoreCache.readBackupData | | false |
| cache.cachingContentStoreCache.timeToLiveSeconds | | 86400 |
| cache.caveatConfigCache.backup-count | | 1 |
| cache.caveatConfigCache.cluster.type | | invalidating |
| cache.caveatConfigCache.eviction-policy | | LRU |
| cache.caveatConfigCache.maxIdleSeconds | | 0 |
| cache.caveatConfigCache.maxItems | | 5000 |
| cache.caveatConfigCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.caveatConfigCache.readBackupData | | false |
| cache.caveatConfigCache.timeToLiveSeconds | | 0 |
| cache.caveatConfigCache.tx.maxItems | | 100 |
| cache.caveatConfigCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.cloudHybridSyncDenyCache.backup-count | | 1 |
| cache.cloudHybridSyncDenyCache.cluster.type | | fully-distributed |
| cache.cloudHybridSyncDenyCache.eviction-policy | | LRU |
| cache.cloudHybridSyncDenyCache.maxIdleSeconds | | 0 |
| cache.cloudHybridSyncDenyCache.maxItems | | 150000 |
| cache.cloudHybridSyncDenyCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.cloudHybridSyncDenyCache.timeToLiveSeconds | | 3600 |
| cache.cloudHybridSyncEventCounterCache.backup-count | | 1 |
| cache.cloudHybridSyncEventCounterCache.cluster.type | | fully-distributed |
| cache.cloudHybridSyncEventCounterCache.eviction-policy | | LRU |
| cache.cloudHybridSyncEventCounterCache.maxIdleSeconds | | 0 |
| cache.cloudHybridSyncEventCounterCache.maxItems | | 150000 |
| cache.cloudHybridSyncEventCounterCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.cloudHybridSyncEventCounterCache.timeToLiveSeconds | | 0 |
| cache.contentDataSharedCache.backup-count | | 1 |
| cache.contentDataSharedCache.cluster.type | | fully-distributed | 
| cache.contentDataSharedCache.eviction-policy | | LRU |
| cache.contentDataSharedCache.maxIdleSeconds | | 0 |
| cache.contentDataSharedCache.maxItems | | 130000 |
| cache.contentDataSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.contentDataSharedCache.readBackupData | | false |
| cache.contentDataSharedCache.timeToLiveSeconds | | 0 |
| cache.contentDataSharedCache.tx.maxItems | | 65000 |
| cache.contentDataSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.contentDiskDriver.fileInfoCache.backup-count | | 1 |
| cache.contentDiskDriver.fileInfoCache.cluster.type | | local |
| cache.contentDiskDriver.fileInfoCache.eviction-policy | | LRU |
| cache.contentDiskDriver.fileInfoCache.maxIdleSeconds | | 0 |
| cache.contentDiskDriver.fileInfoCache.maxItems | | 1000 |
| cache.contentDiskDriver.fileInfoCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.contentDiskDriver.fileInfoCache.readBackupData | | false |
| cache.contentDiskDriver.fileInfoCache.timeToLiveSeconds | | 0 |
| cache.contentUrlEncryptingMasterKeySharedCache.backup-count | | 1 |
| cache.contentUrlEncryptingMasterKeySharedCache.cluster.type | | fully-distributed |
| cache.contentUrlEncryptingMasterKeySharedCache.eviction-policy | | NONE |
| cache.contentUrlEncryptingMasterKeySharedCache.maxIdleSeconds | | 0 |
| cache.contentUrlEncryptingMasterKeySharedCache.maxItems | | 0 | 
| cache.contentUrlEncryptingMasterKeySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.contentUrlEncryptingMasterKeySharedCache.nearCache.maxIdleSeconds | | 0 | 
| cache.contentUrlEncryptingMasterKeySharedCache.nearCache.maxSize | | 50 |
| cache.contentUrlEncryptingMasterKeySharedCache.nearCache.timeToLiveSeconds | | 0 |
| cache.contentUrlEncryptingMasterKeySharedCache.readBackupData | | false |
| cache.contentUrlEncryptingMasterKeySharedCache.timeToLiveSeconds | | 0 |
| cache.contentUrlEncryptingMasterKeySharedCache.tx.maxItems | | 50 |
| cache.contentUrlEncryptingMasterKeySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.contentUrlMasterKeySharedCache.backup-count | | 1 |
| cache.contentUrlMasterKeySharedCache.cluster.type | | fully-distributed |
| cache.contentUrlMasterKeySharedCache.eviction-policy | | NONE |
| cache.contentUrlMasterKeySharedCache.maxIdleSeconds | | 0 |
| cache.contentUrlMasterKeySharedCache.maxItems | | 0 |
| cache.contentUrlMasterKeySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.contentUrlMasterKeySharedCache.nearCache.maxIdleSeconds | | 0 |
| cache.contentUrlMasterKeySharedCache.nearCache.maxSize | | 50 |
| cache.contentUrlMasterKeySharedCache.nearCache.timeToLiveSeconds | | 0 |
| cache.contentUrlMasterKeySharedCache.readBackupData | | false |
| cache.contentUrlMasterKeySharedCache.timeToLiveSeconds | | 0 |
| cache.contentUrlMasterKeySharedCache.tx.maxItems | | 50 |
| cache.contentUrlMasterKeySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.contentUrlSharedCache.backup-count | | 1 |
| cache.contentUrlSharedCache.cluster.type | | fully-distributed |
| cache.contentUrlSharedCache.eviction-policy | | LRU |
| cache.contentUrlSharedCache.maxIdleSeconds | | 0 |
| cache.contentUrlSharedCache.maxItems | | 130000 |
| cache.contentUrlSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.contentUrlSharedCache.readBackupData | | false |
| cache.contentUrlSharedCache.timeToLiveSeconds | | 0 |
| cache.contentUrlSharedCache.tx.maxItems | | 65000 |
| cache.contentUrlSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.executingActionsCache.backup-count | | 1 |
| cache.executingActionsCache.cluster.type | | fully-distributed |
| cache.executingActionsCache.eviction-policy | | LRU |
| cache.executingActionsCache.maxIdleSeconds | | 0 |
| cache.executingActionsCache.maxItems | | 1000 |
| cache.executingActionsCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.executingActionsCache.readBackupData | | false |
| cache.executingActionsCache.timeToLiveSeconds | | 0 |
| cache.globalConfigSharedCache.backup-count | | 1 |
| cache.globalConfigSharedCache.cluster.type | | invalidating |
| cache.globalConfigSharedCache.eviction-policy | | LRU |
| cache.globalConfigSharedCache.maxIdleSeconds | | 0 |
| cache.globalConfigSharedCache.maxItems | | 1000 |
| cache.globalConfigSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.globalConfigSharedCache.readBackupData | | false |
| cache.globalConfigSharedCache.timeToLiveSeconds | | 0 |
| cache.hbClusterUsageCache.backup-count | | 1 |
| cache.hbClusterUsageCache.cluster.type | | fully-distributed |
| cache.hbClusterUsageCache.eviction-policy | | NONE |
| cache.hbClusterUsageCache.maxIdleSeconds | | 0 |
| cache.hbClusterUsageCache.maxItems | | 10 |
| cache.hbClusterUsageCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.hbClusterUsageCache.readBackupData | | false |
| cache.hbClusterUsageCache.timeToLiveSeconds | | 0 |
| cache.imapMessageSharedCache.backup-count | | 1 |
| cache.imapMessageSharedCache.cluster.type | | invalidating |
| cache.imapMessageSharedCache.eviction-policy | | LRU |
| cache.imapMessageSharedCache.maxIdleSeconds | | 0 |
| cache.imapMessageSharedCache.maxItems | | 2000 |
| cache.imapMessageSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.imapMessageSharedCache.readBackupData | | false |
| cache.imapMessageSharedCache.timeToLiveSeconds | | 0 |
| cache.imapMessageSharedCache.tx.maxItems | | 1000 |
| cache.imapMessageSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.immutableEntitySharedCache.backup-count | | 1 |
| cache.immutableEntitySharedCache.cluster.type | | invalidating |
| cache.immutableEntitySharedCache.eviction-policy | | LRU |
| cache.immutableEntitySharedCache.maxIdleSeconds | | 0 |
| cache.immutableEntitySharedCache.maxItems | | 50000 |
| cache.immutableEntitySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.immutableEntitySharedCache.readBackupData | | false |
| cache.immutableEntitySharedCache.timeToLiveSeconds | | 0 |
| cache.immutableEntitySharedCache.tx.maxItems | | 10000 |
| cache.immutableEntitySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.immutableSingletonSharedCache.backup-count | | 1 |
| cache.immutableSingletonSharedCache.cluster.type | | invalidating |
| cache.immutableSingletonSharedCache.eviction-policy | | LRU |
| cache.immutableSingletonSharedCache.maxIdleSeconds | | 0 |
| cache.immutableSingletonSharedCache.maxItems | | 12000 |
| cache.immutableSingletonSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.immutableSingletonSharedCache.readBackupData | | false |
| cache.immutableSingletonSharedCache.timeToLiveSeconds | | 0 |
| cache.immutableSingletonSharedCache.tx.maxItems | | 12000 |
| cache.immutableSingletonSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.loadedResourceBundlesSharedCache.backup-count | | 1 |
| cache.loadedResourceBundlesSharedCache.cluster.type | | invalidating |
| cache.loadedResourceBundlesSharedCache.eviction-policy | | LRU |
| cache.loadedResourceBundlesSharedCache.maxIdleSeconds | | 0 |
| cache.loadedResourceBundlesSharedCache.maxItems | | 1000 |
| cache.loadedResourceBundlesSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.loadedResourceBundlesSharedCache.readBackupData | | false |
| cache.loadedResourceBundlesSharedCache.timeToLiveSeconds | | 0 |
| cache.loadedResourceBundlesSharedCache.tx.maxItems | | 1000 |
| cache.loadedResourceBundlesSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.messagesSharedCache.backup-count | | 1 |
| cache.messagesSharedCache.cluster.type | | invalidating |
| cache.messagesSharedCache.eviction-policy | | LRU |
| cache.messagesSharedCache.maxIdleSeconds | | 0 |
| cache.messagesSharedCache.maxItems | | 1000 |
| cache.messagesSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.messagesSharedCache.readBackupData | | false |
| cache.messagesSharedCache.timeToLiveSeconds | | 0 |
| cache.messagesSharedCache.tx.maxItems | | 1000 |
| cache.messagesSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.node.allRootNodesSharedCache.backup-count | | 1 |
| cache.node.allRootNodesSharedCache.cluster.type | | invalidating |
| cache.node.allRootNodesSharedCache.eviction-policy | | LRU |
| cache.node.allRootNodesSharedCache.maxIdleSeconds | | 0 |
| cache.node.allRootNodesSharedCache.maxItems | | 1000 |
| cache.node.allRootNodesSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.node.allRootNodesSharedCache.readBackupData | | false |
| cache.node.allRootNodesSharedCache.timeToLiveSeconds | | 0 |
| cache.node.allRootNodesSharedCache.tx.maxItems | | 500 |
| cache.node.allRootNodesSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.node.aspectsSharedCache.backup-count | | 1 |
| cache.node.aspectsSharedCache.cluster.type | | local |
| cache.node.aspectsSharedCache.eviction-policy | | LRU |
| cache.node.aspectsSharedCache.maxIdleSeconds                               0
| cache.node.aspectsSharedCache.maxItems                                     130000
| cache.node.aspectsSharedCache.merge-policy                                 com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.node.aspectsSharedCache.readBackupData                               false
| cache.node.aspectsSharedCache.timeToLiveSeconds                            0
| cache.node.aspectsSharedCache.tx.maxItems                                  65000
| cache.node.aspectsSharedCache.tx.statsEnabled                              ${caches.tx.statsEnabled}
| cache.node.childByNameSharedCache.backup-count                             1
| cache.node.childByNameSharedCache.cluster.type                             local
| cache.node.childByNameSharedCache.eviction-policy                          LRU
| cache.node.childByNameSharedCache.maxIdleSeconds                           0
| cache.node.childByNameSharedCache.maxItems                                 130000
| cache.node.childByNameSharedCache.merge-policy                             com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.node.childByNameSharedCache.readBackupData                           false
| cache.node.childByNameSharedCache.timeToLiveSeconds                        0
| cache.node.childByNameSharedCache.tx.maxItems                              65000
| cache.node.childByNameSharedCache.tx.statsEnabled                          ${caches.tx.statsEnabled}
| cache.node.nodesSharedCache.backup-count                                   1
| cache.node.nodesSharedCache.cluster.type                                   invalidating
| cache.node.nodesSharedCache.eviction-policy                                LRU
| cache.node.nodesSharedCache.maxIdleSeconds                                 0
| cache.node.nodesSharedCache.maxItems                                       250000
| cache.node.nodesSharedCache.merge-policy                                   com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.node.nodesSharedCache.readBackupData                                 false
| cache.node.nodesSharedCache.timeToLiveSeconds                              300
| cache.node.nodesSharedCache.tx.maxItems                                    125000
| cache.node.nodesSharedCache.tx.statsEnabled                                ${caches.tx.statsEnabled}
| cache.node.parentAssocsSharedCache.backup-count                            1
| cache.node.parentAssocsSharedCache.cluster.type                            fully-distributed
| cache.node.parentAssocsSharedCache.eviction-policy                         LRU
| cache.node.parentAssocsSharedCache.maxIdleSeconds                          0
| cache.node.parentAssocsSharedCache.maxItems                                130000
| cache.node.parentAssocsSharedCache.merge-policy                            com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.node.parentAssocsSharedCache.readBackupData                          false
| cache.node.parentAssocsSharedCache.timeToLiveSeconds                       0
| cache.node.propertiesSharedCache.backup-count                              1
| cache.node.propertiesSharedCache.cluster.type                              local
| cache.node.propertiesSharedCache.eviction-policy                           LRU
| cache.node.propertiesSharedCache.maxIdleSeconds                            0
| cache.node.propertiesSharedCache.maxItems                                  130000
| cache.node.propertiesSharedCache.merge-policy                              com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.node.propertiesSharedCache.readBackupData                            false
| cache.node.propertiesSharedCache.timeToLiveSeconds                         0
| cache.node.propertiesSharedCache.tx.maxItems                               65000
| cache.node.propertiesSharedCache.tx.statsEnabled                           ${caches.tx.statsEnabled}
| cache.node.rootNodesSharedCache.backup-count                               1
| cache.node.rootNodesSharedCache.cluster.type                               invalidating
| cache.node.rootNodesSharedCache.eviction-policy                            LRU
| cache.node.rootNodesSharedCache.maxIdleSeconds                             0
| cache.node.rootNodesSharedCache.maxItems                                   1000
| cache.node.rootNodesSharedCache.merge-policy                               com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.node.rootNodesSharedCache.readBackupData                             false
| cache.node.rootNodesSharedCache.timeToLiveSeconds                          0
| cache.node.rootNodesSharedCache.tx.maxItems                                1000
| cache.node.rootNodesSharedCache.tx.statsEnabled                            ${caches.tx.statsEnabled}
| cache.nodeOwnerSharedCache.backup-count                                    1
| cache.nodeOwnerSharedCache.cluster.type                                    fully-distributed
| cache.nodeOwnerSharedCache.eviction-policy                                 LRU
| cache.nodeOwnerSharedCache.maxIdleSeconds                                  0
| cache.nodeOwnerSharedCache.maxItems                                        40000
| cache.nodeOwnerSharedCache.merge-policy                                    com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.nodeOwnerSharedCache.readBackupData                                  false
| cache.nodeOwnerSharedCache.timeToLiveSeconds                               0
| cache.nodeOwnerSharedCache.tx.maxItems                                     40000
| cache.nodeOwnerSharedCache.tx.statsEnabled                                 ${caches.tx.statsEnabled}
| cache.nodeRulesSharedCache.tx.maxItems                                     2000
| cache.nodeRulesSharedCache.tx.statsEnabled                                 ${caches.tx.statsEnabled}
| cache.openCMISRegistrySharedCache.backup-count                             1
| cache.openCMISRegistrySharedCache.cluster.type                             invalidating
| cache.openCMISRegistrySharedCache.eviction-policy                          LRU
| cache.openCMISRegistrySharedCache.maxIdleSeconds                           0
| cache.openCMISRegistrySharedCache.maxItems                                 500
| cache.openCMISRegistrySharedCache.merge-policy                             com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.openCMISRegistrySharedCache.readBackupData                           false
| cache.openCMISRegistrySharedCache.timeToLiveSeconds                        1800
| cache.openCMISRegistrySharedCache.tx.maxItems                              5
| cache.openCMISRegistrySharedCache.tx.statsEnabled                          ${caches.tx.statsEnabled}
| cache.permissionEntitySharedCache.tx.maxItems                              50000
| cache.permissionEntitySharedCache.tx.statsEnabled                          ${caches.tx.statsEnabled}
| cache.permissionsAccessSharedCache.backup-count                            1
| cache.permissionsAccessSharedCache.cluster.type                            fully-distributed
| cache.permissionsAccessSharedCache.eviction-policy                         LRU
| cache.permissionsAccessSharedCache.maxIdleSeconds                          0
| cache.permissionsAccessSharedCache.maxItems                                50000
| cache.permissionsAccessSharedCache.merge-policy                            com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.permissionsAccessSharedCache.readBackupData                          false
| cache.permissionsAccessSharedCache.timeToLiveSeconds                       0
| cache.permissionsAccessSharedCache.tx.maxItems                             10000
| cache.permissionsAccessSharedCache.tx.statsEnabled                         ${caches.tx.statsEnabled}
| cache.personSharedCache.backup-count                                       1
| cache.personSharedCache.cluster.type                                       fully-distributed
| cache.personSharedCache.eviction-policy                                    LRU
| cache.personSharedCache.maxIdleSeconds                                     0
| cache.personSharedCache.maxItems                                           1000
| cache.personSharedCache.merge-policy                                       com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.personSharedCache.readBackupData                                     false
| cache.personSharedCache.timeToLiveSeconds                                  0
| cache.personSharedCache.tx.maxItems                                        1000
| cache.personSharedCache.tx.statsEnabled                                    ${caches.tx.statsEnabled}
| cache.propertyClassCache.backup-count                                      1
| cache.propertyClassCache.cluster.type                                      invalidating
| cache.propertyClassCache.eviction-policy                                   LRU
| cache.propertyClassCache.maxIdleSeconds                                    0
| cache.propertyClassCache.maxItems                                          10000
| cache.propertyClassCache.merge-policy                                      com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.propertyClassCache.readBackupData                                    false
| cache.propertyClassCache.timeToLiveSeconds                                 0
| cache.propertyClassCache.tx.maxItems                                       1000
| cache.propertyClassCache.tx.statsEnabled                                   ${caches.tx.statsEnabled}
| cache.propertyUniqueContextSharedCache.backup-count                        1
| cache.propertyUniqueContextSharedCache.cluster.type                        invalidating
| cache.propertyUniqueContextSharedCache.eviction-policy                     LRU
| cache.propertyUniqueContextSharedCache.maxIdleSeconds                      0
| cache.propertyUniqueContextSharedCache.maxItems                            10000
| cache.propertyUniqueContextSharedCache.merge-policy                        com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.propertyUniqueContextSharedCache.readBackupData                      false
| cache.propertyUniqueContextSharedCache.timeToLiveSeconds                   0
| cache.propertyUniqueContextSharedCache.tx.maxItems                         10000
| cache.propertyUniqueContextSharedCache.tx.statsEnabled                     ${caches.tx.statsEnabled}
| cache.propertyValueCache.backup-count                                      1
| cache.propertyValueCache.cluster.type                                      invalidating
| cache.propertyValueCache.eviction-policy                                   LRU
| cache.propertyValueCache.maxIdleSeconds                                    0
| cache.propertyValueCache.maxItems                                          10000
| cache.propertyValueCache.merge-policy                                      com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.propertyValueCache.readBackupData                                    false
| cache.propertyValueCache.timeToLiveSeconds                                 300
| cache.propertyValueCache.tx.maxItems                                       1000
| cache.propertyValueCache.tx.statsEnabled                                   ${caches.tx.statsEnabled}
| cache.protectedUsersCache.backup-count                                     1
| cache.protectedUsersCache.cluster.type                                     local
| cache.protectedUsersCache.eviction-policy                                  LRU
| cache.protectedUsersCache.maxIdleSeconds                                   0
| cache.protectedUsersCache.maxItems                                         1000
| cache.protectedUsersCache.merge-policy                                     com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.protectedUsersCache.readBackupData                                   false
| cache.protectedUsersCache.timeToLiveSeconds                                0
| cache.publicapi.webScriptsRegistryCache.backup-count                       1
| cache.publicapi.webScriptsRegistryCache.cluster.type                       invalidating
| cache.publicapi.webScriptsRegistryCache.eviction-policy                    LRU
| cache.publicapi.webScriptsRegistryCache.maxIdleSeconds                     0
| cache.publicapi.webScriptsRegistryCache.maxItems                           1000
| cache.publicapi.webScriptsRegistryCache.merge-policy                       com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.publicapi.webScriptsRegistryCache.readBackupData                     false
| cache.publicapi.webScriptsRegistryCache.timeToLiveSeconds                  0
| cache.readersDeniedSharedCache.backup-count                                1
| cache.readersDeniedSharedCache.cluster.type                                fully-distributed
| cache.readersDeniedSharedCache.eviction-policy                             LRU
| cache.readersDeniedSharedCache.maxIdleSeconds                              0
| cache.readersDeniedSharedCache.maxItems                                    10000
| cache.readersDeniedSharedCache.merge-policy                                com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.readersDeniedSharedCache.readBackupData                              false
| cache.readersDeniedSharedCache.timeToLiveSeconds                           0
| cache.readersDeniedSharedCache.tx.maxItems                                 10000
| cache.readersDeniedSharedCache.tx.statsEnabled                             ${caches.tx.statsEnabled}
| cache.readersSharedCache.backup-count                                      1
| cache.readersSharedCache.cluster.type                                      fully-distributed
| cache.readersSharedCache.eviction-policy                                   LRU
| cache.readersSharedCache.maxIdleSeconds                                    0
| cache.readersSharedCache.maxItems                                          10000
| cache.readersSharedCache.merge-policy                                      com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.readersSharedCache.readBackupData                                    false
| cache.readersSharedCache.timeToLiveSeconds                                 0
| cache.readersSharedCache.tx.maxItems                                       10000
| cache.readersSharedCache.tx.statsEnabled                                   ${caches.tx.statsEnabled}
| cache.remoteAlfrescoTicketService.ticketsCache.backup-count                1
| cache.remoteAlfrescoTicketService.ticketsCache.cluster.type                fully-distributed
| cache.remoteAlfrescoTicketService.ticketsCache.eviction-policy             LRU
| cache.remoteAlfrescoTicketService.ticketsCache.maxIdleSeconds              0
| cache.remoteAlfrescoTicketService.ticketsCache.maxItems                    1000
| cache.remoteAlfrescoTicketService.ticketsCache.merge-policy                com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.remoteAlfrescoTicketService.ticketsCache.readBackupData              false
| cache.remoteAlfrescoTicketService.ticketsCache.timeToLiveSeconds           0
| cache.resourceBundleBaseNamesSharedCache.backup-count                      1
| cache.resourceBundleBaseNamesSharedCache.cluster.type                      invalidating
| cache.resourceBundleBaseNamesSharedCache.eviction-policy                   LRU
| cache.resourceBundleBaseNamesSharedCache.maxIdleSeconds                    0
| cache.resourceBundleBaseNamesSharedCache.maxItems                          1000
| cache.resourceBundleBaseNamesSharedCache.merge-policy                      com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.resourceBundleBaseNamesSharedCache.readBackupData                    false
| cache.resourceBundleBaseNamesSharedCache.timeToLiveSeconds                 0
| cache.resourceBundleBaseNamesSharedCache.tx.maxItems                       1000
| cache.resourceBundleBaseNamesSharedCache.tx.statsEnabled                   ${caches.tx.statsEnabled}
| cache.routingContentStoreSharedCache.backup-count                          1
| cache.routingContentStoreSharedCache.cluster.type                          local
| cache.routingContentStoreSharedCache.eviction-policy                       LRU
| cache.routingContentStoreSharedCache.maxIdleSeconds                        0
| cache.routingContentStoreSharedCache.maxItems                              10000
| cache.routingContentStoreSharedCache.merge-policy                          com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.routingContentStoreSharedCache.readBackupData                        false
| cache.routingContentStoreSharedCache.timeToLiveSeconds                     0
| cache.routingContentStoreSharedCache.tx.maxItems                           10000
| cache.routingContentStoreSharedCache.tx.statsEnabled                       ${caches.tx.statsEnabled}
| cache.samlTrustEngineSharedCache.backup-count                              1
| cache.samlTrustEngineSharedCache.cluster.type                              invalidating
| cache.samlTrustEngineSharedCache.eviction-policy                           LRU
| cache.samlTrustEngineSharedCache.maxIdleSeconds                            0
| cache.samlTrustEngineSharedCache.maxItems                                  5000
| cache.samlTrustEngineSharedCache.merge-policy                              com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.samlTrustEngineSharedCache.readBackupData                            false
| cache.samlTrustEngineSharedCache.timeToLiveSeconds                         0
| cache.samlTrustEngineSharedCache.tx.maxItems                               5000
| cache.samlTrustEngineSharedCache.tx.statsEnabled                           ${caches.tx.statsEnabled}
| cache.shardStateSharedCache.backup-count                                   1
| cache.shardStateSharedCache.cluster.type                                   invalidating
| cache.shardStateSharedCache.eviction-policy                                LRU
| cache.shardStateSharedCache.maxIdleSeconds                                 0
| cache.shardStateSharedCache.maxItems                                       500
| cache.shardStateSharedCache.merge-policy                                   com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.shardStateSharedCache.readBackupData                                 false
| cache.shardStateSharedCache.timeToLiveSeconds                              1800
| cache.shardStateSharedCache.tx.maxItems                                    100
| cache.shardStateSharedCache.tx.statsEnabled                                ${caches.tx.statsEnabled}
| cache.shardToGuidSharedCache.backup-count                                  1
| cache.shardToGuidSharedCache.cluster.type                                  invalidating
| cache.shardToGuidSharedCache.eviction-policy                               LRU
| cache.shardToGuidSharedCache.maxIdleSeconds                                0
| cache.shardToGuidSharedCache.maxItems                                      500
| cache.shardToGuidSharedCache.merge-policy                                  com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.shardToGuidSharedCache.readBackupData                                false
| cache.shardToGuidSharedCache.timeToLiveSeconds                             0
| cache.shardToGuidSharedCache.tx.maxItems                                   100
| cache.shardToGuidSharedCache.tx.statsEnabled                               ${caches.tx.statsEnabled}
| cache.siteNodeRefSharedCache.backup-count                                  1
| cache.siteNodeRefSharedCache.cluster.type                                  fully-distributed
| cache.siteNodeRefSharedCache.eviction-policy                               LRU
| cache.siteNodeRefSharedCache.maxIdleSeconds                                0
| cache.siteNodeRefSharedCache.maxItems                                      5000
| cache.siteNodeRefSharedCache.merge-policy                                  com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.siteNodeRefSharedCache.readBackupData                                false
| cache.siteNodeRefSharedCache.timeToLiveSeconds                             0
| cache.siteNodeRefSharedCache.tx.maxItems                                   5000
| cache.siteNodeRefSharedCache.tx.statsEnabled                               ${caches.tx.statsEnabled}
| cache.solrFacetNodeRefSharedCache.backup-count                             1
| cache.solrFacetNodeRefSharedCache.cluster.type                             fully-distributed
| cache.solrFacetNodeRefSharedCache.eviction-policy                          LRU
| cache.solrFacetNodeRefSharedCache.maxIdleSeconds                           0
| cache.solrFacetNodeRefSharedCache.maxItems                                 5000
| cache.solrFacetNodeRefSharedCache.merge-policy                             com.hazelcast.map.merge.LatestUpdateMapMergePolicy
| cache.solrFacetNodeRefSharedCache.readBackupData                           false
| cache.solrFacetNodeRefSharedCache.timeToLiveSeconds                        0
| cache.solrFacetNodeRefSharedCache.tx.maxItems                              5000
| cache.solrFacetNodeRefSharedCache.tx.statsEnabled                          ${caches.tx.statsEnabled}
| cache.tagscopeSummarySharedCache.backup-count                              1
| cache.tagscopeSummarySharedCache.cluster.type                              fully-distributed
| cache.tagscopeSummarySharedCache.eviction-policy                           LRU
| cache.tagscopeSummarySharedCache.maxIdleSeconds                            0
| cache.tagscopeSummarySharedCache.maxItems                                  1000
| cache.tagscopeSummarySharedCache.merge-policy                              com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.tagscopeSummarySharedCache.readBackupData                            false
| cache.tagscopeSummarySharedCache.timeToLiveSeconds                         0
| cache.tagscopeSummarySharedCache.tx.maxItems                               1000
| cache.tagscopeSummarySharedCache.tx.statsEnabled                           ${caches.tx.statsEnabled}
| cache.tenantEntitySharedCache.backup-count                                 1
| cache.tenantEntitySharedCache.cluster.type                                 fully-distributed
| cache.tenantEntitySharedCache.eviction-policy                              LRU
| cache.tenantEntitySharedCache.maxIdleSeconds                               0
| cache.tenantEntitySharedCache.maxItems                                     1000
| cache.tenantEntitySharedCache.merge-policy                                 com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.tenantEntitySharedCache.readBackupData                               false
| cache.tenantEntitySharedCache.timeToLiveSeconds                            0
| cache.tenantEntitySharedCache.tx.maxItems                                  1000
| cache.tenantEntitySharedCache.tx.statsEnabled                              ${caches.tx.statsEnabled}
| cache.ticketsCache.backup-count                                            1
| cache.ticketsCache.cluster.type                                            fully-distributed
| cache.ticketsCache.eviction-policy                                         LRU
| cache.ticketsCache.maxIdleSeconds                                          0
| cache.ticketsCache.maxItems                                                1000
| cache.ticketsCache.merge-policy                                            com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.ticketsCache.readBackupData                                          false
| cache.ticketsCache.timeToLiveSeconds                                       0
| cache.userToAuthoritySharedCache.backup-count                              1
| cache.userToAuthoritySharedCache.cluster.type                              fully-distributed
| cache.userToAuthoritySharedCache.eviction-policy                           LRU
| cache.userToAuthoritySharedCache.maxIdleSeconds                            0
| cache.userToAuthoritySharedCache.maxItems                                  5000
| cache.userToAuthoritySharedCache.merge-policy                              com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.userToAuthoritySharedCache.readBackupData                            false
| cache.userToAuthoritySharedCache.timeToLiveSeconds                         0
| cache.userToAuthoritySharedCache.tx.maxItems                               100
| cache.userToAuthoritySharedCache.tx.statsEnabled                           ${caches.tx.statsEnabled}
| cache.usernameToTicketIdCache.backup-count                                 1
| cache.usernameToTicketIdCache.cluster.type                                 fully-distributed
| cache.usernameToTicketIdCache.eviction-policy                              LRU
| cache.usernameToTicketIdCache.maxIdleSeconds                               0
| cache.usernameToTicketIdCache.maxItems                                     1000
| cache.usernameToTicketIdCache.merge-policy                                 com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.usernameToTicketIdCache.readBackupData                               false
| cache.usernameToTicketIdCache.timeToLiveSeconds                            0
| cache.webScriptsRegistrySharedCache.backup-count                           1
| cache.webScriptsRegistrySharedCache.cluster.type                           invalidating
| cache.webScriptsRegistrySharedCache.eviction-policy                        LRU
| cache.webScriptsRegistrySharedCache.maxIdleSeconds                         0
| cache.webScriptsRegistrySharedCache.maxItems                               1000
| cache.webScriptsRegistrySharedCache.merge-policy                           com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.webScriptsRegistrySharedCache.readBackupData                         false
| cache.webScriptsRegistrySharedCache.timeToLiveSeconds                      0
| cache.webServicesQuerySessionSharedCache.backup-count                      1
| cache.webServicesQuerySessionSharedCache.cluster.type                      fully-distributed
| cache.webServicesQuerySessionSharedCache.eviction-policy                   LRU
| cache.webServicesQuerySessionSharedCache.maxIdleSeconds                    0
| cache.webServicesQuerySessionSharedCache.maxItems                          1000
| cache.webServicesQuerySessionSharedCache.merge-policy                      com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.webServicesQuerySessionSharedCache.readBackupData                    false
| cache.webServicesQuerySessionSharedCache.timeToLiveSeconds                 0
| cache.webServicesQuerySessionSharedCache.tx.maxItems                       50
| cache.webServicesQuerySessionSharedCache.tx.statsEnabled                   ${caches.tx.statsEnabled}
| cache.zoneToAuthoritySharedCache.backup-count                              1
| cache.zoneToAuthoritySharedCache.cluster.type                              invalidating
| cache.zoneToAuthoritySharedCache.eviction-policy                           LRU
| cache.zoneToAuthoritySharedCache.maxIdleSeconds                            0
| cache.zoneToAuthoritySharedCache.maxItems                                  500
| cache.zoneToAuthoritySharedCache.merge-policy                              com.hazelcast.map.merge.PutIfAbsentMapMergePolicy
| cache.zoneToAuthoritySharedCache.readBackupData                            false
| cache.zoneToAuthoritySharedCache.timeToLiveSeconds                         0
| cache.zoneToAuthoritySharedCache.tx.maxItems                               500
| cache.zoneToAuthoritySharedCache.tx.statsEnabled                           ${caches.tx.statsEnabled}
| caches.tx.statsEnabled                                                     true
| category.queryFetchSize                                                    5000
| cmis.disable.hidden.leading.period.files                                   false
| content.metadataExtracter.default.timeoutMs                                20000
| content.metadataExtracter.pdf.maxConcurrentExtractionsCount                5
| content.metadataExtracter.pdf.maxDocumentSizeMB                            10
| content.metadataExtracter.pdf.overwritePolicy                              PRAGMATIC
| content.transformer.PdfBox.extractBookmarksText                            true
| content.transformer.retryOn.different.mimetype                             true
| contentPropertyRestrictions.enabled                                        true
| contentPropertyRestrictions.whitelist                                      
| cors.allowed.headers                                                       Authorization,Content-Type,Cache-Control,X-Requested-With,accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers,X-CSRF-Token
| cors.allowed.methods                                                       GET,POST,HEAD,OPTIONS,PUT,DELETE
| cors.allowed.origins                                                       
| cors.enabled                                                               false
| cors.exposed.headers                                                       Access-Control-Allow-Origin,Access-Control-Allow-Credentials
| cors.preflight.maxage                                                      10
| cors.support.credentials                                                   true
| create.missing.people                                                      ${server.transaction.allow-writes}
| csrf.filter.enabled                                                        false
| csrf.filter.origin                                                         
| csrf.filter.origin.always                                                  false
| csrf.filter.referer                                                        
| csrf.filter.referer.always                                                 false
| db.driver                                                                  org.postgresql.Driver
| db.name                                                                    alfresco
| db.password                                                                ********
| db.pool.abandoned.detect                                                   false
| db.pool.abandoned.log                                                      false
| db.pool.abandoned.time                                                     300
| db.pool.evict.idle.min                                                     1800000
| db.pool.evict.interval                                                     600000
| db.pool.evict.num.tests                                                    -1
| db.pool.evict.validate                                                     false
| db.pool.idle                                                               10
| db.pool.initial                                                            10
| db.pool.max                                                                275
| db.pool.min                                                                10
| db.pool.statements.enable                                                  true
| db.pool.statements.max                                                     40
| db.pool.validate.borrow                                                    true
| db.pool.validate.query                                                     
| db.pool.validate.return                                                    false
| db.pool.wait.max                                                           5000
| db.schema.name                                                             
| db.schema.stopAfterSchemaBootstrap                                         false
| db.schema.update                                                           true
| db.schema.update.lockRetryCount                                            24
| db.schema.update.lockRetryWaitSeconds                                      5
| db.txn.isolation                                                           -1
| db.url                                                                     jdbc:postgresql://postgres:5432/alfresco
| db.username                                                                alfresco
| default.async.action.corePoolSize                                          8
| default.async.action.maximumPoolSize                                       20
| default.async.action.threadPriority                                        1
| deployment.method                                                          DOCKER_COMPOSE
| deployment.service.corePoolSize                                            2
| deployment.service.maximumPoolSize                                         3
| deployment.service.numberOfSendingThreads                                  5
| deployment.service.targetLockRefreshTime                                   60000
| deployment.service.targetLockTimeout                                       3600000
| deployment.service.threadPriority                                          5
| dir.cachedcontent                                                          ${dir.root}/cachedcontent
| dir.contentstore                                                           ${dir.root}/contentstore
| dir.contentstore.bucketsPerMinute                                          0
| dir.contentstore.deleted                                                   ${dir.root}/contentstore.deleted
| dir.contentstore.tenants                                                   
| dir.indexes                                                                ${dir.root}/lucene-indexes
| dir.indexes.backup                                                         ${dir.root}/backup-lucene-indexes
| dir.indexes.lock                                                           ${dir.indexes}/locks
| dir.keystore                                                               classpath:alfresco/keystore
| dir.license.external                                                       .
| dir.root                                                                   ./alf_data
| domain.name.caseSensitive                                                  false
| domain.separator                                                           
| download.cleaner.batchSize                                                 1000
| download.cleaner.cleanAllSysDownloadFolders                                true
| download.cleaner.maxAgeMins                                                60
| download.cleaner.repeatIntervalMilliseconds                                3600000
| download.cleaner.startDelayMilliseconds                                    3600000
| download.maxContentSize                                                    2152852358
| dsync.checkDuration                                                        60000
| dsync.client.ignorePatterns                                                ^\..*,IGNORE;^~.*,IGNORE;^.*\.(iso|exe|app|tmp|TMP)$,IGNORE;^.*\.sb-.*$,IGNORE;untitled folder,IGNORE;Microsoft User Data,IGNORE;About Stacks.lpdf,IGNORE;Thumbs.db,IGNORE
| dsync.client.version.min                                                   1.0.1
| dsync.events.include                                                       DEVICESUBSCRIPTION, DEVICESUBSCRIPTIONREMOVED, SYNCNODESUBSCRIBE, SYNCNODEUNSUBSCRIBE, NODECHECKEDOUT
| dsync.filter.aspects                                                       cm:workingcopy, ${dsync.filter.aspects.smartFolder}
| dsync.filter.aspects.smartFolder                                           sf:*, smf:*, ${smart.folders.config.type.templates.qname.filter}
| dsync.filter.nodeTypes                                                     fm:*, cm:thumbnail, cm:rating, cm:failedThumbnail, rma:rmsite include_subtypes
| dsync.maxSubscribersPerUser                                                -1
| dsync.messaging.events.repo.node.target.endpoint                           activemq:topic:VirtualTopic.alfresco.repo.events.nodes?jmsMessageType=Text
| dsync.service.uris                                                         http://localhost:9090/alfresco
| dsync.whitelistAllNodeTypes                                                false
| encryption.bootstrap.reencrypt                                             false
| encryption.cipherAlgorithm                                                 AES/CBC/PKCS5Padding
| encryption.keyAlgorithm                                                    AES
| encryption.keySpec.class                                                   org.alfresco.encryption.DESEDEKeyGenerator
| encryption.keystore.backup.keyMetaData.location                            
| encryption.keystore.backup.location                                        ${dir.keystore}/backup-keystore
| encryption.keystore.backup.provider                                        
| encryption.keystore.backup.type                                            pkcs12
| encryption.keystore.keyMetaData.location                                   
| encryption.keystore.location                                               ${dir.keystore}/keystore
| encryption.keystore.provider                                               
| encryption.keystore.type                                                   pkcs12
| encryption.mac.algorithm                                                   HmacSHA1
| encryption.mac.messageTimeout                                              30000
| encryption.reencryptor.chunkSize                                           100
| encryption.reencryptor.numThreads                                          2
| encryption.ssl.keystore.keyMetaData.location                               
| encryption.ssl.keystore.location                                           ${dir.keystore}/ssl.keystore
| encryption.ssl.keystore.provider                                           
| encryption.ssl.keystore.type                                               JCEKS
| encryption.ssl.truststore.keyMetaData.location                             
| encryption.ssl.truststore.location                                         ${dir.keystore}/ssl.truststore
| encryption.ssl.truststore.provider                                         
| encryption.ssl.truststore.type                                             JCEKS
| events.subsystem.autoStart                                                 true
| fileFolderService.checkHidden.enabled                                      true
| filecontentstore.subsystem.name                                            unencryptedContentStore
| ftp.enabled                                                                false
| fts.indexer.batchSize                                                      1000
| heartbeat.enabled                                                          true
| heartbeat.target.url                                                       
| hibernate.jdbc.use_get_generated_keys                                      false
| home.folder.creation.disabled                                              false
| home.folder.creation.eager                                                 true
| home_folder_provider_synchronizer.enabled                                  false
| home_folder_provider_synchronizer.keep_empty_parents                       false
| home_folder_provider_synchronizer.override_provider                        
| hybridworkflow.enabled                                                     false
| imap.attachments.folder.folderPath                                         ${spaces.imap_attachments.childname}
| imap.attachments.folder.rootPath                                           /${spaces.company_home.childname}
| imap.attachments.folder.store                                              ${spaces.store}
| imap.attachments.mode                                                      SEPARATE
| imap.config.home.folderPath                                                ${spaces.imap_home.childname}
| imap.config.home.rootPath                                                  /${spaces.company_home.childname}
| imap.config.home.store                                                     ${spaces.store}
| imap.config.server.mountPoints                                             AlfrescoIMAP
| imap.config.server.mountPoints.default.modeName                            ARCHIVE
| imap.config.server.mountPoints.default.mountPointName                      IMAP
| imap.config.server.mountPoints.default.rootPath                            ${protocols.rootPath}
| imap.config.server.mountPoints.default.store                               ${spaces.store}
| imap.config.server.mountPoints.value.AlfrescoIMAP.modeName                 MIXED
| imap.config.server.mountPoints.value.AlfrescoIMAP.mountPointName           Alfresco IMAP
| imap.server.attachments.extraction.enabled                                 true
| imap.server.enabled                                                        false
| imap.server.port                                                           143
| img.dyn                                                                    ${img.root}/lib
| img.exe                                                                    ${img.root}/bin/convert
| img.root                                                                   ./ImageMagick
| img.startupRetryPeriodSeconds                                              60
| img.url                                                                    http://transform-core-aio:8090/
| index.backup.cronExpression                                                0 0 3 * * ?
| index.subsystem.name                                                       solr6
| index.tracking.minRecordPurgeAgeDays                                       30
| index.tracking.purgeSize                                                   7200000
| legacy.transform.service.enabled                                           true
| links.protocosl.white.list                                                 http,https,ftp,mailto
| local.transform.pipeline.config.dir                                        shared/classes/alfresco/extension/transform/pipelines
| local.transform.service.cronExpression                                     4 30 0/1 * * ?
| local.transform.service.enabled                                            true
| local.transform.service.initialAndOnError.cronExpression                   0/10 * * * * ?
| localTransform.core-aio.startupRetryPeriodSeconds                          60
| localTransform.core-aio.url                                                http://transform-core-aio:8090/
| location.license.embedded                                                  /WEB-INF/alfresco/license/*.lic
| location.license.external                                                  file://${dir.license.external}/*.lic
| location.license.shared                                                    classpath*:/alfresco/extension/license/*.lic
| lucene.commit.lock.timeout                                                 100000
| lucene.defaultAnalyserResourceBundleName                                   alfresco/model/dataTypeAnalyzers
| lucene.indexer.batchSize                                                   1000000
| lucene.indexer.cacheEnabled                                                true
| lucene.indexer.contentIndexingEnabled                                      true
| lucene.indexer.defaultMLIndexAnalysisMode                                  EXACT_LANGUAGE_AND_ALL
| lucene.indexer.defaultMLSearchAnalysisMode                                 EXACT_LANGUAGE_AND_ALL
| lucene.indexer.fairLocking                                                 true
| lucene.indexer.maxDocIdCacheSize                                           100000
| lucene.indexer.maxDocsForInMemoryIndex                                     60000
| lucene.indexer.maxDocsForInMemoryMerge                                     60000
| lucene.indexer.maxDocumentCacheSize                                        100
| lucene.indexer.maxFieldLength                                              10000
| lucene.indexer.maxIsCategoryCacheSize                                      -1
| lucene.indexer.maxLinkAspectCacheSize                                      10000
| lucene.indexer.maxParentCacheSize                                          100000
| lucene.indexer.maxPathCacheSize                                            100000
| lucene.indexer.maxRamInMbForInMemoryIndex                                  16
| lucene.indexer.maxRamInMbForInMemoryMerge                                  16
| lucene.indexer.maxRawResultSetSizeForInMemorySort                          1000
| lucene.indexer.maxTypeCacheSize                                            10000
| lucene.indexer.mergerMaxBufferedDocs                                       -1
| lucene.indexer.mergerMaxMergeDocs                                          1000000
| lucene.indexer.mergerMergeFactor                                           5
| lucene.indexer.mergerRamBufferSizeMb                                       16
| lucene.indexer.mergerTargetIndexCount                                      8
| lucene.indexer.mergerTargetOverlayCount                                    5
| lucene.indexer.mergerTargetOverlaysBlockingFactor                          2
| lucene.indexer.postSortDateTime                                            true
| lucene.indexer.termIndexInterval                                           128
| lucene.indexer.useInMemorySort                                             true
| lucene.indexer.useNioMemoryMapping                                         true
| lucene.indexer.writerMaxBufferedDocs                                       -1
| lucene.indexer.writerMaxMergeDocs                                          1000000
| lucene.indexer.writerMergeFactor                                           5
| lucene.indexer.writerRamBufferSizeMb                                       16
| lucene.lock.poll.interval                                                  100
| lucene.maxAtomicTransformationTime                                         100
| lucene.query.maxClauses                                                    10000
| lucene.write.lock.timeout                                                  10000
| mail.service.corePoolSize                                                  8
| mail.service.maximumPoolSize                                               20
| mbean.server.locateExistingServerIfPossible                                true
| messaging.broker.connections.max                                           100
| messaging.broker.connections.maxActiveSessionsPerConnection                1000
| messaging.broker.password                                                  
| messaging.broker.ssl                                                       false
| messaging.broker.url                                                       failover:(nio://activemq:61616)?timeout=3000&jms.useCompression=true
| messaging.broker.username                                                  
| messaging.camel.context.id                                                 alfrescoCamelContext
| messaging.camel.route.devicesync.id                                        alfresco.events -> VirtualTopic:alfresco.repo.events
| messaging.subsystem.autoStart                                              true
| messaging.transacted                                                       true
| metrics.dbMetricsReporter.enabled                                          false
| metrics.dbMetricsReporter.query.enabled                                    false
| metrics.dbMetricsReporter.query.statements.enabled                         false
| metrics.enabled                                                            false
| metrics.jvmMetricsReporter.enabled                                         false
| metrics.restMetricsReporter.enabled                                        false
| metrics.restMetricsReporter.path.enabled                                   false
| metrics.tomcatMetricsReporter.enabled                                      false
| mimetype.config.cronExpression                                             0 30 0/1 * * ?
| mimetype.config.dir                                                        shared/classes/alfresco/extension/mimetypes
| mimetype.config.initialAndOnError.cronExpression                           0/10 * * * * ?
| models.enforceTenantInNamespace                                            false
| monitor.rmi.service.enabled                                                false
| monitor.rmi.service.port                                                   50508
| mybatis.useLocalCaches                                                     false
| nodes.bulkLoad.cachingThreshold                                            10
| notification.email.siteinvite                                              true
| opencmis.activities.enabled                                                true
| opencmis.bulkUpdateProperties.batchSize                                    20
| opencmis.bulkUpdateProperties.maxItemsSize                                 1000
| opencmis.bulkUpdateProperties.workerThreads                                2
| opencmis.connector.default.contentChangesDefaultMaxItems                   10000
| opencmis.connector.default.objectsDefaultDepth                             100
| opencmis.connector.default.objectsDefaultMaxItems                          10000
| opencmis.connector.default.openHttpSession                                 false
| opencmis.connector.default.rootPath                                        /${spaces.company_home.childname}
| opencmis.connector.default.store                                           ${spaces.store}
| opencmis.connector.default.typesDefaultDepth                               -1
| opencmis.connector.default.typesDefaultMaxItems                            500
| opencmis.context.override                                                  false
| opencmis.context.value                                                     
| opencmis.maxContentSizeMB                                                  4096
| opencmis.memoryThresholdKB                                                 4096
| opencmis.server.override                                                   false
| opencmis.server.value                                                      
| opencmis.servletpath.override                                              false
| opencmis.servletpath.value                                                 
| orphanReaper.lockRefreshTime                                               60000
| orphanReaper.lockTimeOut                                                   3600000
| people.search.honor.hint.useCQ                                             true
| policy.content.update.ignoreEmpty                                          true
| protocols.rootPath                                                         /${spaces.company_home.childname}
| protocols.storeName                                                        ${spaces.store}
| rendition.config.cronExpression                                            2 30 0/1 * * ?
| rendition.config.dir                                                       shared/classes/alfresco/extension/transform/renditions
| rendition.config.initialAndOnError.cronExpression                          0/10 * * * * ?
| renditionService2.enabled                                                  true
| replication.enabled                                                        false
| repo.event2.filter.nodeAspects                                             
| repo.event2.filter.nodeTypes                                               sys:*, fm:*, cm:thumbnail, cm:failedThumbnail, cm:rating, rma:rmsite include_subtypes
| repo.event2.filter.users                                                   System, null
| repo.event2.topic.endpoint                                                 amqp:topic:alfresco.repo.event2
| repo.remote.endpoint                                                       /service
| repository.name                                                            Main Repository
| sample.site.disabled                                                       false
| security.anyDenyDenies                                                     true
| security.postProcessDenies                                                 false
| server.maxusers                                                            -1
| server.setup.transaction.max-retries                                       40
| server.setup.transaction.max-retry-wait-ms                                 15000
| server.setup.transaction.min-retry-wait-ms                                 15000
| server.setup.transaction.wait-increment-ms                                 10
| server.transaction.allow-writes                                            true
| server.transaction.max-retries                                             40
| server.transaction.max-retry-wait-ms                                       2000
| server.transaction.min-retry-wait-ms                                       100
| server.transaction.mode.default                                            PROPAGATION_REQUIRED
| server.transaction.mode.readOnly                                           PROPAGATION_REQUIRED, readOnly
| server.transaction.wait-increment-ms                                       100
| server.web.transaction.max-duration-ms                                     0
| sfs.endpoint                                                               ${sfs.url}/alfresco/api/-default-/private/sfs/versions/1
| sfs.url                                                                    http://shared-file-store:8099/
| shutdown.backstop.enabled                                                  false
| shutdown.backstop.timeout                                                  10000
| site.invite.moderated.workflowId                                           activiti$activitiInvitationModerated
| site.invite.nominated.workflowId                                           activiti$activitiInvitationNominatedAddDirect
| site.invite.nominatedExternal.workflowId                                   activiti$activitiInvitationNominated
| smart.download.associations.folder                                         ${spaces.dictionary.childname}/${spaces.smartdownloads.childname}
| smart.folders.config.custom.aspect                                         smf:customConfigSmartFolder
| smart.folders.config.custom.aspect.template.association                    smf:custom-template-association
| smart.folders.config.system.aspect                                         smf:systemConfigSmartFolder
| smart.folders.config.system.aspect.template.location.property              smf:system-template-location
| smart.folders.config.system.templates.classpath                            /org/alfresco/repo/virtual/node
| smart.folders.config.system.templates.path                                 ${spaces.dictionary.childname}/${spaces.smartfolders.childname}
| smart.folders.config.system.templates.template.type                        smf:smartFolderTemplate
| smart.folders.config.type.templates.path                                   ${spaces.dictionary.childname}/${spaces.smartfolders.childname}
| smart.folders.config.type.templates.qname.filter                           none
| smart.folders.config.vanilla.processor.classpath                           /org/alfresco/repo/virtual/node/vanilla.js
| smart.folders.enabled                                                      false
| smart.reference.classpath.hash                                             ${smart.folders.config.vanilla.processor.classpath}->1,${smart.folders.config.system.templates.classpath}->2
| solr.cmis.alternativeDictionary                                            DEFAULT_DICTIONARY
| solr.host                                                                  solr6
| solr.max.host.connections                                                  40
| solr.max.total.connections                                                 40
| solr.port                                                                  8983
| solr.port.ssl                                                              8984
| solr.secureComms                                                           none
| solr.solrConnectTimeout                                                    5000
| solr.solrPassword                                                          ********
| solr.solrPingCronExpression                                                0 0/5 * * * ? *
| solr.solrUser                                                              solr
| solr.store.mappings                                                        solrMappingAlfresco,solrMappingArchive
| solr.store.mappings.value.solrMappingAlfresco.baseUrl                      /solr/alfresco
| solr.store.mappings.value.solrMappingAlfresco.httpClientFactory            solrHttpClientFactory
| solr.store.mappings.value.solrMappingAlfresco.identifier                   SpacesStore
| solr.store.mappings.value.solrMappingAlfresco.protocol                     workspace
| solr.store.mappings.value.solrMappingArchive.baseUrl                       /solr/archive
| solr.store.mappings.value.solrMappingArchive.httpClientFactory             solrHttpClientFactory
| solr.store.mappings.value.solrMappingArchive.identifier                    SpacesStore
| solr.store.mappings.value.solrMappingArchive.protocol                      archive
| solr4.store.mappings                                                       solrMappingAlfresco,solrMappingArchive
| solr4.store.mappings.value.solrMappingAlfresco.baseUrl                     /solr4/alfresco
| solr4.store.mappings.value.solrMappingAlfresco.httpClientFactory           solrHttpClientFactory
| solr4.store.mappings.value.solrMappingAlfresco.identifier                  SpacesStore
| solr4.store.mappings.value.solrMappingAlfresco.protocol                    workspace
| solr4.store.mappings.value.solrMappingArchive.baseUrl                      /solr4/archive
| solr4.store.mappings.value.solrMappingArchive.httpClientFactory            solrHttpClientFactory
| solr4.store.mappings.value.solrMappingArchive.identifier                   SpacesStore
| solr4.store.mappings.value.solrMappingArchive.protocol                     archive
| solr6.store.mappings                                                       solrMappingAlfresco,solrMappingArchive,solrMappingHistory
| solr6.store.mappings.value.solrMappingAlfresco.baseUrl                     /solr/alfresco
| solr6.store.mappings.value.solrMappingAlfresco.httpClientFactory           solrHttpClientFactory
| solr6.store.mappings.value.solrMappingAlfresco.identifier                  SpacesStore
| solr6.store.mappings.value.solrMappingAlfresco.protocol                    workspace
| solr6.store.mappings.value.solrMappingArchive.baseUrl                      /solr/archive
| solr6.store.mappings.value.solrMappingArchive.httpClientFactory            solrHttpClientFactory
| solr6.store.mappings.value.solrMappingArchive.identifier                   SpacesStore
| solr6.store.mappings.value.solrMappingArchive.protocol                     archive
| solr6.store.mappings.value.solrMappingHistory.baseUrl                      /solr/history
| solr6.store.mappings.value.solrMappingHistory.httpClientFactory            solrHttpClientFactory
| solr6.store.mappings.value.solrMappingHistory.identifier                   history
| solr6.store.mappings.value.solrMappingHistory.protocol                     workspace
| solr_facets.inheritanceHierarchy                                           default,custom
| solr_facets.root                                                           ${solr_facets.root.path}/${spaces.solr_facets.root.childname}
| solr_facets.root.path                                                      /app:company_home/app:dictionary
| spaces.archive.store                                                       archive://SpacesStore
| spaces.company_home.childname                                              app:company_home
| spaces.content_forms.childname                                             app:forms
| spaces.dictionary.childname                                                app:dictionary
| spaces.emailActions.childname                                              app:email_actions
| spaces.extension_webscripts.childname                                      cm:extensionwebscripts
| spaces.guest_home.childname                                                app:guest_home
| spaces.imapConfig.childname                                                app:imap_configs
| spaces.imap_attachments.childname                                          cm:Imap Attachments
| spaces.imap_home.childname                                                 cm:Imap Home
| spaces.imap_templates.childname                                            app:imap_templates
| spaces.inbound_transfer_records.childname                                  app:inbound_transfer_records
| spaces.models.childname                                                    app:models
| spaces.nodetemplates.childname                                             app:node_templates
| spaces.quickshare.link_expiry_actions.childname                            app:quick_share_link_expiry_actions
| spaces.rendition.rendering_actions.childname                               app:rendering_actions
| spaces.replication.replication_actions.childname                           app:replication_actions
| spaces.savedsearches.childname                                             app:saved_searches
| spaces.scheduled_actions.childname                                         cm:Scheduled Actions
| spaces.scripts.childname                                                   app:scripts
| spaces.searchAction.childname                                              cm:search
| spaces.shared.childname                                                    app:shared
| spaces.sites.childname                                                     st:sites
| spaces.smartdownloads.childname                                            app:smart_downloads
| spaces.smartfolders.childname                                              app:smart_folders
| spaces.solr_facets.root.childname                                          srft:facets
| spaces.store                                                               workspace://SpacesStore
| spaces.system.childname                                                    sys:system
| spaces.templates.childname                                                 app:space_templates
| spaces.templates.content.childname                                         app:content_templates
| spaces.templates.email.activities.childname                                cm:activities
| spaces.templates.email.childname                                           app:email_templates
| spaces.templates.email.following.childname                                 app:following
| spaces.templates.email.invite.childname                                    cm:invite
| spaces.templates.email.invite1.childname                                   app:invite_email_templates
| spaces.templates.email.notify.childname                                    app:notify_email_templates
| spaces.templates.email.workflowemailnotification.childname                 cm:workflownotification
| spaces.templates.rss.childname                                             app:rss_templates
| spaces.transfer_groups.childname                                           app:transfer_groups
| spaces.transfer_summary_report.location                                    /${spaces.company_home.childname}/${spaces.dictionary.childname}/${spaces.transfers.childname}/${spaces.inbound_transfer_records.childname}
| spaces.transfer_temp.childname                                             app:temp
| spaces.transfers.childname                                                 app:transfers
| spaces.user_homes.childname                                                app:user_homes
| spaces.user_homes.regex.group_order                                        
| spaces.user_homes.regex.key                                                userName
| spaces.user_homes.regex.pattern                                            
| spaces.webscripts.childname                                                cm:webscripts
| spaces.workflow.definitions.childname                                      app:workflow_defs
| subsystems.test.beanProp                                                   inst1,inst2,inst3
| subsystems.test.beanProp.default.anotherStringProperty                     Global Default
| subsystems.test.beanProp.default.longProperty                              123456789123456789
| subsystems.test.beanProp.value.inst2.boolProperty                          true
| subsystems.test.beanProp.value.inst3.anotherStringProperty                 Global Instance Default
| subsystems.test.simpleProp2                                                true
| subsystems.test.simpleProp3                                                Global Default3
| system.acl.maxPermissionCheckTimeMillis                                    10000
| system.acl.maxPermissionChecks                                             1000
| system.api.discovery.enabled                                               true
| system.auditableData.ACLs                                                  ${system.auditableData.preserve}
| system.auditableData.FileFolderService                                     ${system.auditableData.preserve}
| system.auditableData.preserve                                              ${system.preserve.modificationData}
| system.authorities_container.childname                                     sys:authorities
| system.bootstrap.config_check.strict                                       true
| system.cache.disableImmutableSharedCaches                                  false
| system.cache.disableMutableSharedCaches                                    false
| system.cache.parentAssocs.limitFactor                                      8
| system.cache.parentAssocs.maxSize                                          130000
| system.certificate_container.childname                                     sys:samlcertificate
| system.content.caching.cacheOnInbound                                      true
| system.content.caching.cleanThresholdPct                                   80
| system.content.caching.contentCleanup.cronExpression                       0 0 3 * * ?
| system.content.caching.maxDeleteWatchCount                                 1
| system.content.caching.maxFileSizeMB                                       0
| system.content.caching.maxUsageMB                                          4096
| system.content.caching.minFileAgeMillis                                    60000
| system.content.caching.normalCleanThresholdSec                             0
| system.content.caching.panicThresholdPct                                   90
| system.content.caching.targetUsagePct                                      70
| system.content.deletionFailureAction                                       IGNORE
| system.content.eagerOrphanCleanup                                          false
| system.content.maximumFileSizeLimit                                        
| system.content.orphanCleanup.cronExpression                                0 0 4 * * ?
| system.content.orphanProtectDays                                           14
| system.cronJob.startDelayMilliseconds                                      60000
| system.delete_not_exists.batchsize                                         100000
| system.delete_not_exists.delete_batchsize                                  1000
| system.delete_not_exists.read_only                                         false
| system.delete_not_exists.timeout_seconds                                   -1
| system.descriptor.childname                                                sys:descriptor
| system.descriptor.current.childname                                        sys:descriptor-current
| system.downloads_container.childname                                       sys:downloads
| system.email.sender.default                                                noreply@alfresco.com
| system.enableTimestampPropagation                                          true
| system.filefolderservice.defaultListMaxResults                             5000
| system.fixedACLs.maxTransactionTime                                        10000
| system.fixedACLsUpdater.cronExpression                                     0 0 0 * * ?
| system.fixedACLsUpdater.lockTTL                                            10000
| system.fixedACLsUpdater.maxItemBatchSize                                   100
| system.fixedACLsUpdater.numThreads                                         4
| system.hibernateMaxExecutions                                              20000
| system.integrity.enabled                                                   true
| system.integrity.failOnViolation                                           true
| system.integrity.maxErrorsPerTransaction                                   5
| system.integrity.trace                                                     false
| system.lockTryTimeout                                                      100
| system.lockTryTimeout.DictionaryDAOImpl                                    10000
| system.lockTryTimeout.MessageServiceImpl                                   ${system.lockTryTimeout}
| system.lockTryTimeout.PolicyComponentImpl                                  ${system.lockTryTimeout}
| system.maximumStringLength                                                 -1
| system.maximumStringLength.jobCronExpression                               * * * * * ? 2099
| system.maximumStringLength.jobQueryRange                                   10000
| system.maximumStringLength.jobThreadCount                                  4
| system.metadata-query-indexes-more.ignored                                 true
| system.metadata-query-indexes.ignored                                      true
| system.patch.addUnmovableAspect.cronExpression                             0 0 0 ? 1 1 2030
| system.patch.addUnmovableAspect.deferred                                   false
| system.patch.sharedFolder.cronExpression                                   0 0 0 ? 1 1 2030
| system.patch.sharedFolder.deferred                                         false
| system.patch.surfConfigFolder.cronExpression                               * * * * * ? 2099
| system.patch.surfConfigFolder.deferred                                     false
| system.people_container.childname                                          sys:people
| system.preferred.password.encoding                                         md4
| system.preserve.modificationData                                           false
| system.prop_table_cleaner.algorithm                                        V2
| system.propval.uniquenessCheck.enabled                                     true
| system.quickshare.email.from.default                                       noreply@alfresco.com
| system.quickshare.enabled                                                  true
| system.quickshare.expiry_date.enforce.minimum.period                       DAYS
| system.readpermissions.bulkfetchsize                                       1000
| system.readpermissions.optimise                                            true
| system.remote_credentials_container.childname                              sys:remote_credentials
| system.remove-jbpm-tables-from-db.ignored                                  true
| system.reset-password.endTimer                                             PT1H
| system.reset-password.sendEmailAsynchronously                              true
| system.serverMode                                                          UNKNOWN
| system.store                                                               system://system
| system.syncset_definition_container.childname                              sys:syncset_definitions
| system.system_container.childname                                          sys:system
| system.thumbnail.definition.default.maxPages                               -1
| system.thumbnail.definition.default.maxSourceSizeKBytes                    -1
| system.thumbnail.definition.default.pageLimit                              1
| system.thumbnail.definition.default.readLimitKBytes                        -1
| system.thumbnail.definition.default.readLimitTimeMs                        -1
| system.thumbnail.definition.default.timeoutMs                              -1
| system.thumbnail.generate                                                  true
| system.thumbnail.mimetype.maxSourceSizeKBytes.docx                         -1
| system.thumbnail.mimetype.maxSourceSizeKBytes.odp                          -1
| system.thumbnail.mimetype.maxSourceSizeKBytes.ods                          -1
| system.thumbnail.mimetype.maxSourceSizeKBytes.odt                          -1
| system.thumbnail.mimetype.maxSourceSizeKBytes.pdf                          -1
| system.thumbnail.mimetype.maxSourceSizeKBytes.pptx                         -1
| system.thumbnail.mimetype.maxSourceSizeKBytes.txt                          -1
| system.thumbnail.mimetype.maxSourceSizeKBytes.xlsx                         -1
| system.thumbnail.quietPeriod                                               604800
| system.thumbnail.quietPeriodRetriesEnabled                                 true
| system.thumbnail.redeployStaticDefsOnStartup                               true
| system.thumbnail.retryCount                                                2
| system.thumbnail.retryPeriod                                               60
| system.upgradePasswordHash.jobBatchSize                                    100
| system.upgradePasswordHash.jobCronExpression                               * * * * * ? 2099
| system.upgradePasswordHash.jobQueryRange                                   10000
| system.upgradePasswordHash.jobThreadCount                                  4
| system.usages.clearBatchSize                                               0
| system.usages.enabled                                                      false
| system.usages.updateBatchSize                                              50
| system.webdav.activities.enabled                                           false
| system.webdav.renameShufflePattern                                         (.*/\..*)|(.*[a-f0-9]{8}+$)|(.*\.tmp$)|(.*atmp[0-9]+$)|(.*\.wbk$)|(.*\.bak$)|(.*\~$)|(.*backup.*\.do[ct]{1}[x]?[m]?$)|(.*\.sb\-\w{8}\-\w{6}$)
| system.webdav.rootPath                                                     ${protocols.rootPath}
| system.webdav.servlet.enabled                                              true
| system.webdav.storeName                                                    ${protocols.storeName}
| system.webdav.url.path.prefix                                              
| system.workflow.comment.property.max.length                                4000
| system.workflow.deployWorkflowsInTenant                                    true
| system.workflow.engine.activiti.definitions.visible                        true
| system.workflow.engine.activiti.enabled                                    true
| system.workflow.engine.activiti.idblocksize                                100
| system.workflow.engine.activiti.retentionHistoricProcessInstance           false
| system.workflow.engine.activiti.taskvariableslimit                         20000
| system.workflow.jbpm.comment.property.max.length                           -1
| system.workflow.maxAuthoritiesForPooledTasks                               500
| system.workflow.maxGroupReviewers                                          0
| system.workflow.maxPooledTasks                                             -1
| system.workflow_container.childname                                        sys:workflow
| system.zones_container.childname                                           sys:zones
| ticket.cleanup.cronExpression                                              0 0 * * * ?
| tika.startupRetryPeriodSeconds                                             60
| tika.url                                                                   http://transform-core-aio:8090/
| transferservice.receiver.enabled                                           false
| transferservice.receiver.lockRefreshTime                                   60000
| transferservice.receiver.lockRetryCount                                    3
| transferservice.receiver.lockRetryWait                                     100
| transferservice.receiver.lockTimeOut                                       300000
| transferservice.receiver.stagingDir                                        ${java.io.tmpdir}/alfresco-transfer-staging
| transform.misc.startupRetryPeriodSeconds                                   60
| transform.misc.url                                                         http://transform-core-aio:8090/
| transform.service.cronExpression                                           6 30 0/1 * * ?
| transform.service.enabled                                                  true
| transform.service.initialAndOnError.cronExpression                         0/10 * * * * ?
| transform.service.reply.endpoint                                           
| transform.service.reply.endpoint.prefix                                    org.alfresco.transform
| transform.service.reply.endpoint.suffix                                    t-reply
| transform.service.request.endpoint                                         jms:org.alfresco.transform.t-request.acs?jmsMessageType=Text
| transform.service.url                                                      http://transform-router:8095
| transformer.Archive.includeContents                                        false
| transformer.strict.mimetype.check                                          true
| transformer.strict.mimetype.check.whitelist.mimetypes                      application/eps;application/postscript;application/illustrator;application/pdf;application/x-tar;application/x-gtar;application/acp;application/zip;application/vnd.stardivision.math;application/x-tika-msoffice
| trashcan-cleaner.cron                                                      * * * * * ? 2099
| trashcan-cleaner.deleteBatchCount                                          1000
| trashcan-cleaner.keepPeriod                                                P28D
| trashcan.MaxSize                                                           1000
| trialUid                                                                   
| trialUidPattern                                                            id\d+
| urlshortening.bitly.api.key                                                R_ca15c6c89e9b25ccd170bafd209a0d4f
| urlshortening.bitly.url.length                                             20
| urlshortening.bitly.username                                               brianalfresco
| user.name.caseSensitive                                                    false
| version.schema                                                             14001
| version.store.deprecated.lightWeightVersionStore                           workspace://lightWeightVersionStore
| version.store.enableAutoVersionOnUpdateProps                               false
| version.store.enableAutoVersioning                                         true
| version.store.initialVersion                                               true
| version.store.version2Store                                                workspace://version2Store
| version.store.versionComparatorClass                                       
| webscripts.encryptTempFiles                                                false
| webscripts.memoryThreshold                                                 4194304
| webscripts.setMaxContentSize                                               5368709120
| webscripts.tempDirectoryName                                               Alfresco-WebScripts
| webscripts.transaction.preserveHeadersPattern                              Access-Control-.*
| xforms.formatCaption                                                       true