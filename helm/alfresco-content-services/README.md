# alfresco-content-services

![Version: 7.0.0-M.2](https://img.shields.io/badge/Version-7.0.0--M.2-informational?style=flat-square) ![AppVersion: 23.1.0-M4](https://img.shields.io/badge/AppVersion-23.1.0--M4-informational?style=flat-square)

A Helm chart for deploying Alfresco Content Services

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-control-center(common) | 7.11.0 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-digital-workspace(common) | 7.11.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.3.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-ai-transformer | 0.3.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 3.0.0-alpha.2 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-connector-ms365 | 0.4.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-connector-msteams | 0.2.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-repository | 0.1.0-alpha.18 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-search-enterprise | 3.0.0-alpha.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-search(alfresco-search-service) | 2.0.0-alpha.2 |
| https://alfresco.github.io/alfresco-helm-charts/ | share(alfresco-share) | 0.1.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-sync-service | 4.4.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-transform-service | 0.2.0 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.8.5 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.adminUser.existingSecretName | string | `"acs-alfresco-cs-brokersecret"` |  |
| activemq.adminUser.password | string | `"admin"` | Default password for the embedded broker admin user |
| activemq.adminUser.user | string | `"admin"` | Default username for the embedded broker admin user |
| activemq.enabled | bool | `true` |  |
| activemq.existingSecretName | string | `nil` |  |
| activemq.nameOverride | string | `"activemq"` |  |
| activemq.nodeSelector | object | `{}` | Possibility to choose Node for pod, with a key-value pair label e.g {"kubernetes.io/hostname": multinode-demo-m02} |
| alfresco-ai-transformer.enabled | bool | `false` |  |
| alfresco-ai-transformer.image.repository | string | `"quay.io/alfresco/alfresco-ai-docker-engine"` |  |
| alfresco-ai-transformer.image.tag | string | `"2.1.0-M1"` |  |
| alfresco-ai-transformer.messageBroker.existingSecretName | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-connector-ms365.enabled | bool | `false` | Enable/Disable Alfresco Content Connector for Microsoft 365 |
| alfresco-connector-ms365.image.repository | string | `"quay.io/alfresco/alfresco-ooi-service"` |  |
| alfresco-connector-ms365.image.tag | string | `"2.0.0"` |  |
| alfresco-connector-ms365.repository.existingConfigMap.keys.host | string | `"repo_svc_name"` | Name of the key in the configmap which points to the repository service hostname |
| alfresco-connector-ms365.repository.existingConfigMap.keys.port | string | `"repo_svc_port"` | Name of the key in the configmap which points to the repository service port |
| alfresco-connector-ms365.repository.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which hold the repositoy connection details |
| alfresco-connector-msteams.enabled | bool | `false` | Enable/Disable Alfresco Content Connector for Microsoft Teams |
| alfresco-connector-msteams.image.repository | string | `"quay.io/alfresco/alfresco-ms-teams-service"` |  |
| alfresco-connector-msteams.image.tag | string | `"2.0.0"` |  |
| alfresco-control-center.enabled | bool | `true` |  |
| alfresco-control-center.env.API_URL | string | `"{protocol}//{hostname}{:port}"` |  |
| alfresco-control-center.env.APP_CONFIG_AUTH_TYPE | string | `"BASIC"` |  |
| alfresco-control-center.env.APP_CONFIG_PROVIDER | string | `"ECM"` |  |
| alfresco-control-center.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-control-center.image.repository | string | `"quay.io/alfresco/alfresco-control-center"` |  |
| alfresco-control-center.image.tag | string | `"8.2.0"` |  |
| alfresco-control-center.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| alfresco-control-center.ingress.path | string | `"/control-center"` |  |
| alfresco-control-center.ingress.tls | list | `[]` |  |
| alfresco-control-center.nameOverride | string | `"alfresco-cc"` |  |
| alfresco-control-center.nodeSelector | object | `{}` |  |
| alfresco-control-center.registryPullSecrets[0] | string | `"{{ $.Values.global.alfrescoRegistryPullSecrets }}"` |  |
| alfresco-control-center.resources.limits.cpu | string | `"1"` |  |
| alfresco-control-center.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-control-center.resources.requests.cpu | string | `"0.25"` |  |
| alfresco-control-center.resources.requests.memory | string | `"256Mi"` |  |
| alfresco-control-center.securityContext.capabilities.drop[0] | string | `"NET_RAW"` |  |
| alfresco-control-center.securityContext.capabilities.drop[1] | string | `"ALL"` |  |
| alfresco-control-center.securityContext.runAsNonRoot | bool | `true` |  |
| alfresco-control-center.securityContext.runAsUser | int | `101` |  |
| alfresco-control-center.service.envType | string | `"frontend"` |  |
| alfresco-digital-workspace.enabled | bool | `true` |  |
| alfresco-digital-workspace.env.API_URL | string | `"{protocol}//{hostname}{:port}"` |  |
| alfresco-digital-workspace.env.APP_CONFIG_AUTH_TYPE | string | `"BASIC"` |  |
| alfresco-digital-workspace.env.APP_CONFIG_PROVIDER | string | `"ECM"` |  |
| alfresco-digital-workspace.extraEnv | string | `"{{- if .Values.global.ai.enabled }}\n- name: APP_CONFIG_PLUGIN_AI_SERVICE\n  value: '{{ .Values.global.ai.enabled }}'\n{{- end }}"` |  |
| alfresco-digital-workspace.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-digital-workspace.image.repository | string | `"quay.io/alfresco/alfresco-digital-workspace"` |  |
| alfresco-digital-workspace.image.tag | string | `"4.2.0"` |  |
| alfresco-digital-workspace.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| alfresco-digital-workspace.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| alfresco-digital-workspace.ingress.path | string | `"/workspace"` |  |
| alfresco-digital-workspace.ingress.tls | list | `[]` |  |
| alfresco-digital-workspace.nameOverride | string | `"alfresco-dw"` |  |
| alfresco-digital-workspace.nodeSelector | object | `{}` |  |
| alfresco-digital-workspace.registryPullSecrets[0] | string | `"{{ $.Values.global.alfrescoRegistryPullSecrets }}"` |  |
| alfresco-digital-workspace.resources.limits.cpu | string | `"1"` |  |
| alfresco-digital-workspace.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-digital-workspace.resources.requests.cpu | string | `"0.25"` |  |
| alfresco-digital-workspace.resources.requests.memory | string | `"256Mi"` |  |
| alfresco-digital-workspace.securityContext.capabilities.drop[0] | string | `"NET_RAW"` |  |
| alfresco-digital-workspace.securityContext.capabilities.drop[1] | string | `"ALL"` |  |
| alfresco-digital-workspace.securityContext.runAsNonRoot | bool | `true` |  |
| alfresco-digital-workspace.securityContext.runAsUser | int | `101` |  |
| alfresco-digital-workspace.service.envType | string | `"frontend"` |  |
| alfresco-repository.configuration.db.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-repository.configuration.db.existingSecret.name | string | `"alfresco-cs-database"` |  |
| alfresco-repository.configuration.messageBroker.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-repository.configuration.messageBroker.existingSecret.name | string | `"alfresco-cs-database"` |  |
| alfresco-repository.configuration.repository.existingConfigMap | string | `"repository"` |  |
| alfresco-repository.configuration.repository.existingSecrets[0].key | string | `"license.lic"` |  |
| alfresco-repository.configuration.repository.existingSecrets[0].name | string | `"repository-secrets"` |  |
| alfresco-repository.configuration.repository.existingSecrets[0].purpose | string | `"acs-license"` |  |
| alfresco-repository.configuration.repository.existingSecrets[1].key | string | `"MAIL_PASSWORD"` |  |
| alfresco-repository.configuration.repository.existingSecrets[1].name | string | `"outbound-email"` |  |
| alfresco-repository.configuration.repository.existingSecrets[1].purpose | string | `"property:mail.password"` |  |
| alfresco-repository.configuration.search.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-repository.configuration.search.existingSecret.name | string | `"solr-shared-secret"` |  |
| alfresco-repository.configuration.search.flavor | string | `"solr6"` |  |
| alfresco-repository.image.repository | string | `"quay.io/alfresco/alfresco-content-repository"` |  |
| alfresco-repository.image.tag | string | `"23.1.0-A27"` |  |
| alfresco-repository.nameOverride | string | `"alfresco-repository"` |  |
| alfresco-repository.persistence.accessModes | list | `["ReadWriteMany"]` | Specify a storageClass for dynamic provisioning |
| alfresco-repository.persistence.baseSize | string | `"20Gi"` |  |
| alfresco-repository.persistence.enabled | bool | `true` | Persist repository data |
| alfresco-search-enterprise.ats.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search-enterprise.elasticsearch.enabled | bool | `true` | Enables the embedded elasticsearch cluster |
| alfresco-search-enterprise.enabled | bool | `false` |  |
| alfresco-search-enterprise.liveIndexing.content.image.tag | string | `"4.0.0-M1"` |  |
| alfresco-search-enterprise.liveIndexing.mediation.image.tag | string | `"4.0.0-M1"` |  |
| alfresco-search-enterprise.liveIndexing.metadata.image.tag | string | `"4.0.0-M1"` |  |
| alfresco-search-enterprise.liveIndexing.path.image.tag | string | `"4.0.0-M1"` |  |
| alfresco-search-enterprise.messageBroker.existingSecretName | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-search-enterprise.reindexing.db.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search-enterprise.reindexing.db.existingSecret.name | string | `"alfresco-cs-database"` |  |
| alfresco-search-enterprise.reindexing.enabled | bool | `true` |  |
| alfresco-search-enterprise.reindexing.image.tag | string | `"4.0.0-M1"` |  |
| alfresco-search.alfresco-insight-zeppelin.enabled | bool | `false` |  |
| alfresco-search.enabled | bool | `true` |  |
| alfresco-search.external.host | string | `nil` | Host dns/ip of the external solr6 instance. |
| alfresco-search.external.port | string | `nil` | Port of the external solr6 instance. |
| alfresco-search.ingress.basicAuth | string | `nil` | Default solr basic auth user/password: admin / admin You can create your own with htpasswd utilility & encode it with base64. Example: `echo -n "$(htpasswd -nbm admin admin)" | base64 | tr -d '\n'` basicAuth: YWRtaW46JGFwcjEkVVJqb29uS00kSEMuS1EwVkRScFpwSHB2a3JwTDd1Lg== |
| alfresco-search.ingress.enabled | bool | `false` | Alfresco Search services endpoint ('/solr') |
| alfresco-search.ingress.tls | list | `[]` |  |
| alfresco-search.nameOverride | string | `"alfresco-search"` |  |
| alfresco-search.repository.existingConfigMap.keys.host | string | `"repo_svc_name"` |  |
| alfresco-search.repository.existingConfigMap.keys.port | string | `"repo_svc_port"` |  |
| alfresco-search.repository.existingConfigMap.keys.securecomms | string | `"SEARCH_SECURECOMMS"` |  |
| alfresco-search.repository.existingConfigMap.name | string | `"alfresco-infrastructure"` |  |
| alfresco-search.repository.existingSecret.keys.sharedSecret | string | `"SOLR_SECRET"` |  |
| alfresco-search.repository.existingSecret.name | string | `"solr-shared-secret"` |  |
| alfresco-search.searchServicesImage.repository | string | `"quay.io/alfresco/search-services"` |  |
| alfresco-search.searchServicesImage.tag | string | `"2.0.8.1"` |  |
| alfresco-sync-service.enabled | bool | `true` | Toggle deployment of Alfresco Sync Service (Desktop-Sync) Check [Alfresco Sync Service Documentation](https://github.com/Alfresco/alfresco-helm-charts/tree/main/charts/alfresco-sync-service) |
| alfresco-sync-service.image.tag | string | `"4.0.0-M11"` |  |
| alfresco-sync-service.messageBroker.existingSecretName | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-sync-service.postgresql.auth.database | string | `"syncservice-postgresql"` |  |
| alfresco-sync-service.postgresql.auth.enablePostgresUser | bool | `false` |  |
| alfresco-sync-service.postgresql.auth.password | string | `"admin"` |  |
| alfresco-sync-service.postgresql.auth.username | string | `"alfresco"` |  |
| alfresco-sync-service.postgresql.enabled | bool | `true` |  |
| alfresco-sync-service.postgresql.image.tag | string | `"14.4.0"` |  |
| alfresco-sync-service.postgresql.primary.resources.limits.cpu | string | `"4"` |  |
| alfresco-sync-service.postgresql.primary.resources.limits.memory | string | `"4Gi"` |  |
| alfresco-sync-service.postgresql.primary.resources.requests.cpu | string | `"250m"` |  |
| alfresco-sync-service.postgresql.primary.resources.requests.memory | string | `"1Gi"` |  |
| alfresco-sync-service.repository.nameOverride | string | `"alfresco-repository"` |  |
| alfresco-sync-service.repository.port | int | `80` |  |
| alfresco-transform-service.enabled | bool | `true` |  |
| alfresco-transform-service.filestore.enabled | bool | `true` | Declares the alfresco-shared-file-store used by the content repository and transform service |
| alfresco-transform-service.filestore.image.repository | string | `"quay.io/alfresco/alfresco-shared-file-store"` |  |
| alfresco-transform-service.filestore.image.tag | string | `"3.1.0-M1"` |  |
| alfresco-transform-service.filestore.persistence.data.mountPath | string | `"/tmp/Alfresco"` |  |
| alfresco-transform-service.filestore.persistence.data.subPath | string | `"alfresco-content-services/filestore-data"` |  |
| alfresco-transform-service.filestore.persistence.enabled | bool | `true` | Persist filestore data |
| alfresco-transform-service.filestore.replicaCount | int | `1` |  |
| alfresco-transform-service.imagemagick.enabled | bool | `true` | Declares the alfresco-imagemagick service used by the content repository to transform image files |
| alfresco-transform-service.imagemagick.image.repository | string | `"alfresco/alfresco-imagemagick"` |  |
| alfresco-transform-service.imagemagick.image.tag | string | `"5.0.0-A1"` |  |
| alfresco-transform-service.libreoffice.enabled | bool | `true` | Declares the alfresco-libreoffice service used by the content repository to transform office files |
| alfresco-transform-service.libreoffice.image.repository | string | `"alfresco/alfresco-libreoffice"` |  |
| alfresco-transform-service.libreoffice.image.tag | string | `"5.0.0-A1"` |  |
| alfresco-transform-service.messageBroker.existingSecretName | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-transform-service.pdfrenderer.enabled | bool | `true` | Declares the alfresco-pdf-renderer service used by the content repository to transform pdf files |
| alfresco-transform-service.pdfrenderer.image.repository | string | `"alfresco/alfresco-pdf-renderer"` |  |
| alfresco-transform-service.pdfrenderer.image.tag | string | `"5.0.0-A1"` |  |
| alfresco-transform-service.tika.enabled | bool | `true` | Declares the alfresco-tika service used by the content repository to transform office files |
| alfresco-transform-service.tika.image.repository | string | `"alfresco/alfresco-tika"` |  |
| alfresco-transform-service.tika.image.tag | string | `"5.0.0-A1"` |  |
| alfresco-transform-service.transformmisc.enabled | bool | `true` | Declares the alfresco-tika service used by the content repository to transform office files |
| alfresco-transform-service.transformmisc.image.repository | string | `"alfresco/alfresco-transform-misc"` |  |
| alfresco-transform-service.transformmisc.image.tag | string | `"5.0.0-A1"` |  |
| alfresco-transform-service.transformrouter.enabled | bool | `true` | Declares the alfresco-transform-router service used by the content repository to route transformation requests |
| alfresco-transform-service.transformrouter.image.repository | string | `"quay.io/alfresco/alfresco-transform-router"` |  |
| alfresco-transform-service.transformrouter.image.tag | string | `"3.1.0-M1"` |  |
| alfresco-transform-service.transformrouter.replicaCount | int | `2` |  |
| database.configMapName | string | `"alfresco-infrastructure"` | Name of the secret managed by this chart |
| database.driver | string | `nil` | Postgresql jdbc driver name ex: org.postgresql.Driver. It should be available in the container image. |
| database.existingSecretName | string | `nil` | An existing secret that contains DATABASE_USERNAME and DATABASE_PASSWORD keys. When using embedded postgres you need to also set `postgresql.existingSecret`. |
| database.external | bool | `false` | Enable using an external database for Alfresco Content Services. Must disable `postgresql.enabled` when true. |
| database.password | string | `nil` | External Postgresql database password |
| database.secretName | string | `"alfresco-cs-database"` | Name of the secret managed by this chart |
| database.url | string | `nil` | External Postgresql jdbc url ex: `jdbc:postgresql://oldfashioned-mule-postgresql-acs:5432/alfresco` |
| database.user | string | `nil` | External Postgresql database user |
| global.ai.enabled | bool | `false` | Enable AI capabilities in ADW AI plugin |
| global.alfrescoRegistryPullSecrets | string | `nil` | If a private image registry a secret can be defined and passed to kubernetes, see: https://github.com/Alfresco/acs-deployment/blob/a924ad6670911f64f1bba680682d266dd4ea27fb/docs/helm/eks-deployment.md#docker-registry-secret |
| global.elasticsearch | object | `{"host":"elasticsearch-master","password":null,"port":9200,"protocol":"http","user":null}` | Shared connections details for Elasticsearch/Opensearch, required when alfresco-search-enterprise.enabled is true |
| global.elasticsearch.host | string | `"elasticsearch-master"` | The host where service is available. The provided default is for when elasticsearch.enabled is true |
| global.elasticsearch.password | string | `nil` | The password required to access the service, if any |
| global.elasticsearch.port | int | `9200` | The port where service is available |
| global.elasticsearch.protocol | string | `"http"` | Valid values are http or https |
| global.elasticsearch.user | string | `nil` | The username required to access the service, if any |
| global.known_urls | list | `["https://localhost","http://localhost"]` | list of trusted URLs. URLs a re used to configure Cross-origin protections Also the first entry is considered the main hosting domain of the platform. |
| global.mail | object | `{"host":null,"password":null,"port":587,"protocol":"smtp","smtp":{"auth":true,"starttls":{"enable":true}},"smtps":{"auth":true},"username":"anonymous"}` | For a full information of configuring the outbound email system, see https://docs.alfresco.com/content-services/latest/config/email/#manage-outbound-emails |
| global.mail.host | string | `nil` | SMTP server to use for the system to send outgoing email |
| global.mail.port | int | `587` | SMTP server port |
| global.mail.protocol | string | `"smtp"` | SMTP protocol to use. Either smtp or smtps |
| global.search.flavor | string | `nil` | set the type of search service used externally (solr6 of elasticsearch) |
| global.search.secretName | string | `"solr-shared-secret"` | Name of the secret managed by this chart |
| global.search.securecomms | string | `"secret"` | set the security level used with the external search service (secret, none or https) |
| global.search.sharedSecret | string | `nil` | Mandatory secret to provide when using Solr search with 'secret' security level |
| global.search.url | string | `nil` | set this URL if you have an external search service |
| global.strategy.rollingUpdate.maxSurge | int | `1` |  |
| global.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| infrastructure.configMapName | string | `"alfresco-infrastructure"` |  |
| messageBroker | object | `{"password":null,"secretName":"acs-alfresco-cs-brokersecret","url":null,"user":null}` | Activemq connection details (activemq.enabled msut also be set to false) |
| messageBroker.secretName | string | `"acs-alfresco-cs-brokersecret"` | Name of the secret managed by this chart |
| postgresql.auth.database | string | `"alfresco"` |  |
| postgresql.auth.existingSecret | string | `nil` |  |
| postgresql.auth.password | string | `"alfresco"` |  |
| postgresql.auth.username | string | `"alfresco"` |  |
| postgresql.commonAnnotations.application | string | `"alfresco-content-services"` |  |
| postgresql.enabled | bool | `true` | Toggle embedded postgres for Alfresco Content Services repository Check [PostgreSQL Bitnami chart Documentation](https://github.com/bitnami/charts/tree/main/bitnami/postgresql) |
| postgresql.image.pullPolicy | string | `"IfNotPresent"` |  |
| postgresql.image.tag | string | `"14.4.0"` |  |
| postgresql.nameOverride | string | `"postgresql-acs"` |  |
| postgresql.primary.extendedConfiguration | string | `"max_connections = 250\nshared_buffers = 512MB\neffective_cache_size = 2GB\nwal_level = minimal\nmax_wal_senders = 0\nmax_replication_slots = 0\nlog_min_messages = LOG\n"` |  |
| postgresql.primary.persistence.existingClaim | string | `nil` | provide an existing persistent volume claim name to persist SQL data Make sure the root folder has the appropriate permissions/ownhership set. |
| postgresql.primary.persistence.storageClass | string | `nil` | set the storageClass to use for dynamic provisioning. setting it to null means "default storageClass". |
| postgresql.primary.persistence.subPath | string | `"alfresco-content-services/database-data"` |  |
| postgresql.primary.resources.limits.cpu | string | `"8"` |  |
| postgresql.primary.resources.limits.memory | string | `"8Gi"` |  |
| postgresql.primary.resources.requests.cpu | string | `"500m"` |  |
| postgresql.primary.resources.requests.memory | string | `"1Gi"` |  |
| share.enabled | bool | `true` | toggle deploying Alfresco Share UI |
| share.image.repository | string | `"quay.io/alfresco/alfresco-share"` |  |
| share.image.tag | string | `"23.1.0-M4"` |  |
| share.nameOverride | string | `"share"` |  |
| share.repository.existingConfigMap.keys.host | string | `"repo_svc_name"` | Name of the key in the configmap which points to the repository service hostname |
| share.repository.existingConfigMap.keys.port | string | `"repo_svc_port"` | Name of the key in the configmap which points to the repository service port |
| share.repository.existingConfigMap.name | string | `"alfresco-infrastructure"` | Name of the configmap which hold the repositoy connection details |

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

Default CPU and memory requirements for each pods are set as low as e think is
reasonable. If you need to teak the resource allocation you can use the
`resources.limits.cpu` & `resources.limits.memory` for each component of the
platform. Remember that most of them are running in JAVA VM so you might want
to also raise the JVM memory settings (-Xmx) which is possible using pods'
environment variables.
