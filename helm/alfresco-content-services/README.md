---
title: alfresco-content-services
parent: Charts
grand_parent: Helm
---

# alfresco-content-services

![Version: 9.3.0](https://img.shields.io/badge/Version-9.3.0-informational?style=flat-square) ![AppVersion: 25.1.1](https://img.shields.io/badge/AppVersion-25.1.1-informational?style=flat-square)

A Helm chart for deploying Alfresco Content Services

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.6.2 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-control-center(alfresco-adf-app) | 0.2.2 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-digital-workspace(alfresco-adf-app) | 0.2.2 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-ai-transformer | 3.0.3 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-audit-storage | 0.3.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 4.0.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-knowledge-retrieval(alfresco-connector-hxi) | 0.1.4 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-connector-ms365 | 3.0.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-connector-msteams | 2.0.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-repository | 0.9.4 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-search-enterprise | 4.5.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-search(alfresco-search-service) | 5.0.3 |
| https://alfresco.github.io/alfresco-helm-charts/ | share(alfresco-share) | 1.3.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-sync-service | 7.1.2 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-transform-service | 2.1.6 |
| oci://registry-1.docker.io/bitnamicharts | elasticsearch | 21.4.1 |
| oci://registry-1.docker.io/bitnamicharts | postgresql-sync(postgresql) | 12.8.5 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.8.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.adminUser.existingSecretName | string | `"acs-alfresco-cs-brokersecret"` |  |
| activemq.adminUser.password | string | `"admin"` | Default password for the embedded broker admin user |
| activemq.adminUser.user | string | `"admin"` | Default username for the embedded broker admin user |
| activemq.enabled | bool | `true` |  |
| activemq.image.repository | string | `"quay.io/alfresco/alfresco-activemq"` |  |
| activemq.image.tag | string | `"5.18.7-jre17-rockylinux8"` |  |
| activemq.nameOverride | string | `"activemq"` |  |
| alfresco-ai-transformer.enabled | bool | `false` | toggle deploying Alfresco ai transformer for more details about configuration check https://github.com/Alfresco/alfresco-helm-charts/tree/main/charts/alfresco-ai-transformer |
| alfresco-ai-transformer.fullnameOverride | string | `"alfresco-intelligence-service"` | Enforce static resource naming in AIS so the ATS trouter can be given the URL of the service |
| alfresco-ai-transformer.image.repository | string | `"quay.io/alfresco/alfresco-ai-docker-engine"` |  |
| alfresco-ai-transformer.image.tag | string | `"3.1.9"` |  |
| alfresco-ai-transformer.messageBroker.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which holds the message broker URL |
| alfresco-ai-transformer.messageBroker.existingSecret.name | string | `"acs-alfresco-cs-brokersecret"` | Name of the configmap which holds the message broker credentials |
| alfresco-ai-transformer.sfs.existingConfigMap.keys.url | string | `"SFS_URL"` | Name of the key within the configmap which holds the sfs url |
| alfresco-ai-transformer.sfs.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which holds the ATS shared filestore URL |
| alfresco-audit-storage.enabled | bool | `true` |  |
| alfresco-audit-storage.image.repository | string | `"quay.io/alfresco/alfresco-audit-storage"` |  |
| alfresco-audit-storage.image.tag | string | `"1.1.0"` |  |
| alfresco-audit-storage.index.existingConfigMap.keys.url | string | `"AUDIT_ELASTICSEARCH_URL"` |  |
| alfresco-audit-storage.index.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-audit-storage.index.existingSecret.keys.password | string | `"AUDIT_ELASTICSEARCH_PASSWORD"` |  |
| alfresco-audit-storage.index.existingSecret.keys.username | string | `"AUDIT_ELASTICSEARCH_USERNAME"` |  |
| alfresco-audit-storage.index.existingSecret.name | string | `"alfresco-aas-elasticsearch-secret"` |  |
| alfresco-audit-storage.messageBroker.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which holds the message broker URL |
| alfresco-audit-storage.messageBroker.existingSecret.name | string | `"acs-alfresco-cs-brokersecret"` | Name of the configmap which holds the message broker credentials |
| alfresco-audit-storage.nameOverride | string | `"alfresco-audit-storage"` |  |
| alfresco-connector-ms365.enabled | bool | `false` | Enable/Disable Alfresco Content Connector for Microsoft 365 |
| alfresco-connector-ms365.image.repository | string | `"quay.io/alfresco/alfresco-ooi-service"` |  |
| alfresco-connector-ms365.image.tag | string | `"2.0.6"` |  |
| alfresco-connector-ms365.repository.existingConfigMap.keys.host | string | `"repo_svc_name"` | Name of the key in the configmap which points to the repository service hostname |
| alfresco-connector-ms365.repository.existingConfigMap.keys.port | string | `"repo_svc_port"` | Name of the key in the configmap which points to the repository service port |
| alfresco-connector-ms365.repository.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which hold the repository connection details |
| alfresco-connector-msteams.enabled | bool | `false` | Enable/Disable Alfresco Content Connector for Microsoft Teams |
| alfresco-connector-msteams.image.repository | string | `"quay.io/alfresco/alfresco-ms-teams-service"` |  |
| alfresco-connector-msteams.image.tag | string | `"2.0.6"` |  |
| alfresco-control-center.enabled | bool | `true` |  |
| alfresco-control-center.env.APP_CONFIG_AUTH_TYPE | string | `"BASIC"` |  |
| alfresco-control-center.env.APP_CONFIG_PROVIDER | string | `"ECM"` |  |
| alfresco-control-center.env.BASE_PATH | string | `"/control-center"` |  |
| alfresco-control-center.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-control-center.image.repository | string | `"quay.io/alfresco/alfresco-control-center"` |  |
| alfresco-control-center.image.tag | string | `"9.4.0"` |  |
| alfresco-control-center.ingress.hosts[0].paths[0].path | string | `"/control-center"` |  |
| alfresco-control-center.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| alfresco-control-center.ingress.tls | list | `[]` |  |
| alfresco-control-center.nameOverride | string | `"alfresco-cc"` |  |
| alfresco-digital-workspace.enabled | bool | `true` |  |
| alfresco-digital-workspace.env.APP_CONFIG_AUTH_TYPE | string | `"BASIC"` |  |
| alfresco-digital-workspace.env.APP_CONFIG_PROVIDER | string | `"ECM"` |  |
| alfresco-digital-workspace.env.BASE_PATH | string | `"/workspace"` |  |
| alfresco-digital-workspace.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-digital-workspace.image.repository | string | `"quay.io/alfresco/alfresco-digital-workspace"` |  |
| alfresco-digital-workspace.image.tag | string | `"6.0.0"` |  |
| alfresco-digital-workspace.ingress.hosts[0].paths[0].path | string | `"/workspace"` |  |
| alfresco-digital-workspace.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| alfresco-digital-workspace.ingress.tls | list | `[]` |  |
| alfresco-digital-workspace.nameOverride | string | `"alfresco-dw"` |  |
| alfresco-knowledge-retrieval.ats.existingConfigMap.keys.sfsUrl | string | `"SFS_BASE_URL"` | Key within the configmap holding the URL of the alfresco shared filestore |
| alfresco-knowledge-retrieval.ats.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which holds the ATS shared filestore URL |
| alfresco-knowledge-retrieval.bulkIngester.enabled | bool | `false` |  |
| alfresco-knowledge-retrieval.enabled | bool | `false` |  |
| alfresco-knowledge-retrieval.messageBroker.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which holds the message broker URL |
| alfresco-knowledge-retrieval.messageBroker.existingSecret.name | string | `"acs-alfresco-cs-brokersecret"` | Name of the configmap which holds the message broker credentials |
| alfresco-knowledge-retrieval.predictionApplier.enabled | bool | `false` |  |
| alfresco-knowledge-retrieval.repository.authType | string | `"basic"` |  |
| alfresco-repository.autoscaling.kedaDisableIdle | bool | `true` |  |
| alfresco-repository.configuration.db.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-repository.configuration.db.existingSecret.name | string | `"alfresco-cs-database"` |  |
| alfresco-repository.configuration.messageBroker.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-repository.configuration.messageBroker.existingSecret.name | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-repository.configuration.repository.existingConfigMap | string | `"repository"` |  |
| alfresco-repository.configuration.repository.existingSecrets[0].key | string | `"license.lic"` |  |
| alfresco-repository.configuration.repository.existingSecrets[0].name | string | `"repository-secrets"` |  |
| alfresco-repository.configuration.repository.existingSecrets[0].purpose | string | `"acs-license"` |  |
| alfresco-repository.configuration.repository.existingSecrets[1].key | string | `"MAIL_PASSWORD"` |  |
| alfresco-repository.configuration.repository.existingSecrets[1].name | string | `"outbound-email"` |  |
| alfresco-repository.configuration.repository.existingSecrets[1].purpose | string | `"property:mail.password"` |  |
| alfresco-repository.configuration.search.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-repository.configuration.search.existingSecret.keys.password | string | `"SEARCH_PASSWORD"` |  |
| alfresco-repository.configuration.search.existingSecret.keys.username | string | `"SEARCH_USERNAME"` |  |
| alfresco-repository.configuration.search.existingSecret.name | string | `"alfresco-search-secret"` |  |
| alfresco-repository.configuration.search.flavor | string | `"elasticsearch"` |  |
| alfresco-repository.image.repository | string | `"quay.io/alfresco/alfresco-content-repository"` |  |
| alfresco-repository.image.tag | string | `"25.1.1"` |  |
| alfresco-repository.nameOverride | string | `"alfresco-repository"` |  |
| alfresco-repository.persistence.accessModes | list | `["ReadWriteMany"]` | Specify a storageClass for dynamic provisioning |
| alfresco-repository.persistence.baseSize | string | `"20Gi"` |  |
| alfresco-repository.persistence.enabled | bool | `true` | Persist repository data |
| alfresco-search-enterprise.ats.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search-enterprise.enabled | bool | `true` |  |
| alfresco-search-enterprise.liveIndexing.content.image.tag | string | `"5.1.0"` |  |
| alfresco-search-enterprise.liveIndexing.mediation.image.tag | string | `"5.1.0"` |  |
| alfresco-search-enterprise.liveIndexing.metadata.image.tag | string | `"5.1.0"` |  |
| alfresco-search-enterprise.liveIndexing.path.image.tag | string | `"5.1.0"` |  |
| alfresco-search-enterprise.messageBroker.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search-enterprise.messageBroker.existingSecret.name | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-search-enterprise.nameOverride | string | `"alfresco-search-enterprise"` |  |
| alfresco-search-enterprise.reindexing.db.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search-enterprise.reindexing.db.existingSecret.name | string | `"alfresco-cs-database"` |  |
| alfresco-search-enterprise.reindexing.enabled | bool | `true` |  |
| alfresco-search-enterprise.reindexing.image.tag | string | `"5.1.0"` |  |
| alfresco-search-enterprise.reindexing.repository.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search-enterprise.search.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search-enterprise.search.existingSecret.name | string | `"alfresco-search-secret"` |  |
| alfresco-search.alfresco-insight-zeppelin.enabled | bool | `false` |  |
| alfresco-search.enabled | bool | `false` |  |
| alfresco-search.external.host | string | `nil` | Host dns/ip of the external solr6 instance. |
| alfresco-search.external.port | string | `nil` | Port of the external solr6 instance. |
| alfresco-search.ingress.basicAuth | string | `nil` | Default solr basic auth user/password: admin / admin You can create your own with htpasswd utility & encode it with base64. Example: `echo -n "$(htpasswd -nbm admin admin)" | base64 | tr -d '\n'` basicAuth: YWRtaW46JGFwcjEkVVJqb29uS00kSEMuS1EwVkRScFpwSHB2a3JwTDd1Lg== |
| alfresco-search.ingress.enabled | bool | `false` | Alfresco Search services endpoint ('/solr') |
| alfresco-search.ingress.tls | list | `[]` |  |
| alfresco-search.insightEngineImage.repository | string | `"quay.io/alfresco/insight-engine"` |  |
| alfresco-search.insightEngineImage.tag | string | `"2.0.15"` |  |
| alfresco-search.nameOverride | string | `"alfresco-search"` |  |
| alfresco-search.repository.existingConfigMap.keys.host | string | `"repo_svc_name"` |  |
| alfresco-search.repository.existingConfigMap.keys.port | string | `"repo_svc_port"` |  |
| alfresco-search.repository.existingConfigMap.keys.securecomms | string | `"SEARCH_SECURECOMMS"` |  |
| alfresco-search.repository.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search.repository.existingSecret.keys.sharedSecret | string | `"SOLR_SECRET"` |  |
| alfresco-search.repository.existingSecret.name | string | `"alfresco-search-secret"` |  |
| alfresco-search.searchServicesImage.repository | string | `"quay.io/alfresco/search-services"` |  |
| alfresco-search.searchServicesImage.tag | string | `"2.0.15"` |  |
| alfresco-sync-service.database.existingConfigMap.keys.url | string | `"SYNC_DATABASE_URL"` |  |
| alfresco-sync-service.database.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-sync-service.database.existingSecret.name | string | `"alfresco-cs-sync"` |  |
| alfresco-sync-service.enabled | bool | `true` | Toggle deployment of Alfresco Sync Service (Desktop-Sync) Check [Alfresco Sync Service Documentation](https://github.com/Alfresco/alfresco-helm-charts/tree/main/charts/alfresco-sync-service) |
| alfresco-sync-service.image.tag | string | `"5.2.0"` |  |
| alfresco-sync-service.messageBroker.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-sync-service.messageBroker.existingSecret.name | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-sync-service.replicaCount | int | `1` |  |
| alfresco-sync-service.repository.existingConfigMap.keys.host | string | `"repo_svc_name"` |  |
| alfresco-sync-service.repository.existingConfigMap.keys.port | string | `"repo_svc_port"` |  |
| alfresco-sync-service.repository.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-transform-service.enabled | bool | `true` |  |
| alfresco-transform-service.filestore.enabled | bool | `true` | Declares the alfresco-shared-file-store used by the content repository and transform service |
| alfresco-transform-service.filestore.image.repository | string | `"quay.io/alfresco/alfresco-shared-file-store"` |  |
| alfresco-transform-service.filestore.image.tag | string | `"4.1.7"` |  |
| alfresco-transform-service.filestore.persistence.data.mountPath | string | `"/tmp/Alfresco"` |  |
| alfresco-transform-service.filestore.persistence.data.subPath | string | `"alfresco-content-services/filestore-data"` |  |
| alfresco-transform-service.filestore.persistence.enabled | bool | `true` | Persist filestore data |
| alfresco-transform-service.filestore.replicaCount | int | `1` | To have more than 1 replica persistence should support `ReadWriteMany` access mode |
| alfresco-transform-service.filestore.strategy.type | string | `"Recreate"` | Strategy must be set to Recreate when persistence supports only `ReadWriteOnce` access mode. If `ReadWriteMany` is supported, then it can be set to RollingUpdate. |
| alfresco-transform-service.imagemagick.enabled | bool | `true` | Declares the alfresco-imagemagick service used by the content repository to transform image files |
| alfresco-transform-service.imagemagick.image.repository | string | `"quay.io/alfresco/alfresco-imagemagick"` |  |
| alfresco-transform-service.imagemagick.image.tag | string | `"5.1.7"` |  |
| alfresco-transform-service.libreoffice.enabled | bool | `true` | Declares the alfresco-libreoffice service used by the content repository to transform office files |
| alfresco-transform-service.libreoffice.image.repository | string | `"quay.io/alfresco/alfresco-libreoffice"` |  |
| alfresco-transform-service.libreoffice.image.tag | string | `"5.1.7"` |  |
| alfresco-transform-service.messageBroker.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which holds the ATS shared filestore URL |
| alfresco-transform-service.messageBroker.existingSecret.name | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-transform-service.nameOverride | string | `"alfresco-transform-service"` |  |
| alfresco-transform-service.pdfrenderer.enabled | bool | `true` | Declares the alfresco-pdf-renderer service used by the content repository to transform pdf files |
| alfresco-transform-service.pdfrenderer.image.repository | string | `"quay.io/alfresco/alfresco-pdf-renderer"` |  |
| alfresco-transform-service.pdfrenderer.image.tag | string | `"5.1.7"` |  |
| alfresco-transform-service.tika.enabled | bool | `true` | Declares the alfresco-tika service used by the content repository to transform office files |
| alfresco-transform-service.tika.image.repository | string | `"quay.io/alfresco/alfresco-tika"` |  |
| alfresco-transform-service.tika.image.tag | string | `"5.1.7"` |  |
| alfresco-transform-service.transformmisc.enabled | bool | `true` | Declares the alfresco-tika service used by the content repository to transform office files |
| alfresco-transform-service.transformmisc.image.repository | string | `"quay.io/alfresco/alfresco-transform-misc"` |  |
| alfresco-transform-service.transformmisc.image.tag | string | `"5.1.7"` |  |
| alfresco-transform-service.transformrouter.enabled | bool | `true` | Declares the alfresco-transform-router service used by the content repository to route transformation requests |
| alfresco-transform-service.transformrouter.image.repository | string | `"quay.io/alfresco/alfresco-transform-router"` |  |
| alfresco-transform-service.transformrouter.image.tag | string | `"4.1.7"` |  |
| alfresco-transform-service.transformrouter.livenessProbe.path | string | `"/transform/config"` | Overrride liveness probe endpoint to work around https://alfresco.atlassian.net/browse/ACS-7269 |
| alfresco-transform-service.transformrouter.replicaCount | int | `2` |  |
| config.repository.additionalGlobalProperties | object | `{}` |  |
| config.repository.configMapName | string | `"repository"` |  |
| database.configMapName | string | `"alfresco-infrastructure"` | Name of the secret managed by this chart |
| database.driver | string | `nil` | Postgresql jdbc driver name ex: org.postgresql.Driver. It should be available in the container image. |
| database.existingSecretName | string | `nil` | An existing secret that contains DATABASE_USERNAME and DATABASE_PASSWORD keys. When using embedded postgres you need to also set `postgresql.existingSecret`. |
| database.external | bool | `false` | Enable using an external database for Alfresco Content Services. Must disable `postgresql.enabled` when true. |
| database.password | string | `nil` | External Postgresql database password |
| database.secretName | string | `"alfresco-cs-database"` | Name of the secret managed by this chart |
| database.sync.configMapName | string | `"alfresco-infrastructure"` | Name of the secret managed by this chart |
| database.sync.driver | string | `nil` | Postgresql jdbc driver name ex: org.postgresql.Driver. It should be available in the container image. |
| database.sync.existingSecretName | string | `nil` | An existing secret that contains DATABASE_USERNAME and DATABASE_PASSWORD keys. |
| database.sync.password | string | `nil` | External Postgresql database password |
| database.sync.secretName | string | `"alfresco-cs-sync"` | Name of the secret managed by this chart |
| database.sync.url | string | `nil` | External Postgresql jdbc url ex: `jdbc:postgresql://oldfashioned-mule-postgresql-acs:5432/alfresco` |
| database.sync.user | string | `nil` | External Postgresql database user |
| database.url | string | `nil` | External Postgresql jdbc url ex: `jdbc:postgresql://oldfashioned-mule-postgresql-acs:5432/alfresco` |
| database.user | string | `nil` | External Postgresql database user |
| dtas.additionalArgs[0] | string | `"--tb=short"` |  |
| dtas.config.assertions.aas.audit_host | string | `"{{ include \"alfresco-content-services.audit.serviceName\" $ }}"` |  |
| dtas.config.assertions.aas.elasticsearch_host | string | `"{{ include \"alfresco-content-services.audit.elasticsearchUrl\" $ }}"` |  |
| dtas.config.assertions.acs.edition | string | `"Enterprise"` |  |
| dtas.config.assertions.acs.identity | bool | `false` |  |
| dtas.config.assertions.acs.modules[0].id | string | `"org_alfresco_device_sync_repo"` |  |
| dtas.config.assertions.acs.modules[0].installed | bool | `true` |  |
| dtas.config.assertions.acs.modules[0].version | string | `"5.2.0"` |  |
| dtas.config.assertions.acs.modules[1].id | string | `"org.alfresco.integrations.google.docs"` |  |
| dtas.config.assertions.acs.modules[1].installed | bool | `true` |  |
| dtas.config.assertions.acs.modules[1].version | string | `"4.1.0"` |  |
| dtas.config.assertions.acs.modules[2].id | string | `"alfresco-aos-module"` |  |
| dtas.config.assertions.acs.modules[2].installed | bool | `true` |  |
| dtas.config.assertions.acs.modules[2].version | string | `"3.2.0"` |  |
| dtas.config.assertions.acs.version | string | `"25.1.1"` |  |
| dtas.config.assertions.adw.base_path | string | `"/workspace"` |  |
| dtas.config.config.host | string | `"http://ingress-nginx-controller.ingress-nginx.svc.cluster.local"` |  |
| dtas.config.config.password | string | `"admin"` |  |
| dtas.config.config.username | string | `"admin"` |  |
| dtas.enabled | bool | `false` | Enables the deployment test suite which can run via `helm test` (currently available for Enterprise only) |
| dtas.image.pullPolicy | string | `"IfNotPresent"` |  |
| dtas.image.repository | string | `"quay.io/alfresco/alfresco-deployment-test-automation-scripts"` |  |
| dtas.image.tag | string | `"v1.7.2"` |  |
| elasticsearch.coordinating.replicaCount | int | `0` |  |
| elasticsearch.data.replicaCount | int | `0` |  |
| elasticsearch.enabled | bool | `true` | Enables the embedded elasticsearch cluster |
| elasticsearch.image.tag | string | `"8.17.3"` |  |
| elasticsearch.ingest.replicaCount | int | `0` |  |
| elasticsearch.ingress.enabled | bool | `false` | toggle deploying elasticsearch-audit ingress for more details about configuration check https://github.com/bitnami/charts/blob/main/bitnami/elasticsearch/values.yaml#L366 |
| elasticsearch.kibana.configuration.server.basePath | string | `"/kibana"` |  |
| elasticsearch.kibana.configuration.server.publicBaseUrl | string | `"http://localhost/kibana"` | This setting defines the base URL for accessing Kibana in your deployment.    - For **local deployments**: Use "http://localhost/kibana" (default).    - For **production or remote deployments**: Replace `localhost` with the fully qualified domain name (FQDN) or IP address      where Kibana is accessible. Example: "http://kibana.mycompany.com" or "http://192.168.1.100/kibana".    - Ensure this URL is accessible by users or other services that need to interact with Kibana. |
| elasticsearch.kibana.configuration.server.rewriteBasePath | bool | `true` |  |
| elasticsearch.kibana.image.tag | string | `"7.17.26"` |  |
| elasticsearch.kibana.ingress.enabled | bool | `true` |  |
| elasticsearch.kibana.ingress.hostname | string | `"*"` |  |
| elasticsearch.kibana.ingress.ingressClassName | string | `"nginx"` |  |
| elasticsearch.kibana.ingress.path | string | `"/kibana"` |  |
| elasticsearch.master.masterOnly | bool | `false` |  |
| elasticsearch.master.replicaCount | int | `1` |  |
| global.alfrescoRegistryPullSecrets | string | `nil` | If a private image registry a secret can be defined and passed to kubernetes, see: https://github.com/Alfresco/acs-deployment/blob/a924ad6670911f64f1bba680682d266dd4ea27fb/docs/helm/eks-deployment.md#docker-registry-secret |
| global.auditIndex.existingSecretName | string | `nil` | Name of an existing secret that contains AUDIT_ELASTICSEARCH_USERNAME and AUDIT_ELASTICSEARCH_PASSWORD keys. |
| global.auditIndex.password | string | `nil` | set password for authentication against the external elasticsearch service for audit indexing |
| global.auditIndex.secretName | string | `"alfresco-aas-elasticsearch-secret"` | Name of the secret managed by this chart |
| global.auditIndex.url | string | `nil` | set this URL if you have an external elasticsearch for audit indexing |
| global.auditIndex.username | string | `nil` | set usernname for authentication against the external elasticsearch service for audit indexing |
| global.kibanaEnabled | bool | `false` | Enable/Disable Kibana for the embedded elasticsearch cluster |
| global.known_urls | list | `["https://localhost","http://localhost"]` | list of trusted URLs. URLs a re used to configure Cross-origin protections Also the first entry is considered the main hosting domain of the platform. |
| global.mail | object | `{"host":null,"password":null,"port":587,"protocol":"smtp","smtp":{"auth":true,"starttls":{"enable":true}},"smtps":{"auth":true},"username":"anonymous"}` | For a full information of configuring the outbound email system, please search this topic in https://support.hyland.com/r/alfresco |
| global.mail.host | string | `nil` | SMTP server to use for the system to send outgoing email |
| global.mail.port | int | `587` | SMTP server port |
| global.mail.protocol | string | `"smtp"` | SMTP protocol to use. Either smtp or smtps |
| global.search.existingSecretName | string | `nil` | Name of an existing secret that contains SOLR_SECRET key when flavour is solr6 or SEARCH_USERNAME and SEARCH_PASSWORD keys. |
| global.search.flavor | string | `nil` | set the type of search service used externally (solr6 or elasticsearch) |
| global.search.password | string | `nil` | Set password for authentication against the external elasticsearch service |
| global.search.secretName | string | `"alfresco-search-secret"` | Name of the secret managed by this chart |
| global.search.securecomms | string | `"secret"` | set the security level used with the external search service (secret, none or https) |
| global.search.sharedSecret | string | `nil` | Mandatory secret to provide when using Solr search with 'secret' security level |
| global.search.url | string | `nil` | set this URL if you have an external search service |
| global.search.username | string | `nil` | Set username for authentication against the external elasticsearch service |
| global.strategy.rollingUpdate.maxSurge | int | `1` |  |
| global.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| infrastructure.configMapName | string | `"alfresco-infrastructure"` |  |
| keda.components | list | `[]` | The list of components that will be scaled by KEDA (chart names) |
| messageBroker.brokerName | string | `nil` | name of the message broker as set in the Broker configuration |
| messageBroker.existingSecretName | string | `nil` | Name of an existing secret that contains BROKER_USERNAME and BROKER_PASSWORD keys. and optionally the credentials to the web console (can be the same as broker access). |
| messageBroker.password | string | `nil` | External message broker password |
| messageBroker.restAPITemplate | string | `nil` | the template used internally by KEDA ActiveMQ scaler to query the broker queue size the KEDA internal default is: http://{{.ManagementEndpoint}}/api/jolokia/read/org.apache.activemq:type=Broker,brokerName={{.BrokerName}},destinationType=Queue,destinationName={{.DestinationName}}/QueueSize |
| messageBroker.secretName | string | `"acs-alfresco-cs-brokersecret"` | Name of the secret managed by this chart |
| messageBroker.url | string | `nil` | Enable using an external message broker for Alfresco Content Services. Must disable `activemq.enabled`. |
| messageBroker.user | string | `nil` | External message broker user |
| messageBroker.webConsole | string | `nil` | URL of the web console interface for the external message broker Your broker we console interface should respond to URl built using the `restAPITemplate` below where `.ManagementEndpoint` evaluates to the `webConsole`value below. |
| postgresql-sync.auth.database | string | `"syncservice-postgresql"` |  |
| postgresql-sync.auth.enablePostgresUser | bool | `false` |  |
| postgresql-sync.auth.password | string | `"admin"` |  |
| postgresql-sync.auth.username | string | `"alfresco"` |  |
| postgresql-sync.enabled | bool | `true` | Toggle creation of the "in-cluster" test postgresql instance for Alfresco Sync service |
| postgresql-sync.image.tag | string | `"15.5.0"` |  |
| postgresql-sync.nameOverride | string | `"postgresql-sync"` |  |
| postgresql-sync.primary.extendedConfiguration | string | `"max_connections = 150\nshared_buffers = 512MB\neffective_cache_size = 2GB\nwal_level = minimal\nmax_wal_senders = 0\nmax_replication_slots = 0\nlog_min_messages = LOG\n"` |  |
| postgresql-sync.primary.resources.limits.cpu | string | `"4"` |  |
| postgresql-sync.primary.resources.limits.memory | string | `"4Gi"` |  |
| postgresql-sync.primary.resources.requests.cpu | string | `"250m"` |  |
| postgresql-sync.primary.resources.requests.memory | string | `"1Gi"` |  |
| postgresql.auth.database | string | `"alfresco"` |  |
| postgresql.auth.existingSecret | string | `nil` |  |
| postgresql.auth.password | string | `"alfresco"` |  |
| postgresql.auth.username | string | `"alfresco"` |  |
| postgresql.commonAnnotations.application | string | `"alfresco-content-services"` |  |
| postgresql.enabled | bool | `true` | Toggle embedded postgres for Alfresco Content Services repository Check [PostgreSQL Bitnami chart Documentation](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) |
| postgresql.image.pullPolicy | string | `"IfNotPresent"` |  |
| postgresql.image.tag | string | `"16.6.0"` |  |
| postgresql.nameOverride | string | `"postgresql-acs"` |  |
| postgresql.primary.extendedConfiguration | string | `"max_connections = 250\nshared_buffers = 512MB\neffective_cache_size = 2GB\nwal_level = minimal\nmax_wal_senders = 0\nmax_replication_slots = 0\nlog_min_messages = LOG\n"` |  |
| postgresql.primary.persistence.existingClaim | string | `nil` | provide an existing persistent volume claim name to persist SQL data Make sure the root folder has the appropriate permissions/ownership set. |
| postgresql.primary.persistence.storageClass | string | `nil` | set the storageClass to use for dynamic provisioning. setting it to null means "default storageClass". |
| postgresql.primary.persistence.subPath | string | `"alfresco-content-services/database-data"` |  |
| postgresql.primary.resources.limits.cpu | string | `"8"` |  |
| postgresql.primary.resources.limits.memory | string | `"8Gi"` |  |
| postgresql.primary.resources.requests.cpu | string | `"500m"` |  |
| postgresql.primary.resources.requests.memory | string | `"1Gi"` |  |
| prometheus.url | string | `nil` | URL of the prometheus server (must be reachable by KEDA pods) |
| share.enabled | bool | `true` | toggle deploying Alfresco Share UI |
| share.image.repository | string | `"quay.io/alfresco/alfresco-share"` |  |
| share.image.tag | string | `"25.1.1"` |  |
| share.nameOverride | string | `"share"` |  |
| share.repository.existingConfigMap.keys.host | string | `"repo_svc_name"` | Name of the key in the configmap which points to the repository service hostname |
| share.repository.existingConfigMap.keys.port | string | `"repo_svc_port"` | Name of the key in the configmap which points to the repository service port |
| share.repository.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which hold the repository connection details |

Alfresco Content Service will be deployed in a Kubernetes cluster. This cluster
needs a at least 32GB memory to split among below pods:

* 2 x repository
* 1 x share
* 1 x search
* 2 x pdfrenderer
* 2 x imagemagick
* 2 libreoffice
* 2 tika
* 2 misc
* 1 x postgresql
* 1 activemq

> Note: this is the default settings but requirements can be lowered by
dropping the `replicaCount` value to 1 for each service.

Default CPU and memory requirements for each pods are set as low as we think is
reasonable. If you need to tweak the resource allocation you can use the
`resources.limits.cpu` & `resources.limits.memory` for each component of the
platform. Remember that most of them are running in JAVA VM so you might want
to also raise the JVM memory settings (-Xmx) which is possible using pods'
environment variables.
