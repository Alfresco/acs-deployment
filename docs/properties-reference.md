# Alfresco Content Services Property Reference

The table below shows the full list of properties (exluding module specific properties) that can be figured via alfresco-global.properties ordered alphabetically.

| Property | Description | Default value |
|----------|-------------|---------------|
| acs.repo.rendition.events.endpoint | Raw events | jms:acs-repo-rendition-events?jmsMessageType=Text |
| acs.repo.transform.request.endpoint | Transform request events | jms:acs-repo-transform-request?jmsMessageType=Text |
| activities.feed.fetchBatchSize | | 250 |
| activities.feed.generator.jsonFormatOnly | | true |
| activities.feed.max.ageMins | Feed max age in minutes | 44640 (31 days) |
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
| alfresco.cluster.hostname |  | ${localname} |
| alfresco.cluster.interface | | |
| alfresco.cluster.max.init.retries | | 50 |
| alfresco.cluster.memberchange.dropInvalidatingCaches | | true |
| alfresco.cluster.nodetype | | Repository server |
| alfresco.cluster.specify.interface | | false |
| alfresco.clusterCheck.timeout | | 4000 |
| alfresco.context | Alfresco context | alfresco |
| alfresco.ephemeralLock.expiryThresh | Requests for ephemeral (in-memory) locks with expiry times (in seconds) greater than this value will result in persistent locks being created instead. By default this value is equal to the maximum allowed expiry for ephemeral locks, therefore this feature is disabled by default. Setting this to -1 would mean that ALL requests for ephemeral locks would result in persistent locks being created. | 172800 |
| alfresco.events.include | | CONTENTPUT, NODEMOVED, NODEADDED, NODEREMOVED, NODERENAMED, NODECHECKOUTCANCELLED, NODECHECKEDOUT, NODECHECKEDIN, AUTHADDEDTOGROUP, AUTHREMOVEDFROMGROUP, GROUPDELETED, INHERITPERMISSIONSDISABLED, INHERITPERMISSIONSENABLED, LOCALPERMISSIONGRANTED, LOCALPERMISSIONREVOKED, RECORDCREATED, RECORDREJECTED, FILECLASSIFIED, FILEUNCLASSIFIED, NODELOCKED, NODEUNLOCKED |
| alfresco.hazelcast.autoinc.port | | false |
| alfresco.hazelcast.bind.any | | false |
| alfresco.hazelcast.configLocation | | `classpath:alfresco/hazelcast/hazelcast-tcp.xml` |
| alfresco.hazelcast.mancenter.enabled | | false |
| alfresco.hazelcast.mancenter.url | | `http://localhost:8080/mancenter` |
| alfresco.hazelcast.max.no.heartbeat.seconds | | 15 |
| alfresco.hazelcast.port | | 5701 |
| alfresco.host | Alfresco hostname | ${localname} |
| alfresco.jmx.connector.enabled | Control Alfresco JMX connectivity | false |
| alfresco.port | Alfresco port | 8080 |
| alfresco.protocol | Alfresco protocol | http |
| alfresco.restApi.basicAuthScheme | | false |
| alfresco.rmi.services.external.host | | localhost |
| alfresco.rmi.services.host | | 0.0.0.0 |
| alfresco.rmi.services.port | Default value of alfresco.rmi.services.host is 0.0.0.0 which means 'listen on all adapters'. This allows connections to JMX both remotely and locally. | 50500 |
| alfresco.rmi.services.retries | If the RMI address is in-use, how many retries should be done before aborting. Default value of alfresco.rmi.services.retries is 0 which means 'Don't retry if the address is in-use'. | 4 |
| alfresco.rmi.services.retryInterval | How long in milliseconds to wait after a failed server socket bind, before retrying | 250 |
| alfresco_user_store.adminpassword | Initial MD4 hashed password - editing this will not have any effect once the repository is installed | 209c6174da490caeb422f3fa5a7ae634 |
| alfresco_user_store.adminusername | Note: default admin username - should not be changed after installation | admin |
| alfresco_user_store.guestusername | Note: default guest username - should not be changed after installation | guest |
| alfresco_user_store.store | User config | `user://alfrescoUserStore` |
| alfresco_user_store.system_container.childname | User config | sys:system |
| alfresco_user_store.user_container.childname | User config | sys:people |
| api-explorer.url | Alfresco Rest Api-Explorer |
| attributes.propcleaner.cronExpression | Scheduled job to clean up unused properties from the alf_prop_xxx tables. | `0 0 3 ? * SAT` (every Saturday at 3am) |
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
| authority.findAuthorityLimit | Limit the number of results from findAuthority query | 10000 |
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
| cache.node.aspectsSharedCache.maxIdleSeconds | | 0 |
| cache.node.aspectsSharedCache.maxItems | | 130000 |
| cache.node.aspectsSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.node.aspectsSharedCache.readBackupData | | false |
| cache.node.aspectsSharedCache.timeToLiveSeconds | | 0 |
| cache.node.aspectsSharedCache.tx.maxItems | | 65000 |
| cache.node.aspectsSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.node.childByNameSharedCache.backup-count | | 1 |
| cache.node.childByNameSharedCache.cluster.type | | local |
| cache.node.childByNameSharedCache.eviction-policy | | LRU |
| cache.node.childByNameSharedCache.maxIdleSeconds | | 0 |
| cache.node.childByNameSharedCache.maxItems | | 130000 |
| cache.node.childByNameSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.node.childByNameSharedCache.readBackupData | | false |
| cache.node.childByNameSharedCache.timeToLiveSeconds | | 0 |
| cache.node.childByNameSharedCache.tx.maxItems | | 65000 |
| cache.node.childByNameSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.node.nodesSharedCache.backup-count | | 1 |
| cache.node.nodesSharedCache.cluster.type | | invalidating |
| cache.node.nodesSharedCache.eviction-policy | | LRU |
| cache.node.nodesSharedCache.maxIdleSeconds | | 0 |
| cache.node.nodesSharedCache.maxItems | | 250000 |
| cache.node.nodesSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.node.nodesSharedCache.readBackupData | | false |
| cache.node.nodesSharedCache.timeToLiveSeconds | | 300 |
| cache.node.nodesSharedCache.tx.maxItems | | 125000 |
| cache.node.nodesSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.node.parentAssocsSharedCache.backup-count | | 1 |
| cache.node.parentAssocsSharedCache.cluster.type | | fully-distributed |
| cache.node.parentAssocsSharedCache.eviction-policy | | LRU |
| cache.node.parentAssocsSharedCache.maxIdleSeconds | | 0 |
| cache.node.parentAssocsSharedCache.maxItems | | 130000 |
| cache.node.parentAssocsSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.node.parentAssocsSharedCache.readBackupData | | false |
| cache.node.parentAssocsSharedCache.timeToLiveSeconds | | 0 |
| cache.node.propertiesSharedCache.backup-count | | 1 |
| cache.node.propertiesSharedCache.cluster.type | | local |
| cache.node.propertiesSharedCache.eviction-policy | | LRU |
| cache.node.propertiesSharedCache.maxIdleSeconds | | 0 |
| cache.node.propertiesSharedCache.maxItems | | 130000 |
| cache.node.propertiesSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.node.propertiesSharedCache.readBackupData | | false |
| cache.node.propertiesSharedCache.timeToLiveSeconds | | 0 |
| cache.node.propertiesSharedCache.tx.maxItems | | 65000 |
| cache.node.propertiesSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.node.rootNodesSharedCache.backup-count | | 1 |
| cache.node.rootNodesSharedCache.cluster.type | | invalidating |
| cache.node.rootNodesSharedCache.eviction-policy | | LRU |
| cache.node.rootNodesSharedCache.maxIdleSeconds | | 0 |
| cache.node.rootNodesSharedCache.maxItems | | 1000 |
| cache.node.rootNodesSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.node.rootNodesSharedCache.readBackupData | | false |
| cache.node.rootNodesSharedCache.timeToLiveSeconds | | 0 |
| cache.node.rootNodesSharedCache.tx.maxItems | | 1000 |
| cache.node.rootNodesSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.nodeOwnerSharedCache.backup-count | | 1 |
| cache.nodeOwnerSharedCache.cluster.type | | fully-distributed |
| cache.nodeOwnerSharedCache.eviction-policy | | LRU |
| cache.nodeOwnerSharedCache.maxIdleSeconds | | 0 |
| cache.nodeOwnerSharedCache.maxItems | | 40000 |
| cache.nodeOwnerSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.nodeOwnerSharedCache.readBackupData | | false |
| cache.nodeOwnerSharedCache.timeToLiveSeconds | | 0 |
| cache.nodeOwnerSharedCache.tx.maxItems | | 40000 |
| cache.nodeOwnerSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.nodeRulesSharedCache.tx.maxItems | | 2000 |
| cache.nodeRulesSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.openCMISRegistrySharedCache.backup-count | | 1 |
| cache.openCMISRegistrySharedCache.cluster.type | | invalidating |
| cache.openCMISRegistrySharedCache.eviction-policy | | LRU |
| cache.openCMISRegistrySharedCache.maxIdleSeconds | | 0 |
| cache.openCMISRegistrySharedCache.maxItems | | 500 |
| cache.openCMISRegistrySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.openCMISRegistrySharedCache.readBackupData | | false |
| cache.openCMISRegistrySharedCache.timeToLiveSeconds | | 1800 |
| cache.openCMISRegistrySharedCache.tx.maxItems | | 5 |
| cache.openCMISRegistrySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.permissionEntitySharedCache.tx.maxItems | | 50000 |
| cache.permissionEntitySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.permissionsAccessSharedCache.backup-count | | 1 |
| cache.permissionsAccessSharedCache.cluster.type | | fully-distributed |
| cache.permissionsAccessSharedCache.eviction-policy | | LRU |
| cache.permissionsAccessSharedCache.maxIdleSeconds | | 0 |
| cache.permissionsAccessSharedCache.maxItems | | 50000 |
| cache.permissionsAccessSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.permissionsAccessSharedCache.readBackupData | | false |
| cache.permissionsAccessSharedCache.timeToLiveSeconds | | 0 |
| cache.permissionsAccessSharedCache.tx.maxItems | | 10000 |
| cache.permissionsAccessSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.personSharedCache.backup-count | | 1 |
| cache.personSharedCache.cluster.type | | fully-distributed |
| cache.personSharedCache.eviction-policy | | LRU |
| cache.personSharedCache.maxIdleSeconds | | 0 |
| cache.personSharedCache.maxItems | | 1000 |
| cache.personSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.personSharedCache.readBackupData | | false |
| cache.personSharedCache.timeToLiveSeconds | | 0 |
| cache.personSharedCache.tx.maxItems | | 1000 |
| cache.personSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.propertyClassCache.backup-count | | 1 |
| cache.propertyClassCache.cluster.type | | invalidating |
| cache.propertyClassCache.eviction-policy | | LRU |
| cache.propertyClassCache.maxIdleSeconds | | 0 |
| cache.propertyClassCache.maxItems | | 10000 |
| cache.propertyClassCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.propertyClassCache.readBackupData | | false |
| cache.propertyClassCache.timeToLiveSeconds | | 0 |
| cache.propertyClassCache.tx.maxItems | | 1000 |
| cache.propertyClassCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.propertyUniqueContextSharedCache.backup-count | | 1 |
| cache.propertyUniqueContextSharedCache.cluster.type | | invalidating |
| cache.propertyUniqueContextSharedCache.eviction-policy | | LRU |
| cache.propertyUniqueContextSharedCache.maxIdleSeconds | | 0 |
| cache.propertyUniqueContextSharedCache.maxItems | | 10000 |
| cache.propertyUniqueContextSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.propertyUniqueContextSharedCache.readBackupData | | false |
| cache.propertyUniqueContextSharedCache.timeToLiveSeconds | | 0 |
| cache.propertyUniqueContextSharedCache.tx.maxItems | | 10000 |
| cache.propertyUniqueContextSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.propertyValueCache.backup-count | | 1 |
| cache.propertyValueCache.cluster.type | | invalidating |
| cache.propertyValueCache.eviction-policy | | LRU |
| cache.propertyValueCache.maxIdleSeconds | | 0 |
| cache.propertyValueCache.maxItems | | 10000 |
| cache.propertyValueCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.propertyValueCache.readBackupData | | false |
| cache.propertyValueCache.timeToLiveSeconds | | 300 |
| cache.propertyValueCache.tx.maxItems | | 1000 |
| cache.propertyValueCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.protectedUsersCache.backup-count | | 1 |
| cache.protectedUsersCache.cluster.type | | local |
| cache.protectedUsersCache.eviction-policy | | LRU |
| cache.protectedUsersCache.maxIdleSeconds | | 0 |
| cache.protectedUsersCache.maxItems | | 1000 |
| cache.protectedUsersCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.protectedUsersCache.readBackupData | | false |
| cache.protectedUsersCache.timeToLiveSeconds | | 0 |
| cache.publicapi.webScriptsRegistryCache.backup-count | | 1 |
| cache.publicapi.webScriptsRegistryCache.cluster.type | | invalidating |
| cache.publicapi.webScriptsRegistryCache.eviction-policy | | LRU |
| cache.publicapi.webScriptsRegistryCache.maxIdleSeconds | | 0 |
| cache.publicapi.webScriptsRegistryCache.maxItems | | 1000 |
| cache.publicapi.webScriptsRegistryCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.publicapi.webScriptsRegistryCache.readBackupData | | false |
| cache.publicapi.webScriptsRegistryCache.timeToLiveSeconds | | 0 |
| cache.readersDeniedSharedCache.backup-count | | 1 |
| cache.readersDeniedSharedCache.cluster.type | | fully-distributed |
| cache.readersDeniedSharedCache.eviction-policy | | LRU |
| cache.readersDeniedSharedCache.maxIdleSeconds | | 0 |
| cache.readersDeniedSharedCache.maxItems | | 10000 |
| cache.readersDeniedSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.readersDeniedSharedCache.readBackupData | | false |
| cache.readersDeniedSharedCache.timeToLiveSeconds | | 0 |
| cache.readersDeniedSharedCache.tx.maxItems | | 10000 |
| cache.readersDeniedSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.readersSharedCache.backup-count | | 1 |
| cache.readersSharedCache.cluster.type | | fully-distributed |
| cache.readersSharedCache.eviction-policy | | LRU |
| cache.readersSharedCache.maxIdleSeconds | | 0 |
| cache.readersSharedCache.maxItems | | 10000 |
| cache.readersSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.readersSharedCache.readBackupData | | false |
| cache.readersSharedCache.timeToLiveSeconds | | 0 |
| cache.readersSharedCache.tx.maxItems | | 10000 |
| cache.readersSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.remoteAlfrescoTicketService.ticketsCache.backup-count | | 1 |
| cache.remoteAlfrescoTicketService.ticketsCache.cluster.type | | fully-distributed |
| cache.remoteAlfrescoTicketService.ticketsCache.eviction-policy | | LRU |
| cache.remoteAlfrescoTicketService.ticketsCache.maxIdleSeconds | | 0 |
| cache.remoteAlfrescoTicketService.ticketsCache.maxItems | | 1000 |
| cache.remoteAlfrescoTicketService.ticketsCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.remoteAlfrescoTicketService.ticketsCache.readBackupData | | false |
| cache.remoteAlfrescoTicketService.ticketsCache.timeToLiveSeconds | | 0 |
| cache.resourceBundleBaseNamesSharedCache.backup-count | | 1 |
| cache.resourceBundleBaseNamesSharedCache.cluster.type | | invalidating |
| cache.resourceBundleBaseNamesSharedCache.eviction-policy | | LRU |
| cache.resourceBundleBaseNamesSharedCache.maxIdleSeconds | | 0 |
| cache.resourceBundleBaseNamesSharedCache.maxItems | | 1000 |
| cache.resourceBundleBaseNamesSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.resourceBundleBaseNamesSharedCache.readBackupData | | false |
| cache.resourceBundleBaseNamesSharedCache.timeToLiveSeconds | | 0 |
| cache.resourceBundleBaseNamesSharedCache.tx.maxItems | | 1000 |
| cache.resourceBundleBaseNamesSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.routingContentStoreSharedCache.backup-count | | 1 |
| cache.routingContentStoreSharedCache.cluster.type | | local |
| cache.routingContentStoreSharedCache.eviction-policy | | LRU |
| cache.routingContentStoreSharedCache.maxIdleSeconds | | 0 |
| cache.routingContentStoreSharedCache.maxItems | | 10000 |
| cache.routingContentStoreSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.routingContentStoreSharedCache.readBackupData | | false |
| cache.routingContentStoreSharedCache.timeToLiveSeconds | | 0 |
| cache.routingContentStoreSharedCache.tx.maxItems | | 10000 |
| cache.routingContentStoreSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.samlTrustEngineSharedCache.backup-count | | 1 |
| cache.samlTrustEngineSharedCache.cluster.type | | invalidating |
| cache.samlTrustEngineSharedCache.eviction-policy | | LRU |
| cache.samlTrustEngineSharedCache.maxIdleSeconds | | 0 |
| cache.samlTrustEngineSharedCache.maxItems | | 5000 |
| cache.samlTrustEngineSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.samlTrustEngineSharedCache.readBackupData | | false |
| cache.samlTrustEngineSharedCache.timeToLiveSeconds | | 0 |
| cache.samlTrustEngineSharedCache.tx.maxItems | | 5000 |
| cache.samlTrustEngineSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.shardStateSharedCache.backup-count | | 1 |
| cache.shardStateSharedCache.cluster.type | | invalidating |
| cache.shardStateSharedCache.eviction-policy | | LRU |
| cache.shardStateSharedCache.maxIdleSeconds | | 0 |
| cache.shardStateSharedCache.maxItems | | 500 |
| cache.shardStateSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.shardStateSharedCache.readBackupData | | false |
| cache.shardStateSharedCache.timeToLiveSeconds | | 1800 |
| cache.shardStateSharedCache.tx.maxItems | | 100 |
| cache.shardStateSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.shardToGuidSharedCache.backup-count | | 1 |
| cache.shardToGuidSharedCache.cluster.type | | invalidating |
| cache.shardToGuidSharedCache.eviction-policy | | LRU |
| cache.shardToGuidSharedCache.maxIdleSeconds | | 0 |
| cache.shardToGuidSharedCache.maxItems | | 500 |
| cache.shardToGuidSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.shardToGuidSharedCache.readBackupData | | false |
| cache.shardToGuidSharedCache.timeToLiveSeconds | | 0 |
| cache.shardToGuidSharedCache.tx.maxItems | | 100 |
| cache.shardToGuidSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.siteNodeRefSharedCache.backup-count | | 1 |
| cache.siteNodeRefSharedCache.cluster.type | | fully-distributed |
| cache.siteNodeRefSharedCache.eviction-policy | | LRU |
| cache.siteNodeRefSharedCache.maxIdleSeconds | | 0 |
| cache.siteNodeRefSharedCache.maxItems | | 5000 |
| cache.siteNodeRefSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.siteNodeRefSharedCache.readBackupData | | false |
| cache.siteNodeRefSharedCache.timeToLiveSeconds | | 0 |
| cache.siteNodeRefSharedCache.tx.maxItems | | 5000 |
| cache.siteNodeRefSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.solrFacetNodeRefSharedCache.backup-count | | 1 |
| cache.solrFacetNodeRefSharedCache.cluster.type | | fully-distributed |
| cache.solrFacetNodeRefSharedCache.eviction-policy | | LRU |
| cache.solrFacetNodeRefSharedCache.maxIdleSeconds | | 0 |
| cache.solrFacetNodeRefSharedCache.maxItems | | 5000 |
| cache.solrFacetNodeRefSharedCache.merge-policy | | com.hazelcast.map.merge.LatestUpdateMapMergePolicy |
| cache.solrFacetNodeRefSharedCache.readBackupData | | false |
| cache.solrFacetNodeRefSharedCache.timeToLiveSeconds | | 0 |
| cache.solrFacetNodeRefSharedCache.tx.maxItems | | 5000 |
| cache.solrFacetNodeRefSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.tagscopeSummarySharedCache.backup-count | | 1 |
| cache.tagscopeSummarySharedCache.cluster.type | | fully-distributed |
| cache.tagscopeSummarySharedCache.eviction-policy | | LRU |
| cache.tagscopeSummarySharedCache.maxIdleSeconds | | 0 |
| cache.tagscopeSummarySharedCache.maxItems | | 1000 |
| cache.tagscopeSummarySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.tagscopeSummarySharedCache.readBackupData | | false |
| cache.tagscopeSummarySharedCache.timeToLiveSeconds | | 0 |
| cache.tagscopeSummarySharedCache.tx.maxItems | | 1000 |
| cache.tagscopeSummarySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.tenantEntitySharedCache.backup-count | | 1 |
| cache.tenantEntitySharedCache.cluster.type | | fully-distributed |
| cache.tenantEntitySharedCache.eviction-policy | | LRU |
| cache.tenantEntitySharedCache.maxIdleSeconds | | 0 |
| cache.tenantEntitySharedCache.maxItems | | 1000 |
| cache.tenantEntitySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.tenantEntitySharedCache.readBackupData | | false |
| cache.tenantEntitySharedCache.timeToLiveSeconds | | 0 |
| cache.tenantEntitySharedCache.tx.maxItems | | 1000 |
| cache.tenantEntitySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.ticketsCache.backup-count | | 1 |
| cache.ticketsCache.cluster.type | | fully-distributed |
| cache.ticketsCache.eviction-policy | | LRU |
| cache.ticketsCache.maxIdleSeconds | | 0 |
| cache.ticketsCache.maxItems | | 1000 |
| cache.ticketsCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.ticketsCache.readBackupData | | false |
| cache.ticketsCache.timeToLiveSeconds | | 0 |
| cache.userToAuthoritySharedCache.backup-count | | 1 |
| cache.userToAuthoritySharedCache.cluster.type | | fully-distributed |
| cache.userToAuthoritySharedCache.eviction-policy | | LRU |
| cache.userToAuthoritySharedCache.maxIdleSeconds | | 0 |
| cache.userToAuthoritySharedCache.maxItems | | 5000 |
| cache.userToAuthoritySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.userToAuthoritySharedCache.readBackupData | | false |
| cache.userToAuthoritySharedCache.timeToLiveSeconds | | 0 |
| cache.userToAuthoritySharedCache.tx.maxItems | | 100 |
| cache.userToAuthoritySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.usernameToTicketIdCache.backup-count | | 1 |
| cache.usernameToTicketIdCache.cluster.type | | fully-distributed |
| cache.usernameToTicketIdCache.eviction-policy | | LRU |
| cache.usernameToTicketIdCache.maxIdleSeconds | | 0 |
| cache.usernameToTicketIdCache.maxItems | | 1000 |
| cache.usernameToTicketIdCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.usernameToTicketIdCache.readBackupData | | false |
| cache.usernameToTicketIdCache.timeToLiveSeconds | | 0 |
| cache.webScriptsRegistrySharedCache.backup-count | | 1 |
| cache.webScriptsRegistrySharedCache.cluster.type | | invalidating |
| cache.webScriptsRegistrySharedCache.eviction-policy | | LRU |
| cache.webScriptsRegistrySharedCache.maxIdleSeconds | | 0 |
| cache.webScriptsRegistrySharedCache.maxItems | | 1000 |
| cache.webScriptsRegistrySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.webScriptsRegistrySharedCache.readBackupData | | false |
| cache.webScriptsRegistrySharedCache.timeToLiveSeconds | | 0 |
| cache.webServicesQuerySessionSharedCache.backup-count | | 1 |
| cache.webServicesQuerySessionSharedCache.cluster.type | | fully-distributed |
| cache.webServicesQuerySessionSharedCache.eviction-policy | | LRU |
| cache.webServicesQuerySessionSharedCache.maxIdleSeconds | | 0 |
| cache.webServicesQuerySessionSharedCache.maxItems | | 1000 |
| cache.webServicesQuerySessionSharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.webServicesQuerySessionSharedCache.readBackupData | | false |
| cache.webServicesQuerySessionSharedCache.timeToLiveSeconds | | 0 |
| cache.webServicesQuerySessionSharedCache.tx.maxItems | | 50 |
| cache.webServicesQuerySessionSharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| cache.zoneToAuthoritySharedCache.backup-count | | 1 |
| cache.zoneToAuthoritySharedCache.cluster.type | | invalidating |
| cache.zoneToAuthoritySharedCache.eviction-policy | | LRU |
| cache.zoneToAuthoritySharedCache.maxIdleSeconds | | 0 |
| cache.zoneToAuthoritySharedCache.maxItems | | 500 |
| cache.zoneToAuthoritySharedCache.merge-policy | | com.hazelcast.map.merge.PutIfAbsentMapMergePolicy |
| cache.zoneToAuthoritySharedCache.readBackupData | | false |
| cache.zoneToAuthoritySharedCache.timeToLiveSeconds | | 0 |
| cache.zoneToAuthoritySharedCache.tx.maxItems | | 500 |
| cache.zoneToAuthoritySharedCache.tx.statsEnabled | | ${caches.tx.statsEnabled} |
| caches.tx.statsEnabled | | true |
| category.queryFetchSize | Maximum query size for category/tag fetch when not explicitly set by paging parameters | 5000 |
| cmis.disable.hidden.leading.period.files | | false |
| content.metadataExtracter.default.timeoutMs | The default timeout for metadata mapping extracters | 20000 |
| content.metadataExtracter.pdf.maxConcurrentExtractionsCount | | 5 |
| content.metadataExtracter.pdf.maxDocumentSizeMB | | 10 |
| content.metadataExtracter.pdf.overwritePolicy | The default overwrite policy for PdfBoxMetadataExtracter | PRAGMATIC |
| content.transformer.PdfBox.extractBookmarksText | True if bookmarks content should be extracted for PDFBox | true |
| content.transformer.retryOn.different.mimetype | Enable transformation retrying if the file has MIME type differ than file extension. Ignored if transformer.strict.mimetype.check is true as these transformations will not take place. | true |
| contentPropertyRestrictions.enabled | If enabled doesn't allow to set content properties via NodeService | true |
| contentPropertyRestrictions.whitelist |
| cors.allowed.headers | CORS settings | Authorization,Content-Type,Cache-Control,X-Requested-With,accept,Origin,Access-Control-Request-Method,Access-Control-Request-Headers,X-CSRF-Token |
| cors.allowed.methods | CORS settings | GET,POST,HEAD,OPTIONS,PUT,DELETE |
| cors.allowed.origins | CORS settings |
| cors.enabled | CORS settings | false |
| cors.exposed.headers | CORS settings | Access-Control-Allow-Origin,Access-Control-Allow-Credentials |
| cors.preflight.maxage | CORS settings | 10 |
| cors.support.credentials | CORS settings | true |
| create.missing.people | ome authentication mechanisms may need to create people in the repository on demand. This enables that feature. If disabled an error will be generated for missing people. If enabled then a person will be created and persisted. | ${server.transaction.allow-writes} |
| csrf.filter.enabled | CSRF filter overrides | true |
| csrf.filter.origin | CSRF filter overrides |
| csrf.filter.origin.always | CSRF filter overrides | false |
| csrf.filter.referer | CSRF filter overrides |
| csrf.filter.referer.always | CSRF filter overrides | false |
| db.driver | Database configuration | org.gjt.mm.mysql.Driver |
| db.name | Database configuration | alfresco |
| db.password | Database configuration | alfresco |
| db.pool.abandoned.detect | Database configuration | false |
| db.pool.abandoned.log | db.pool.abandoned.log=true (logAbandoned) adds [overhead](http://commons.apache.org/dbcp/configuration.html) and also requires db.pool.abandoned.detect=true (removeAbandoned) | false |
| db.pool.abandoned.time | Database configuration | 300 |
| db.pool.evict.idle.min | Database configuration | 1800000 |
| db.pool.evict.interval | Database configuration | 600000 |
| db.pool.evict.num.tests | note: for db.pool.evict.num.tests see [http://commons.apache.org/dbcp/configuration.html](http://commons.apache.org/dbcp/configuration.html) (numTestsPerEvictionRun) and also following extract from "org.apache.commons.pool.impl.GenericKeyedObjectPool" (1.5.5). The number of objects to examine during each run of the idle object evictor thread (if any). When a negative value is supplied, ceil({@link #getNumIdle})/abs({@link #getNumTestsPerEvictionRun}) tests will be run. I.e., when the value is -n, roughly one nth of the idle objects will be tested per run. | -1 |
| db.pool.evict.validate | Database configuration | false |
| db.pool.idle | Database configuration | 10 |
| db.pool.initial | Database configuration | 10 |
| db.pool.max | Database configuration | 275 |
| db.pool.min | Database configuration | 10 |
| db.pool.statements.enable | Database configuration | true |
| db.pool.statements.max | Database configuration | 40 |
| db.pool.validate.borrow | Database configuration | true |
| db.pool.validate.query | Database configuration | |
| db.pool.validate.return | Database configuration | false |
| db.pool.wait.max | Database configuration | 5000 |
| db.schema.name | Database configuration | |
| db.schema.stopAfterSchemaBootstrap | Database configuration | false |
| db.schema.update | Database configuration | true |
| db.schema.update.lockRetryCount | Database configuration | 24 |
| db.schema.update.lockRetryWaitSeconds | Database configuration | 5 |
| db.txn.isolation | Database configuration | -1 |
| db.url | Database configuration | `jdbc:mysql:///${db.name}` |
| db.username | Database configuration | alfresco |
| default.async.action.corePoolSize | Default Async Action Thread Pool | 8 |
| default.async.action.maximumPoolSize | Default Async Action Thread Pool | 20 |
| default.async.action.threadPriority | Default Async Action Thread Pool | 1 |
| deployment.method | Deployment method used to deploy this Alfresco instance (DEFAULT, INSTALLER, DOCKER_COMPOSE, HELM_CHART, ZIP, QUICK_START) | DEFAULT |
| deployment.service.corePoolSize | Deployment Service | 2 |
| deployment.service.maximumPoolSize | Deployment Service | 3 |
| deployment.service.numberOfSendingThreads | Deployment Service | 5 |
| deployment.service.targetLockRefreshTime | How long to wait in mS before refreshing a target lock - detects shutdown servers | 60000 |
| deployment.service.targetLockTimeout | How long to wait in mS from the last communication before deciding that deployment has failed, possibly the destination is no longer available? | 3600000 |
| deployment.service.threadPriority | Deployment Service | 5 |
| dir.cachedcontent | The location of cached content | ${dir.root}/cachedcontent |
| dir.contentstore | Content store folder path | ${dir.root}/contentstore |
| dir.contentstore.bucketsPerMinute | | 0 |
| dir.contentstore.deleted | Content soter deleted folder path | ${dir.root}/contentstore.deleted |
| dir.contentstore.tenants | Multi-Tenancy. If dir.contentstore.tenants is set then tenants are not co-mingled and all content roots will appear below this container (in `<tenantdomain>` sub-folder) and when creating a tenant the contentRootPath (root content store directory for a given tenant) will be ignored | |
| dir.indexes | The location for lucene index files | ${dir.root}/lucene-indexes |
| dir.indexes.backup | The location for index backups | ${dir.root}/backup-lucene-indexes |
| dir.indexes.lock | The location for lucene index locks | ${dir.indexes}/locks |
| dir.keystore | Encryption properties. Default keystores location | classpath:alfresco/keystore |
| dir.license.external | Directory to find external license | . |
| dir.root | Root folder path | ./alf_data |
| domain.name.caseSensitive | Are domain names case sensitive? | false |
| domain.separator | | |
| download.cleaner.batchSize | Download Service Cleanup. -1 or 0 for not using batches | 1000 |
| download.cleaner.cleanAllSysDownloadFolders | You could set this to false for new installations greater then ACS 6.2 see MNT-20212 | true |
| download.cleaner.maxAgeMins | Download Service Cleanup | 60 |
| download.cleaner.repeatIntervalMilliseconds | Download Service Cleanup | 3600000 |
| download.cleaner.startDelayMilliseconds | Download Service Cleanup | 3600000 |
| download.maxContentSize | Download Service Limits, in bytes | 2152852358 |
| encryption.bootstrap.reencrypt | Should encryptable properties be re-encrypted with new encryption keys on botstrap? | false |
| encryption.cipherAlgorithm | General encryption parameters | AES/CBC/PKCS5Padding |
| encryption.keyAlgorithm | General encryption parameters | AES |
| encryption.keySpec.class | General encryption parameters | org.alfresco.encryption.DESEDEKeyGenerator |
| encryption.keystore.backup.keyMetaData.location | Configuration via metadata is deprecated | |
| encryption.keystore.backup.location | Backup secret key keystore configuration | ${dir.keystore}/backup-keystore |
| encryption.keystore.backup.provider | | |
| encryption.keystore.backup.type | | pkcs12 |
| encryption.keystore.keyMetaData.location | Configuration via metadata is deprecated | |
| encryption.keystore.location | Secret key keystore configuration | ${dir.keystore}/keystore |
| encryption.keystore.provider | | |
| encryption.keystore.type | | pkcs12 |
| encryption.mac.algorithm | mac/md5 encryption | HmacSHA1 |
| encryption.mac.messageTimeout | mac/md5 encryption | 30000 |
| encryption.reencryptor.chunkSize | Re-encryptor properties | 100 |
| encryption.reencryptor.numThreads | Re-encryptor properties | 2 |
| encryption.ssl.keystore.keyMetaData.location | Configuration via metadata is deprecated | |
| encryption.ssl.keystore.location | ssl encryption | ${dir.keystore}/ssl.keystore |
| encryption.ssl.keystore.provider | ssl encryption | |
| encryption.ssl.keystore.type | ssl encryption | JCEKS |
| encryption.ssl.truststore.keyMetaData.location | Configuration via metadata is deprecated | |
| encryption.ssl.truststore.location | | ${dir.keystore}/ssl.truststore |
| encryption.ssl.truststore.provider | | |
| encryption.ssl.truststore.type | | JCEKS |
| events.subsystem.autoStart | Events subsystem | true |
| fileFolderService.checkHidden.enabled | | true |
| filecontentstore.subsystem.name | ContentStore subsystem: default choice | unencryptedContentStore |
| ftp.enabled | FTP access | false |
| fts.indexer.batchSize | | 1000 |
| heartbeat.enabled | HeartBeat | true |
| heartbeat.target.url | HeartBeat | |
| hibernate.jdbc.use_get_generated_keys | | false |
| home.folder.creation.disabled | Disable home folder creation - if true then home folders are not created (neither eagerly nor lazily) | false |
| home.folder.creation.eager | Create home folders (unless disabled, see next property) as people are created (true) or create them lazily (false) | true |
| home_folder_provider_synchronizer.enabled | Used to move home folders to a new location | false |
| home_folder_provider_synchronizer.keep_empty_parents | Used to move home folders to a new location | false |
| home_folder_provider_synchronizer.override_provider | Used to move home folders to a new location | |
| hybridworkflow.enabled | | false |
| imap.attachments.folder.folderPath | Imap extraction settings | ${spaces.imap_attachments.childname} |
| imap.attachments.folder.rootPath | Imap extraction settings | /${spaces.company_home.childname} |
| imap.attachments.folder.store | Imap extraction settings | ${spaces.store} |
| imap.attachments.mode | SEPARATE -- All attachments for each email will be extracted to separate folder. COMMON -- All attachments for all emails will be extracted to one folder. SAME -- Attachments will be extracted to the same folder where email lies. | SEPARATE |
| imap.config.home.folderPath | Default IMAP mount points | ${spaces.imap_home.childname} |
| imap.config.home.rootPath | Default IMAP mount points | /${spaces.company_home.childname} |
| imap.config.home.store | Default IMAP mount points | ${spaces.store} |
| imap.config.server.mountPoints | Default IMAP mount points | AlfrescoIMAP |
| imap.config.server.mountPoints.default.modeName | Default IMAP mount points | ARCHIVE |
| imap.config.server.mountPoints.default.mountPointName | Default IMAP mount points | IMAP |
| imap.config.server.mountPoints.default.rootPath | Default IMAP mount points | ${protocols.rootPath} |
| imap.config.server.mountPoints.default.store | Default IMAP mount points | ${spaces.store} |
| imap.config.server.mountPoints.value.AlfrescoIMAP.modeName | Default IMAP mount points | MIXED |
| imap.config.server.mountPoints.value.AlfrescoIMAP.mountPointName | Default IMAP mount points | Alfresco IMAP |
| imap.server.attachments.extraction.enabled | IMAP property | true |
| imap.server.enabled | IMAP property | false |
| imap.server.port | IMAP property | 143 |
| img.dyn | External executable locations | ${img.root}/lib |
| img.exe | External executable locations | ${img.root}/bin/convert |
| img.root | External executable locations | ./ImageMagick |
| img.startupRetryPeriodSeconds | When img.url is set, this value indicates the amount of time to wait after a connection failure before retrying the connection to allow a docker container to (re)start. | 60 |
| img.url | Legacy imageMagick transformer url to T-Engine to service transform requests via http. Disabled by default. | |
| index.backup.cronExpression | | `0 0 3 * * ?` |
| index.subsystem.name | | noindex |
| index.tracking.minRecordPurgeAgeDays | Index tracking information of a certain age is cleaned out by a scheduled job. Any clustered system that has been offline for longer than this period will need to be seeded with a more recent backup of the Lucene indexes or the indexes will have to be fully rebuilt.Use -1 to disable purging. This can be switched on at any stage. | 30 |
| index.tracking.purgeSize | Unused transactions will be purged in chunks determined by commit time boundaries. 'index.tracking.purgeSize' specifies the size of the chunk (in ms). Default is a couple of hours. | 7200000 |
| legacy.transform.service.enabled | Used to disable transforms that extend AbstractContentTransformer2 | true |
| links.protocosl.white.list | Allowed protocols for links | http,https,ftp,mailto |
| local.tregacy.transform.service.enabledansform.pipeline.config.dir | Optional property to specify an external file or directory that will be read for transformer json config. | shared/classes/alfresco/extension/transform/pipelines |
| local.transform.service.cronExpression | Schedule for reading local transform config, so that T-Engines and local pipeline config is dynamically picked up, or reintegrated after an outage. Initially checks every 10 seconds and then switches to every hour after the configuration is read successfully. If there is a error later reading the config, the checks return to every 10 seconds. | `4 30 0/1 * * ?` |
| local.transform.service.enabled | Used to disable transforms locally. | true |
| local.transform.service.initialAndOnError.cronExpression | | `0/10 * * * * ?` |
| localTransform.core-aio.startupRetryPeriodSeconds | When a local transformer .url is set, this value indicates the amount of time to wait after a connection failure before retrying the connection to allow a docker container to (re)start. | 60 |
| localTransform.core-aio.url | Local transformer urls to T-engines to service transform requests via http. Enabled by default. | `http://localhost:8090/` |
| location.license.embedded | Spring resource location of embedded license files | /WEB-INF/alfresco/license/*.lic |
| location.license.external | Spring resource location of external license files | file://${dir.license.external}/*.lic |
| location.license.shared | Spring resource location of license files on shared classpath | classpath*:/alfresco/extension/license/*.lic |
| lucene.commit.lock.timeout | | 100000 |
| lucene.defaultAnalyserResourceBundleName | | alfresco/model/dataTypeAnalyzers |
| lucene.indexer.batchSize | The size of the queue of nodes waiting for index. Events are generated as nodes are changed, this is the maximum size of the queue used to coalesce event. When this size is reached the lists of nodes will be indexed. [http://issues.alfresco.com/browse/AR-1280](http://issues.alfresco.com/browse/AR-1280): Setting this high is the workaround as of 1.4.3. | 1000000 |
| lucene.indexer.cacheEnabled | Index cache sizes | true |
| lucene.indexer.contentIndexingEnabled | | true |
| lucene.indexer.defaultMLIndexAnalysisMode | | EXACT_LANGUAGE_AND_ALL |
| lucene.indexer.defaultMLSearchAnalysisMode | | EXACT_LANGUAGE_AND_ALL |
| lucene.indexer.fairLocking | Should we use a 'fair' locking policy, giving queue-like access behaviour to the indexes and avoiding starvation of waiting writers? Set to false on old JVMs where this appears to cause deadlock | true |
| lucene.indexer.maxDocIdCacheSize | | 100000 |
| lucene.indexer.maxDocsForInMemoryIndex | | 60000 |
| lucene.indexer.maxDocsForInMemoryMerge | | 60000 |
| lucene.indexer.maxDocumentCacheSize | | 100 |
| lucene.indexer.maxFieldLength | The number of terms from a document that will be indexed | 10000 |
| lucene.indexer.maxIsCategoryCacheSize | | -1 |
| lucene.indexer.maxLinkAspectCacheSize | | 10000 |
| lucene.indexer.maxParentCacheSize | | 100000 |
| lucene.indexer.maxPathCacheSize | | 100000 |
| lucene.indexer.maxRamInMbForInMemoryIndex | | 16 |
| lucene.indexer.maxRamInMbForInMemoryMerge | | 16 |
| lucene.indexer.maxRawResultSetSizeForInMemorySort | | 1000 |
| lucene.indexer.maxTypeCacheSize | | 10000 |
| lucene.indexer.mergerMaxBufferedDocs | | -1 |
| lucene.indexer.mergerMaxMergeDocs | Properties for merge (not this does not affect the final index segment which will be optimised). Max merge docs only applies to the merge process not the resulting index which will be optimised. | 1000000 |
| lucene.indexer.mergerMergeFactor | | 5 |
| lucene.indexer.mergerRamBufferSizeMb | | 16 |
| lucene.indexer.mergerTargetIndexCount | Target number of indexes and deltas in the overall index and what index size to merge in memory | 8 |
| lucene.indexer.mergerTargetOverlayCount | | 5 |
| lucene.indexer.mergerTargetOverlaysBlockingFactor | | 2 |
| lucene.indexer.postSortDateTime | over-ride to false for pre 3.0 behaviour | true |
| lucene.indexer.termIndexInterval | | 128 |
| lucene.indexer.useInMemorySort | | true |
| lucene.indexer.useNioMemoryMapping | | true |
| lucene.indexer.writerMaxBufferedDocs | | -1 |
| lucene.indexer.writerMaxMergeDocs | Properties for delta indexes (not this does not affect the final index segment which will be optimised). Max merge docs only applies to the index building process not the resulting index which will be optimised. | 1000000 |
| lucene.indexer.writerMergeFactor | | 5 |
| lucene.indexer.writerRamBufferSizeMb | | 16 |
| lucene.lock.poll.interval | | 100 |
| lucene.maxAtomicTransformationTime | Millisecond threshold for text transformations. Slower transformers will force the text extraction to be asynchronous | 100 |
| lucene.query.maxClauses | The maximum number of clauses that are allowed in a lucene query | 10000 |
| lucene.write.lock.timeout | Index locks (mostly deprecated and will be tidied up with the next lucene upgrade) | 10000 |
| mail.service.corePoolSize | Oubound Mail | 8 |
| mail.service.maximumPoolSize | Oubound Mail | 20 |
| mbean.server.locateExistingServerIfPossible | Should the Mbean server bind to an existing server. Set to true for most application servers. false for WebSphere clusters. | true |
| messaging.broker.connections.max | | 8 |
| messaging.broker.connections.maxActiveSessionsPerConnection | | 1000 |
| messaging.broker.password | | |
| messaging.broker.ssl | | false |
| messaging.broker.url | | failover:(tcp://localhost:61616)?timeout=3000&jms.useCompression=true |
| messaging.broker.username | | |
| messaging.camel.context.id | | alfrescoCamelContext |
| messaging.subsystem.autoStart | Messaging subsystem | true |
| messaging.transacted | | true |
| metrics.dbMetricsReporter.enabled | | false |
| metrics.dbMetricsReporter.query.enabled | | false |
| metrics.dbMetricsReporter.query.statements.enabled | | false |
| metrics.enabled | | false |
| metrics.jvmMetricsReporter.enabled | | false |
| metrics.restMetricsReporter.enabled | | false |
| metrics.restMetricsReporter.path.enabled | | false |
| metrics.tomcatMetricsReporter.enabled | | false |
| mimetype.config.cronExpression | Schedule for reading mimetype config definitions dynamically. Initially checks every 10 seconds and then switches to every hour after the configuration is read successfully. If there is a error later reading the config, the checks return to every 10 seconds. | `0 30 0/1 * * ?` |
| mimetype.config.dir | Optional property to specify an external file or directory that will be read for mimetype definitions from YAML files (possibly added to a volume via k8 ConfigMaps). | shared/classes/alfresco/extension/mimetypes |
| mimetype.config.initialAndOnError.cronExpression | | `0/10 * * * * ?` |
| models.enforceTenantInNamespace | | false |
| monitor.rmi.service.enabled | enable or disable individual RMI services | false |
| monitor.rmi.service.port | RMI service ports for the individual services. These eight services are available remotely. Assign individual ports for each service for best performance or run several services on the same port, you can even run everything on 50500 if running through a firewall. Specify 0 to use a random unused port. | 50508 |
| mybatis.useLocalCaches | | false |
| nodes.bulkLoad.cachingThreshold | | 10 |
| notification.email.siteinvite | Should send emails as part of invitation process. | true |
| opencmis.activities.enabled | OpenCMIS property | true |
| opencmis.bulkUpdateProperties.batchSize | OpenCMIS property | 20 |
| opencmis.bulkUpdateProperties.maxItemsSize | OpenCMIS property | 1000 |
| opencmis.bulkUpdateProperties.workerThreads | OpenCMIS property | 2 |
| opencmis.connector.default.contentChangesDefaultMaxItems | OpenCMIS property | 10000 |
| opencmis.connector.default.objectsDefaultDepth | OpenCMIS property | 100 |
| opencmis.connector.default.objectsDefaultMaxItems | OpenCMIS property | 10000 |
| opencmis.connector.default.openHttpSession | OpenCMIS property | false |
| opencmis.connector.default.rootPath | OpenCMIS property | /${spaces.company_home.childname} |
| opencmis.connector.default.store | OpenCMIS property | ${spaces.store} |
| opencmis.connector.default.typesDefaultDepth | OpenCMIS property | -1 |
| opencmis.connector.default.typesDefaultMaxItems | OpenCMIS property | 500 |
| opencmis.context.override | URL generation overrides. If true, the context path of OpenCMIS generated urls will be set to "opencmis.context.value", otherwise it will be taken from the request url | false |
| opencmis.context.value | URL generation overrides | |
| opencmis.maxContentSizeMB | OpenCMIS property | 4096 |
| opencmis.memoryThresholdKB | OpenCMIS property | 4096 |
| opencmis.server.override | URL generation overrides | false |
| opencmis.server.value | URL generation overrides | |
| opencmis.servletpath.override | If true, the servlet path of OpenCMIS generated urls will be set to "opencmis.servletpath.value", otherwise it will be taken from the request url | false |
| opencmis.servletpath.value | URL generation overrides | |
| orphanReaper.lockRefreshTime | OrphanReaper | 60000 |
| orphanReaper.lockTimeOut | OrphanReaper | 3600000 |
| people.search.honor.hint.useCQ | Use a canned query when requested to search for people if "[hint:useCQ]" is provided in search term | true |
| policy.content.update.ignoreEmpty | Should we consider zero byte content to be the same as no content when firing content update policies? Prevents 'premature' firing of inbound content rules for some clients such as Mac OS X Finder | true |
| protocols.rootPath | Default root path for protocols | /${spaces.company_home.childname} |
| protocols.storeName | Default store name| ${spaces.store} |
| rendition.config.cronExpression | Schedule for reading rendition config definitions dynamically. Initially checks every 10 seconds and then switches to every hour after the configuration is read successfully. If there is a error later reading the config, the checks return to every 10 seconds. | `2 30 0/1 * * ?` |
| rendition.config.dir | Optional property to specify an external file or directory that will be read for rendition definitions from YAML files (possibly added to a volume via k8 ConfigMaps). | shared/classes/alfresco/extension/transform/renditions |
| rendition.config.initialAndOnError.cronExpression | | `0/10 * * * * ?` |
| renditionService2.enabled | Rendition Service 2 | true |
| replication.enabled | Replication Service | false |
| repo.event2.filter.nodeAspects | Repo events2 | |
| repo.event2.filter.nodeTypes | Repo events2. Type and aspect filters which should be excluded. Note: System folders node types are added by default | sys:*, fm:*, cm:thumbnail, cm:failedThumbnail, cm:rating, rma:rmsite include_subtypes |
| repo.event2.filter.users | Comma separated list of users which should be excluded. Note: username's case-sensitivity depends on the {user.name.caseSensitive} setting | System, null |
| repo.event2.topic.endpoint | Topic name | amqp:topic:alfresco.repo.event2 |
| repo.remote.endpoint | repo.remote.endpoint | /service |
| repository.name | The name of the repository | Main Repository |
| sample.site.disabled | | false |
| security.anyDenyDenies | Security | true |
| security.postProcessDenies | Whether to post-process denies. Only applies to solr4+ when anyDenyDenies is true. | false |
| server.allowedusers | | |
| server.allowWrite | | true |
| server.maxusers | Server Max Users - limit number of users with non-expired tickets. Note: -1 allows any number of users, assuming not in single-user mode 0 prevents further logins, including the ability to enter single-user mode. | -1 |
| server.setup.transaction.max-retries | | 40 |
| server.setup.transaction.max-retry-wait-ms | | 15000 |
| server.setup.transaction.min-retry-wait-ms | | 15000 |
| server.setup.transaction.wait-increment-ms | | 10 |
| server.transaction.allow-writes | | true |
| server.transaction.max-retries | | 40 |
| server.transaction.max-retry-wait-ms | | 2000 |
| server.transaction.min-retry-wait-ms | | 100 |
| server.transaction.mode.default | | PROPAGATION_REQUIRED |
| server.transaction.mode.readOnly | | PROPAGATION_REQUIRED, readOnly |
| server.transaction.wait-increment-ms | | 100 |
| server.web.transaction.max-duration-ms | | 0 |
| sfs.endpoint | | ${sfs.url}/alfresco/api/-default-/private/sfs/versions/1 |
| sfs.url | | |
| share.context | Share context | share |
| share.host | Share hostname | ${localname} |
| share.port | Share port | 8080 |
| share.protocol | Share protocol | http |
| site.public.group | This property controls who has visibility of created share sites. | GROUP_EVERYONE |
| shutdown.backstop.enabled | | false |
| shutdown.backstop.timeout | How long should shutdown wait to complete normally before taking stronger action and calling System.exit() in ms, 10,000 is 10 seconds | 10000 |
| site.invite.moderated.workflowId | Moderated invite Activiti workflow |activiti$activitiInvitationModerated |
| site.invite.nominated.workflowId | Add intneral users Activiti workflow (use activiti$activitiInvitationNominated to revert to requiring accept of invite for internal users) | activiti$activitiInvitationNominatedAddDirect |
| site.invite.nominatedExternal.workflowId | Add external users Activiti workflow | activiti$activitiInvitationNominated |
| smart.download.associations.folder | | ${spaces.dictionary.childname}/${spaces.smartdownloads.childname} |
| smart.folders.config.custom.aspect | Custom virtualization method aspect. | smf:customConfigSmartFolder |
| smart.folders.config.custom.aspect.template.association | Custom virtualization method aspect template content association. | smf:custom-template-association |
| smart.folders.config.system.aspect | System virtualization method aspect. | smf:systemConfigSmartFolder |
| smart.folders.config.system.aspect.template.location.property | System virtualization method aspect defined template location property. | smf:system-template-location |
| smart.folders.config.system.templates.classpath | Classpath to be explored for *.json entries defining system templates. | /org/alfresco/repo/virtual/node |
| smart.folders.config.system.templates.path | A company home relative name or qname path location of repository system templates. | ${spaces.dictionary.childname}/${spaces.smartfolders.childname} |
| smart.folders.config.system.templates.template.type | Content sub type of repository system templates. | smf:smartFolderTemplate |
| smart.folders.config.type.templates.path | A company home relative name or qname path location of the type mapped templates. | ${spaces.dictionary.childname}/${spaces.smartfolders.childname} |
| smart.folders.config.type.templates.qname.filter | Type and aspect qname regular expression filter. | none |
| smart.folders.config.vanilla.processor.classpath | Vanilla JSON templates javascript processor classpath. A java script processor used to convert JSON templates to internal smart folder definitions. | /org/alfresco/repo/virtual/node/vanilla.js |
| smart.folders.enabled | Smart Folders Config Properties | false |
| smart.reference.classpath.hash | Smart reference config | ${smart.folders.config.vanilla.processor.classpath}->1,${smart.folders.config.system.templates.classpath}->2 |
| solr.cmis.alternativeDictionary | SOLR connection details (e.g. for JMX) | DEFAULT_DICTIONARY |
| solr.host | SOLR hostname | localhost |
| solr.max.host.connections | Maximum number of connections | 40 |
| solr.max.total.connections | Total number of connections |40 |
| solr.port | SOLR port | 8983 |
| solr.port.ssl | SOLR SSL port | 8984 |
| solr.secureComms | Determines whether to connect to SOLR using HTTPS (none, https) | https |
| solr.solrConnectTimeout | Solr connect timeout in ms | 5000 |
| solr.solrPassword | Default SOLR password | solr |
| solr.solrPingCronExpression | cron expression defining how often the Solr Admin client (used by JMX) pings Solr if it goes away | `0 0/5 * * * ? *` |
| solr.solrUser | Default SOLR username | solr |
| solr.store.mappings | Default SOLR store mappings mappings | solrMappingAlfresco,solrMappingArchive |
| solr.store.mappings.value.solrMappingAlfresco.baseUrl | Default SOLR store mappings mappings | /solr/alfresco |
| solr.store.mappings.value.solrMappingAlfresco.httpClientFactory | Default SOLR store mappings mappings | solrHttpClientFactory |
| solr.store.mappings.value.solrMappingAlfresco.identifier | Default SOLR store mappings mappings | SpacesStore |
| solr.store.mappings.value.solrMappingAlfresco.protocol | Default SOLR store mappings mappings | workspace |
| solr.store.mappings.value.solrMappingArchive.baseUrl | Default SOLR store mappings mappings |/solr/archive |
| solr.store.mappings.value.solrMappingArchive.httpClientFactory | Default SOLR store mappings mappings | solrHttpClientFactory |
| solr.store.mappings.value.solrMappingArchive.identifier | Default SOLR store mappings mappings | SpacesStore |
| solr.store.mappings.value.solrMappingArchive.protocol | Default SOLR store mappings mappings | archive |
| solr4.store.mappings | Default SOLR 4 store mappings mappings | solrMappingAlfresco,solrMappingArchive |
| solr4.store.mappings.value.solrMappingAlfresco.baseUrl | Default SOLR 4 store mappings mappings | /solr4/alfresco |
| solr4.store.mappings.value.solrMappingAlfresco.httpClientFactory | Default SOLR 4 store mappings mappings | solrHttpClientFactory |
| solr4.store.mappings.value.solrMappingAlfresco.identifier | Default SOLR 4 store mappings mappings | SpacesStore |
| solr4.store.mappings.value.solrMappingAlfresco.protocol | Default SOLR 4 store mappings mappings | workspace |
| solr4.store.mappings.value.solrMappingArchive.baseUrl | Default SOLR 4 store mappings mappings | /solr4/archive |
| solr4.store.mappings.value.solrMappingArchive.httpClientFactory | Default SOLR 4 store mappings mappings | solrHttpClientFactory |
| solr4.store.mappings.value.solrMappingArchive.identifier | Default SOLR 4 store mappings mappings | SpacesStore |
| solr4.store.mappings.value.solrMappingArchive.protocol | Default SOLR 4 store mappings mappings | archive |
| solr6.store.mappings | Default SOLR 6 store mappings mappings | solrMappingAlfresco,solrMappingArchive,solrMappingHistory |
| solr6.store.mappings.value.solrMappingAlfresco.baseUrl | Default SOLR 6 store mappings mappings | /solr/alfresco |
| solr6.store.mappings.value.solrMappingAlfresco.httpClientFactory | Default SOLR 6 store mappings mappings | solrHttpClientFactory |
| solr6.store.mappings.value.solrMappingAlfresco.identifier | Default SOLR 6 store mappings mappings | SpacesStore |
| solr6.store.mappings.value.solrMappingAlfresco.protocol | Default SOLR 6 store mappings mappings | workspace |
| solr6.store.mappings.value.solrMappingArchive.baseUrl | Default SOLR 6 store mappings mappings | /solr/archive |
| solr6.store.mappings.value.solrMappingArchive.httpClientFactory | Default SOLR 6 store mappings mappings | solrHttpClientFactory |
| solr6.store.mappings.value.solrMappingArchive.identifier | Default SOLR 6 store mappings mappings | SpacesStore |
| solr6.store.mappings.value.solrMappingArchive.protocol | Default SOLR 6 store mappings mappings | archive |
| solr6.store.mappings.value.solrMappingHistory.baseUrl | Default SOLR 6 store mappings mappings | /solr/history |
| solr6.store.mappings.value.solrMappingHistory.httpClientFactory | Default SOLR 6 store mappings mappings | solrHttpClientFactory |
| solr6.store.mappings.value.solrMappingHistory.identifier | Default SOLR 6 store mappings mappings | history |
| solr6.store.mappings.value.solrMappingHistory.protocol | Default SOLR 6 store mappings mappings | workspace |
| solr_facets.inheritanceHierarchy | Solr Facets Config Properties | default,custom |
| solr_facets.root | Solr Facets Config Properties | ${solr_facets.root.path}/${spaces.solr_facets.root.childname} |
| solr_facets.root.path | Solr Facets Config Properties | /app:company_home/app:dictionary |
| spaces.archive.store | Spaces Archive Configuration | archive://SpacesStore |
| spaces.company_home.childname | Spaces Configuration | app:company_home |
| spaces.content_forms.childname | Spaces Configuration | app:forms |
| spaces.dictionary.childname | Spaces Configuration | app:dictionary |
| spaces.emailActions.childname | Spaces Configuration | app:email_actions |
| spaces.extension_webscripts.childname | Spaces Configuration | cm:extensionwebscripts |
| spaces.guest_home.childname | Spaces Configuration | app:guest_home |
| spaces.imapConfig.childname | Spaces Configuration | app:imap_configs |
| spaces.imap_attachments.childname | Spaces Configuration | cm:Imap Attachments |
| spaces.imap_home.childname | Spaces Configuration | cm:Imap Home |
| spaces.imap_templates.childname | Spaces Configuration | app:imap_templates |
| spaces.inbound_transfer_records.childname | Spaces Configuration | app:inbound_transfer_records |
| spaces.models.childname | Spaces Configuration | app:models |
| spaces.nodetemplates.childname | Spaces Configuration | app:node_templates |
| spaces.quickshare.link_expiry_actions.childname | Spaces Configuration | app:quick_share_link_expiry_actions |
| spaces.rendition.rendering_actions.childname | Spaces Configuration | app:rendering_actions |
| spaces.replication.replication_actions.childname | Spaces Configuration | app:replication_actions |
| spaces.savedsearches.childname | Spaces Configuration | app:saved_searches |
| spaces.scheduled_actions.childname | Spaces Configuration | cm:Scheduled Actions |
| spaces.scripts.childname | Spaces Configuration | app:scripts |
| spaces.searchAction.childname | Spaces Configuration | cm:search |
| spaces.shared.childname | Spaces Configuration | app:shared |
| spaces.sites.childname | Spaces Configuration | st:sites |
| spaces.smartdownloads.childname | Spaces Configuration | app:smart_downloads |
| spaces.smartfolders.childname | Spaces Configuration | app:smart_folders |
| spaces.solr_facets.root.childname | Spaces Configuration |srft:facets |
| spaces.store | Spaces Configuration | workspace://SpacesStore |
| spaces.system.childname | Spaces Configuration | sys:system |
| spaces.templates.childname | Spaces Configuration | app:space_templates |
| spaces.templates.content.childname | Spaces Configuration | app:content_templates |
| spaces.templates.email.activities.childname | Spaces Configuration | cm:activities |
| spaces.templates.email.childname | Spaces Configuration | app:email_templates |
| spaces.templates.email.following.childname | Spaces Configuration | pp:following |
| spaces.templates.email.invite.childname | Spaces Configuration | cm:invite |
| spaces.templates.email.invite1.childname | Spaces Configuration | app:invite_email_templates |
| spaces.templates.email.notify.childname | Spaces Configuration | app:notify_email_templates |
| spaces.templates.email.workflowemailnotification.childname | Spaces Configuration | cm:workflownotification |
| spaces.templates.rss.childname | Spaces Configuration | app:rss_templates |
| spaces.transfer_groups.childname | Spaces Configuration | app:transfer_groups |
| spaces.transfer_summary_report.location | Spaces Configuration | /${spaces.company_home.childname}/${spaces.dictionary.childname}/${spaces.transfers.childname}/${spaces.inbound_transfer_records.childname} |
| spaces.transfer_temp.childname | Spaces Configuration | app:temp |
| spaces.transfers.childname | Spaces Configuration | app:transfers |
| spaces.user_homes.childname | Spaces Configuration | app:user_homes |
| spaces.user_homes.regex.group_order | Spaces Configuration | |
| spaces.user_homes.regex.key | Spaces Configuration | userName |
| spaces.user_homes.regex.pattern | Spaces Configuration | |
| spaces.webscripts.childname | Spaces Configuration | cm:webscripts |
| spaces.workflow.definitions.childname | Spaces Configuration | app:workflow_defs |
| subsystems.test.beanProp | Subsystem unit test values. Will not have any effect on production servers | inst1,inst2,inst3 |
| subsystems.test.beanProp.default.anotherStringProperty | Subsystem unit test values. Will not have any effect on production servers | Global Default |
| subsystems.test.beanProp.default.longProperty | Subsystem unit test values. Will not have any effect on production servers | 123456789123456789 |
| subsystems.test.beanProp.value.inst2.boolProperty | Subsystem unit test values. Will not have any effect on production servers | true |
| subsystems.test.beanProp.value.inst3.anotherStringProperty | Subsystem unit test values. Will not have any effect on production servers | Global Instance Default |
| subsystems.test.simpleProp2 | Subsystem unit test values. Will not have any effect on production servers | true |
| subsystems.test.simpleProp3 | Subsystem unit test values. Will not have any effect on production servers | Global Default3 |
| system.acl.maxPermissionCheckTimeMillis | Property to limit resources spent on individual searches. The maximum time spent pruning results. | 10000 |
| system.acl.maxPermissionChecks |Property to limit resources spent on individual searches.The maximum number of search results to perform permission checks against. | 1000 |
| system.api.discovery.enabled | | true |
| system.auditableData.ACLs | Specific control of whether ACL changes on a node trigger the cm:auditable aspect | ${system.auditableData.preserve} |
| system.auditableData.FileFolderService | Specific control of how the FileFolderService treats cm:auditable data when performing moves | ${system.auditableData.preserve} |
| system.auditableData.preserve | The default to preserve all cm:auditable data on a node when the process is not directly driven by a user action | ${system.preserve.modificationData} |
| system.authorities_container.childname | Folders for storing people | sys:authorities |
| system.bootstrap.config_check.strict | Change the failure behaviour of the configuration checker | true |
| system.cache.disableImmutableSharedCaches | Disables immutable shared caches. These property is used for diagnostic purposes | false |
| system.cache.disableMutableSharedCaches | Disables mutable shared caches. This property is used for diagnostic purposes | false |
| system.cache.parentAssocs.limitFactor | The average number of parents expected per cache entry. This parameter is multiplied by the above value to compute a limit on the total number of cached parents, which will be proportional to the cache's memory usage. The cache will be pruned when this limit is exceeded to avoid excessive memory usage. | 8 |
| system.cache.parentAssocs.maxSize | The maximum capacity of the parent assocs cache (the number of nodes whose parents can be cached) | 130000 |
| system.certificate_container.childname | Folder for storing IdP's certificate definitions | sys:samlcertificate |
| system.content.caching.cacheOnInbound | Caching Content Store | true |
| system.content.caching.cleanThresholdPct | When a cache file has been written that results in cleanThresholdPct (default 80%) of maxUsageBytes being exceeded then the cached content cleaner is invoked (if not already running) in a new thread. | 80 |
| system.content.caching.contentCleanup.cronExpression | Clean up every day at 3 am | `0 0 3 * * ?` |
| system.content.caching.maxDeleteWatchCount | Caching Content Store | 1 |
| system.content.caching.maxFileSizeMB | maxFileSizeMB - 0 means no max file size. | 0 |
| system.content.caching.maxUsageMB | | 4096 |
| system.content.caching.minFileAgeMillis | | 60000 |
| system.content.caching.normalCleanThresholdSec | Threshold in seconds indicating a minimal gap between normal cleanup starts | 0 |
| system.content.caching.panicThresholdPct | When the CachingContentStore is about to write a cache file but the disk usage is in excess of panicThresholdPct (default 90%) then the cache file is not written and the cleaner is started (if not already running) in a new thread. | 90 |
| system.content.caching.targetUsagePct | An aggressive cleaner is run till the targetUsagePct (default 70%) of maxUsageBytes is achieved | 70 |
| system.content.deletionFailureAction | The action to take when a store or stores fails to delete orphaned content. IGNORE: Just log a warning. The binary remains and the record is expunged. KEEP_URL: Log a warning and create a URL entry with orphan time 0. It won't be processed or removed. | IGNORE |
| system.content.eagerOrphanCleanup | Decide if content should be removed from the system immediately after being orphaned. Do not change this unless you have examined the impact it has on your backup procedures. | false |
| system.content.maximumFileSizeLimit | The value for the maximum permitted size in bytes of all content. No value (or a negative long) will be taken to mean that no limit should be applied. | |
| system.content.orphanCleanup.cronExpression | The CRON expression to trigger the deletion of resources associated with orphaned content. | `0 0 4 * * ?` |
| system.content.orphanProtectDays | The number of days to keep orphaned content in the content stores. This has no effect on the 'deleted' content stores, which are not automatically emptied.| 14 |
| system.cronJob.startDelayMilliseconds | Delays cron jobs after bootstrap to allow server to fully come up before jobs start | 60000 |
| system.delete_not_exists.batchsize | MNT-21083 --DELETE_NOT_EXISTS - default settings | 100000 |
| system.delete_not_exists.delete_batchsize | | 1000 |
| system.delete_not_exists.read_only | | false |
| system.delete_not_exists.timeout_seconds | | -1 |
| system.descriptor.childname | System Configuration | sys:descriptor |
| system.descriptor.current.childname | System Configuration | sys:descriptor-current |
| system.downloads_container.childname | Folder for storing download archives | sys:downloads |
| system.email.sender.default | | noreply@alfresco.com |
| system.enableTimestampPropagation | Determine if modification timestamp propagation from child to parent nodes is respected or not. Even if 'true', the functionality is only supported for child associations that declare the 'propagateTimestamps' element in the dictionary definition. | true |
| system.filefolderservice.defaultListMaxResults | The maximum number of filefolder list results | 5000 |
| system.fixedACLs.maxTransactionTime | Fixed ACLs. Required for fixing MNT-15368 - Time Consumed for Updating Folder Permission. ADMAccessControlListDAO.setFixedAcls called on a large folder hierarchy will take a long time for its execution. For this reason now method can also be called asynchronously if transaction reaches system.fixedACLs.maxTransactionTime. In this case setFixedAcls method recursion will be stopped and unfinished nodes will be marked with ASPECT_PENDING_FIX_ACL. Pending nodes will be processed by FixedAclUpdater, programmatically called but also configured as a scheduled job. | 10000 |
| system.fixedACLsUpdater.cronExpression | fixedACLsUpdater cron expression - fire at midnight every day | `0 0 0 * * ?` |
| system.fixedACLsUpdater.lockTTL | ixedACLsUpdater - lock time to live | 10000 |
| system.fixedACLsUpdater.maxItemBatchSize | fixedACLsUpdater - maximum number of nodes to process per execution | 100 |
| system.fixedACLsUpdater.numThreads | fixedACLsUpdater - the number of threads to use | 4 |
| system.hibernateMaxExecutions | Limit hibernate session size by trying to amalgamate events for the L2 session invalidation. 1. Hibernate works as is up to this size. 2. After the limit is hit events that can be grouped invalidate the L2 cache by type and not instance. Events may not group if there are post action listener registered (this is not the case with the default distribution) | 20000 |
| system.integrity.enabled | Enable system model integrity checking. WARNING: Changing this is unsupported; bugs may corrupt data | true |
| system.integrity.failOnViolation | Do integrity violations fail transactions. WARNING: Changing this is unsupported; bugs may corrupt data | true |
| system.integrity.maxErrorsPerTransaction | The number of errors to report when violations are detected | 5 |
| system.integrity.trace | Add call stacks to integrity events so that errors are logged with possible causes. WARNING: This is expensive and should only be switched on for diagnostic purposes | false |
| system.lockTryTimeout | Lock timeout configuration | 100 |
| system.lockTryTimeout.DictionaryDAOImpl | Lock timeout configuration | 10000 |
| system.lockTryTimeout.MessageServiceImpl | Lock timeout configuration | ${system.lockTryTimeout} |
| system.lockTryTimeout.PolicyComponentImpl | Lock timeout configuration | ${system.lockTryTimeout} |
| system.maximumStringLength | Manually control how the system handles maximum string lengths. Any zero or negative value is ignored. Only change this after consulting support or reading the appropriate Javadocs for org.alfresco.repo.domain.schema.SchemaBootstrap for V2.1.2. Before database migration, the string value storage may need to be adjusted using the scheduled job | -1 |
| system.maximumStringLength.jobCronExpression | | `* * * * * ? 2099` |
| system.maximumStringLength.jobQueryRange | | 10000 |
| system.maximumStringLength.jobThreadCount | | 4 |
| system.metadata-query-indexes-more.ignored | | true |
| system.metadata-query-indexes.ignored | Property to enable index upgrade for metadata query (MDQ). The indexes are not added unless this value is changed. Adding each the supporting indexes may take several hours depending on the size of the database. The required indexes may be added in stages. See: classpath:alfresco/dbscripts/upgrade/4.2/${db.script.dialect}/metadata-query-indexes.sql . See: classpath:alfresco/dbscripts/upgrade/5.1/${db.script.dialect}/metadata-query-indexes-2.sql | true |
| system.patch.addUnmovableAspect.cronExpression | Default values for deferring the running of the addUnmovableAspect patch | 0 0 0 ? 1 1 2030 |
| system.patch.addUnmovableAspect.deferred | Default values for deferring the running of the addUnmovableAspect patch | false |
| system.patch.sharedFolder.cronExpression | Default value is run new years day 2030 i.e. not run. | 0 0 0 ? 1 1 2030 |
| system.patch.sharedFolder.deferred | Do we defer running the shared folder patch? | false |
| system.patch.surfConfigFolder.cronExpression | Default value. i.e. never run. It can be triggered using JMX | `* * * * * ? 2099` |
| system.patch.surfConfigFolder.deferred | Do we defer running the surf-config folder patch? | false |
| system.people_container.childname | Folders for storing people | sys:people |
| system.preferred.password.encoding | Preferred password encoding, md4, sha256, bcrypt10 | md4 |
| system.preserve.modificationData | DEPRECATED: Use system.auditableData.preserve | false |
| system.prop_table_cleaner.algorithm | | V2 |
| system.propval.uniquenessCheck.enabled | Dissallow Attribute Service Entries with "Serializable" objects in key Segments. Please, see MNT-11895 for details. | true |
| system.quickshare.email.from.default | | noreply@alfresco.com |
| system.quickshare.enabled | Enable QuickShare - if false then the QuickShare-specific REST APIs will return 403 Forbidden | true |
| system.quickshare.expiry_date.enforce.minimum.period | By default the difference between the quick share expiry date and the current time must be at least 1 day (24 hours). However, this can be changed to at least 1 hour or 1 minute for testing purposes. For example, setting the value to MINUTES, means the service will calculate the difference between NOW and the given expiry date in terms of minutes and checks for the difference to be greater than 1 minute. DAYS | HOURS | MINUTES | DAYS |
| system.readpermissions.bulkfetchsize | Property to control read permission evaluation for acegi | 1000 |
| system.readpermissions.optimise | Property to control read permission evaluation for acegi | true |
| system.remote_credentials_container.childname | Folder for storing shared remote credentials | sys:remote_credentials |
| system.remove-jbpm-tables-from-db.ignored | Property to enable removal of all JBPM related data from the database. The tables are not removed from the databasen unless explicitly requested by setting this property to false. See: classpath:alfresco/dbscripts/upgrade/5.2/${db.script.dialect}/remove-jbpm-tables-from-db.sql | true |
| system.reset-password.endTimer | Reset password workflow will expire in an hour | PT1H |
| system.reset-password.sendEmailAsynchronously | | true |
| system.serverMode | The server mode. Set value in alfresco-global.properties (UNKNOWN, TEST, BACKUP, PRODUCTION) | UNKNOWN |
| system.store | System Configuration | system://system |
| system.syncset_definition_container.childname | Folder for storing syncset definitions | sys:syncset_definitions |
| system.system_container.childname | Folders for storing people | sys:system |
| system.thumbnail.definition.default.maxPages | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.definition.default.maxSourceSizeKBytes | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.definition.default.pageLimit | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | 1 |
| system.thumbnail.definition.default.readLimitKBytes | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.definition.default.readLimitTimeMs | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.definition.default.timeoutMs | Default thumbnail limits. When creating thumbnails, only use the first pageLimit pages | -1 |
| system.thumbnail.generate | Thumbnail Service | true |
| system.thumbnail.mimetype.maxSourceSizeKBytes.docx | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.odp | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.ods | Max mimetype sizes to create thumbnail icons |-1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.odt | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.pdf | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.pptx | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.txt | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.mimetype.maxSourceSizeKBytes.xlsx | Max mimetype sizes to create thumbnail icons | -1 |
| system.thumbnail.quietPeriod | Configuration for handling of failing thumbnails | 604800 |
| system.thumbnail.quietPeriodRetriesEnabled | Configuration for handling of failing thumbnails | true |
| system.thumbnail.redeployStaticDefsOnStartup | Configuration for handling of failing thumbnails | true |
| system.thumbnail.retryCount | Configuration for handling of failing thumbnails | 2 |
| system.thumbnail.retryPeriod | Configuration for handling of failing thumbnails. See NodeEligibleForRethumbnailingEvaluator's javadoc for details. Retry periods limit the frequency with which the repository will attempt to create Share thumbnails for content nodes which have previously failed in their thumbnail attempts. These periods are in seconds. `604800s = 60s * 60m * 24h * 7d = 1 week` | 60 |
| system.upgradePasswordHash.jobBatchSize | Upgrade Password Hash Job | 100 |
| system.upgradePasswordHash.jobCronExpression | Upgrade Password Hash Job | `* * * * * ? 2099` |
| system.upgradePasswordHash.jobQueryRange | Upgrade Password Hash Job | 10000 |
| system.upgradePasswordHash.jobThreadCount | Upgrade Password Hash Job | 4 |
| system.usages.clearBatchSize | ECM content usages/quotas | 0 |
| system.usages.enabled | ECM content usages/quotas | false |
| system.usages.updateBatchSize | ECM content usages/quotas | 50 |
| system.webdav.activities.enabled | | false |
| system.webdav.renameShufflePattern | File name patterns that trigger rename shuffle detection. Pattern is used by move - tested against full path after it has been lower cased. | `(.*/\..*)|(.*[a-f0-9]{8}+$)|(.*\.tmp$)|(.*atmp[0-9]+$)|(.*\.wbk$)|(.*\.bak$)|(.*\~$)|(.*backup.*\.do[ct]{1}[x]?[m]?$)|(.*\.sb\-\w{8}\-\w{6}$)` |
| system.webdav.rootPath | WebDAV root path | ${protocols.rootPath} |
| system.webdav.servlet.enabled | WebDAV initialization properties | true |
| system.webdav.storeName | WebDAV store name | ${protocols.storeName} |
| system.webdav.url.path.prefix | system.webdav.url.path.prefix  | |
| system.workflow.comment.property.max.length | | 4000 |
| system.workflow.deployWorkflowsInTenant | etermines if the workflows that are deployed to the activiti engine should be deployed in the tenant-context of the thread IF the tenant-service is enabled. If set to false, all workflows deployed will be shared among tenants. Recommended setting is true unless there is a good reason to not allow deploy tenant-specific worklfows when a MT-environment is set up. | true |
| system.workflow.engine.activiti.definitions.visible | Determines if Activiti definitions are visible | true |
| system.workflow.engine.activiti.enabled | Determines if the Activiti engine is enabled | true |
| system.workflow.engine.activiti.idblocksize | | 100 |
| system.workflow.engine.activiti.retentionHistoricProcessInstance | Determines if historic process instance are retained in case of canceling a process instance. | false |
| system.workflow.engine.activiti.taskvariableslimit | | 20000 |
| system.workflow.jbpm.comment.property.max.length | | -1 |
| system.workflow.maxAuthoritiesForPooledTasks | he maximum number of groups to check for pooled tasks. For performance reasons, this is limited to 500 by default. | 500 |
| system.workflow.maxGroupReviewers | The maximum number of reviewers for "Group Review and Approve" workflow. Use '0' for unlimited. | 0 |
| system.workflow.maxPooledTasks | The maximum number of pooled tasks to return in a query. It may be necessary to limit this depending on UI limitations. | -1 |
| system.workflow_container.childname | Folders for storing workflow related info | sys:workflow |
| system.zones_container.childname | Folders for storing people | sys:zones |
| ticket.cleanup.cronExpression | | `0 0 * * * ?` |
| tika.startupRetryPeriodSeconds | When the legacy tika .url is set, this value indicates the amount of time to wait after a connection failure before retrying the connection to allow a docker container to (re)start. | 60 |
| tika.url | Legacy tika url to T-Engines to service transform requests via http. Disabled by default. | |
| transferservice.receiver.enabled | Transfer Service | false |
| transferservice.receiver.lockRefreshTime | How long to wait in mS before refreshing a transfer lock - detects shutdown servers. Default 1 minute. | 60000 |
| transferservice.receiver.lockRetryCount | How many times to attempt retry the transfer lock | 3 |
| transferservice.receiver.lockRetryWait | How long to wait, in mS, before retrying the transfer lock | 100 |
| transferservice.receiver.lockTimeOut | How long to wait, in mS, since the last contact with from the client before timing out a transfer. Needs to be long enough to cope with network delays and "thinking time" for both source and destination. Default 5 minutes. | 300000 |
| transferservice.receiver.stagingDir | Transfer Service | ${java.io.tmpdir}/alfresco-transfer-staging |
| transform.misc.startupRetryPeriodSeconds | When the legacy misc transformer .url is set, this value indicates the amount of time to wait after a connection failure before retrying the connection to allow a docker container to (re)start. | 60 |
| transform.misc.url | Legacy misc transformer url to T-Engines to service transform requests via http. Disabled by default. | |
| transform.service.cronExpression | Schedule for reading local transform config, so that T-Engines and local pipeline config is dynamically picked up, or reintegrated after an outage. Initially checks every 10 seconds and then switches to every hour after the configuration is read successfully. If there is a error later reading the config, the checks return to every 10 seconds. | `6 30 0/1 * * ?` |
| transform.service.enabled | Determines whether the transform service is enabled | false |
| transform.service.initialAndOnError.cronExpression | | `0/10 * * * * ?` |
| transform.service.reply.endpoint | | |
| transform.service.reply.endpoint.prefix | | org.alfresco.transform |
| transform.service.reply.endpoint.suffix | | t-reply |
| transform.service.request.endpoint | | jms:org.alfresco.transform.t-request.acs?jmsMessageType=Text |
| transform.service.url | | |
| transformer.Archive.includeContents | When transforming archive files (.zip etc) into text representations (such as for full text indexing), should the files within the archive be processed too? If enabled, transformation takes longer, but searches of the files find more. | false |
| transformer.strict.mimetype.check | Check that the declared mimetype (of the Node) is the same as the derived mimetype of the content (via Tika) before a transformation takes place. Only files in the repository (not intermediate files in a transformer pipeline) are checked. This property provides a trade off between a security check and a relatively expensive (Tika) operation. There are a few issues with the Tika mimetype detection. So that transformations still take place where the detected mimetype is not the same as the declared mimetype, another property (transformer.strict.mimetype.check.whitelist.mimetypes) contains pairs of declared and detected mimetypes that should be allowed. This parameter value is a sequence of ; separated pairs. The declared and derived mimetypes are also ; separated. | true |
| transformer.strict.mimetype.check.whitelist.mimetypes | A white list of declared and detected mimetypes, that don't match, but should still be transformed. | application/eps;application/postscript;application/illustrator;application/pdf;application/x-tar;application/x-gtar;application/acp;application/zip;application/vnd.stardivision.math;application/x-tika-msoffice |
| trashcan-cleaner.cron | | `* * * * * ? 2099` |
| trashcan-cleaner.deleteBatchCount | | 1000 |
| trashcan-cleaner.keepPeriod | | P28D |
| trashcan.MaxSize | Max size of view trashcan files | 1000 |
| trialUid | | |
| trialUidPattern | | id\d+ |
| urlshortening.bitly.api.key | URL Shortening Properties | R_ca15c6c89e9b25ccd170bafd209a0d4f |
| urlshortening.bitly.url.length | URL Shortening Properties | 20 |
| urlshortening.bitly.username | URL Shortening Properties | brianalfresco |
| user.name.caseSensitive | Are user names case sensitive? | false |
| version.schema | Schema number | 14001 |
| version.store.deprecated.lightWeightVersionStore | ADM VersionStore Configuration | workspace://lightWeightVersionStore |
| version.store.enableAutoVersionOnUpdateProps | ADM VersionStore Configuration | false |
| version.store.enableAutoVersioning | ADM VersionStore Configuration | true |
| version.store.initialVersion | ADM VersionStore Configuration | true |
| version.store.version2Store | ADM VersionStore Configuration | workspace://version2Store |
| version.store.versionComparatorClass | Optional `Comparator<Version>` class name to sort versions. Set to: org.alfresco.repo.version.common.VersionLabelComparator. If upgrading from a version that used unordered sequences in a cluster. | |
| webscripts.encryptTempFiles | Webscripts config | false |
| webscripts.memoryThreshold | Webscripts config (4mb) | 4194304 |
| webscripts.setMaxContentSize | Webscripts config (4gb) | 5368709120 |
| webscripts.tempDirectoryName | Webscripts config | Alfresco-WebScripts |
| webscripts.transaction.preserveHeadersPattern | | Access-Control-.* |
| xforms.formatCaption | Format caption extracted from the XML Schema. | true |
