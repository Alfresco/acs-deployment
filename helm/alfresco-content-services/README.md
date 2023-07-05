# alfresco-content-services

![Version: 6.1.0-SNAPSHOT](https://img.shields.io/badge/Version-6.1.0--SNAPSHOT-informational?style=flat-square) ![AppVersion: 23.1.0-A12](https://img.shields.io/badge/AppVersion-23.1.0--A12-informational?style=flat-square)

A Helm chart for deploying Alfresco Content Services

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-control-center(common) | 7.7.0 |
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-digital-workspace(common) | 7.7.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.1.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-common | 2.0.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-search-enterprise | 1.2.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-search(alfresco-search-service) | 1.1.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-sync-service | 4.1.0 |
| oci://registry-1.docker.io/bitnamicharts | postgresql | 12.5.6 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.adminUser.password | string | `"admin"` | Default password for the embedded broker admin user |
| activemq.adminUser.user | string | `"admin"` | Default username for the embedded broker admin user |
| activemq.enabled | bool | `true` |  |
| activemq.nameOverride | string | `"activemq"` |  |
| activemq.nodeSelector | object | `{}` | Possibility to choose Node for pod, with a key-value pair label e.g {"kubernetes.io/hostname": multinode-demo-m02} |
| aiTransformer.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| aiTransformer.image.internalPort | int | `8090` |  |
| aiTransformer.image.pullPolicy | string | `"IfNotPresent"` |  |
| aiTransformer.image.repository | string | `"quay.io/alfresco/alfresco-ai-docker-engine"` |  |
| aiTransformer.image.tag | string | `"2.0.0"` |  |
| aiTransformer.livenessProbe.initialDelaySeconds | int | `10` |  |
| aiTransformer.livenessProbe.livenessPercent | int | `400` |  |
| aiTransformer.livenessProbe.livenessTransformPeriodSeconds | int | `600` |  |
| aiTransformer.livenessProbe.maxTransformSeconds | int | `1800` |  |
| aiTransformer.livenessProbe.maxTransforms | int | `10000` |  |
| aiTransformer.livenessProbe.periodSeconds | int | `20` |  |
| aiTransformer.livenessProbe.timeoutSeconds | int | `10` |  |
| aiTransformer.nodeSelector | object | `{}` |  |
| aiTransformer.podSecurityContext.runAsUser | int | `33015` |  |
| aiTransformer.readinessProbe.initialDelaySeconds | int | `20` |  |
| aiTransformer.readinessProbe.periodSeconds | int | `60` |  |
| aiTransformer.readinessProbe.timeoutSeconds | int | `10` |  |
| aiTransformer.replicaCount | int | `2` |  |
| aiTransformer.resources.limits.cpu | string | `"2"` |  |
| aiTransformer.resources.limits.memory | string | `"1000Mi"` |  |
| aiTransformer.resources.requests.cpu | string | `"0.25"` |  |
| aiTransformer.resources.requests.memory | string | `"1000Mi"` |  |
| aiTransformer.service.externalPort | int | `80` |  |
| aiTransformer.service.name | string | `"ai-transformer"` |  |
| aiTransformer.service.type | string | `"ClusterIP"` |  |
| alfresco-control-center.enabled | bool | `true` |  |
| alfresco-control-center.env.API_URL | string | `"{protocol}//{hostname}{:port}"` |  |
| alfresco-control-center.env.APP_CONFIG_AUTH_TYPE | string | `"BASIC"` |  |
| alfresco-control-center.env.APP_CONFIG_PROVIDER | string | `"ECM"` |  |
| alfresco-control-center.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-control-center.image.repository | string | `"quay.io/alfresco/alfresco-control-center"` |  |
| alfresco-control-center.image.tag | string | `"8.1.0-5421573582"` |  |
| alfresco-control-center.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| alfresco-control-center.ingress.path | string | `"/control-center"` |  |
| alfresco-control-center.ingress.tls | list | `[]` |  |
| alfresco-control-center.nameOverride | string | `"alfresco-cc"` |  |
| alfresco-control-center.nodeSelector | object | `{}` |  |
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
| alfresco-digital-workspace.extraEnv | string | `"{{- if .Values.global.ai.enabled }}\n- name: APP_CONFIG_PLUGIN_AI_SERVICE\n  value: '{{ .Values.global.ai.enabled }}'\n{{- end }}"` |  |
| alfresco-digital-workspace.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-digital-workspace.image.repository | string | `"quay.io/alfresco/alfresco-digital-workspace"` |  |
| alfresco-digital-workspace.image.tag | string | `"4.1.0-5421573582"` |  |
| alfresco-digital-workspace.ingress.annotations."kubernetes.io/ingress.class" | string | `"nginx"` |  |
| alfresco-digital-workspace.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| alfresco-digital-workspace.ingress.path | string | `"/workspace"` |  |
| alfresco-digital-workspace.ingress.tls | list | `[]` |  |
| alfresco-digital-workspace.nameOverride | string | `"alfresco-dw"` |  |
| alfresco-digital-workspace.nodeSelector | object | `{}` |  |
| alfresco-digital-workspace.resources.limits.cpu | string | `"1"` |  |
| alfresco-digital-workspace.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-digital-workspace.resources.requests.cpu | string | `"0.25"` |  |
| alfresco-digital-workspace.resources.requests.memory | string | `"256Mi"` |  |
| alfresco-digital-workspace.securityContext.capabilities.drop[0] | string | `"NET_RAW"` |  |
| alfresco-digital-workspace.securityContext.capabilities.drop[1] | string | `"ALL"` |  |
| alfresco-digital-workspace.securityContext.runAsNonRoot | bool | `true` |  |
| alfresco-digital-workspace.securityContext.runAsUser | int | `101` |  |
| alfresco-digital-workspace.service.envType | string | `"frontend"` |  |
| alfresco-search-enterprise.elasticsearch.enabled | bool | `true` | Enables the embedded elasticsearch cluster |
| alfresco-search-enterprise.enabled | bool | `false` |  |
| alfresco-search-enterprise.liveIndexing.content.image.tag | string | `"3.4.0-M1"` |  |
| alfresco-search-enterprise.liveIndexing.mediation.image.tag | string | `"3.4.0-M1"` |  |
| alfresco-search-enterprise.liveIndexing.metadata.image.tag | string | `"3.4.0-M1"` |  |
| alfresco-search-enterprise.liveIndexing.path.image.tag | string | `"3.4.0-M1"` |  |
| alfresco-search-enterprise.messageBroker.existingSecretName | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-search-enterprise.reindexing.enabled | bool | `true` |  |
| alfresco-search-enterprise.reindexing.image.tag | string | `"3.4.0-M1"` |  |
| alfresco-search-enterprise.reindexing.postgresql.database | string | `"alfresco"` |  |
| alfresco-search-enterprise.reindexing.postgresql.existingSecretName | string | `"acs-alfresco-cs-dbsecret"` |  |
| alfresco-search-enterprise.reindexing.postgresql.hostname | string | `"postgresql-acs"` |  |
| alfresco-search-enterprise.reindexing.postgresql.url | string | `nil` |  |
| alfresco-search.alfresco-insight-zeppelin.enabled | bool | `false` |  |
| alfresco-search.enabled | bool | `true` |  |
| alfresco-search.external.host | string | `nil` | Host dns/ip of the external solr6 instance. |
| alfresco-search.external.port | string | `nil` | Port of the external solr6 instance. |
| alfresco-search.ingress.basicAuth | string | `nil` | Default solr basic auth user/password: admin / admin You can create your own with htpasswd utilility & encode it with base64. Example: `echo -n "$(htpasswd -nbm admin admin)" | base64 | tr -d '\n'` basicAuth: YWRtaW46JGFwcjEkVVJqb29uS00kSEMuS1EwVkRScFpwSHB2a3JwTDd1Lg== |
| alfresco-search.ingress.enabled | bool | `false` | Alfresco Search services endpoint ('/solr') |
| alfresco-search.ingress.tls | list | `[]` |  |
| alfresco-search.nodeSelector | object | `{}` |  |
| alfresco-sync-service.enabled | bool | `true` | Toggle deployment of Alfresco Sync Service (Desktop-Sync) Check [Alfresco Sync Service Documentation](https://github.com/Alfresco/alfresco-helm-charts/tree/main/charts/alfresco-sync-service) |
| alfresco-sync-service.image.tag | string | `"3.10.0"` |  |
| alfresco-sync-service.messageBroker.existingSecretName | string | `"acs-alfresco-cs-brokersecret"` |  |
| alfresco-sync-service.postgresql.auth.database | string | `"syncservice-postgresql"` |  |
| alfresco-sync-service.postgresql.auth.enablePostgresUser | bool | `false` |  |
| alfresco-sync-service.postgresql.auth.password | string | `"admin"` |  |
| alfresco-sync-service.postgresql.auth.username | string | `"alfresco"` |  |
| alfresco-sync-service.postgresql.enabled | bool | `true` |  |
| alfresco-sync-service.postgresql.image.tag | string | `"14.4.0"` |  |
| alfresco-sync-service.postgresql.primary.resources.limits.cpu | string | `"4"` |  |
| alfresco-sync-service.postgresql.primary.resources.limits.memory | string | `"1500Mi"` |  |
| alfresco-sync-service.postgresql.primary.resources.requests.cpu | string | `"0.5"` |  |
| alfresco-sync-service.postgresql.primary.resources.requests.memory | string | `"1500Mi"` |  |
| alfresco-sync-service.repository.nameOverride | string | `"alfresco-cs-repository"` |  |
| alfresco-sync-service.repository.port | int | `80` |  |
| apiexplorer | object | `{"ingress":{"path":"/api-explorer"}}` | Declares the api-explorer service used by the content repository |
| database.driver | string | `nil` | Postgresql jdbc driver name ex: org.postgresql.Driver. It should be available in the container image. |
| database.existingSecretName | string | `nil` | An existing secret that contains DATABASE_USERNAME and DATABASE_PASSWORD keys. When using embedded postgres you need to also set `postgresql.existingSecret`. |
| database.external | bool | `false` | Enable using an external database for Alfresco Content Services. Must disable `postgresql.enabled` when true. |
| database.password | string | `nil` | External Postgresql database password |
| database.secretName | string | `"acs-alfresco-cs-dbsecret"` | Name of the secret managed by this chart |
| database.url | string | `nil` | External Postgresql jdbc url ex: `jdbc:postgresql://oldfashioned-mule-postgresql-acs:5432/alfresco` |
| database.user | string | `nil` | External Postgresql database user |
| email | object | `{"handler":{"folder":{"overwriteDuplicates":true}},"inbound":{"emailContributorsAuthority":"EMAIL_CONTRIBUTORS","enabled":false,"unknownUser":"anonymous"},"initContainers":{"pemToKeystore":{"image":{"pullPolicy":"IfNotPresent","repository":"registry.access.redhat.com/redhat-sso-7/sso71-openshift","tag":"1.1-16"}},"pemToTruststore":{"image":{"pullPolicy":"IfNotPresent","repository":"registry.access.redhat.com/redhat-sso-7/sso71-openshift","tag":"1.1-16"}},"setPerms":{"image":{"pullPolicy":"IfNotPresent","repository":"busybox","tag":"1.35.0"}}},"server":{"allowed":{"senders":".*"},"auth":{"enabled":true},"blocked":{"senders":null},"connections":{"max":3},"domain":null,"enableTLS":true,"enabled":false,"hideTLS":false,"port":1125,"requireTLS":false},"ssl":{"secretName":null}}` | For a full information of configuring the inbound email system, see https://docs.alfresco.com/content-services/latest/config/email/#manage-inbound-emails |
| filestore | object | `{"environment":{"JAVA_OPTS":"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80","scheduler.cleanup.interval":"86400000","scheduler.content.age.millis":"86400000"},"image":{"internalPort":8099,"pullPolicy":"IfNotPresent","repository":"quay.io/alfresco/alfresco-shared-file-store","tag":"3.0.0"},"initContainer":{"image":{"pullPolicy":"IfNotPresent","repository":"busybox","tag":"1.35.0"},"resources":{"limits":{"cpu":"0.50","memory":"10Mi"}}},"livenessProbe":{"initialDelaySeconds":10,"livenessPercent":150,"livenessSavePeriodSeconds":600,"periodSeconds":20,"timeoutSeconds":10},"nodeSelector":{},"persistence":{"accessModes":["ReadWriteOnce"],"data":{"mountPath":"/tmp/Alfresco","subPath":"alfresco-content-services/filestore-data"},"enabled":true,"existingClaim":null,"storageClass":null},"podSecurityContext":{"fsGroup":1000,"runAsGroup":1000,"runAsUser":33030},"readinessProbe":{"initialDelaySeconds":20,"periodSeconds":60,"timeoutSeconds":10},"replicaCount":1,"resources":{"limits":{"cpu":"2","memory":"1000Mi"},"requests":{"cpu":"0.25","memory":"200Mi"}},"service":{"externalPort":80,"name":"filestore","type":"ClusterIP"}}` | Declares the alfresco-shared-file-store used by the content repository and transform service |
| filestore.persistence.accessModes | list | `["ReadWriteOnce"]` | Specify a storageClass for dynamic provisioning |
| filestore.persistence.enabled | bool | `true` | Persist filestore data |
| filestore.persistence.existingClaim | string | `nil` | Use pre-provisioned pv through its claim (e.g. static provisionning) |
| filestore.persistence.storageClass | string | `nil` | Bind PVC based on storageClass (e.g. dynamic provisionning) |
| global.ai | object | `{"enabled":false}` | Choose if you want AI capabilities (globally - including ADW AI plugin) |
| global.alfrescoRegistryPullSecrets | string | `nil` | If a private image registry a secret can be defined and passed to kubernetes, see: https://github.com/Alfresco/acs-deployment/blob/a924ad6670911f64f1bba680682d266dd4ea27fb/docs/helm/eks-deployment.md#docker-registry-secret |
| global.elasticsearch | object | `{"host":"elasticsearch-master","password":null,"port":9200,"protocol":"http","user":null}` | Shared connections details for Elasticsearch/Opensearch, required when alfresco-search-enterprise.enabled is true |
| global.elasticsearch.host | string | `"elasticsearch-master"` | The host where service is available. The provided default is for when elasticsearch.enabled is true |
| global.elasticsearch.password | string | `nil` | The password required to access the service, if any |
| global.elasticsearch.port | int | `9200` | The port where service is available |
| global.elasticsearch.protocol | string | `"http"` | Valid values are http or https |
| global.elasticsearch.user | string | `nil` | The username required to access the service, if any |
| global.registryPullSecrets[0] | string | `"quay-registry-secret"` |  |
| global.strategy.rollingUpdate.maxSurge | int | `1` |  |
| global.strategy.rollingUpdate.maxUnavailable | int | `0` |  |
| global.tracking.auth | string | `"secret"` | Select how solr and repo authenticate to each other none: work only prior to acs 7.2 (and was the default) secret: use a shared secret (to specify using `tracking.sharedsecret`) https: to use mTLS auth (require appropriate certificate configuration) |
| global.tracking.sharedsecret | string | `nil` | Shared secret to authenticate repo/solr traffic. Strong enough secret can be generated with `openssl rand 20 -base64` |
| imagemagick | object | `{"environment":{"JAVA_OPTS":"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"},"image":{"internalPort":8090,"pullPolicy":"IfNotPresent","repository":"alfresco/alfresco-imagemagick","tag":"4.0.0"},"livenessProbe":{"initialDelaySeconds":10,"livenessPercent":150,"livenessTransformPeriodSeconds":600,"maxTransformSeconds":900,"maxTransforms":10000,"periodSeconds":20,"timeoutSeconds":10},"nodeSelector":{},"podSecurityContext":{"runAsNonRoot":true,"runAsUser":33002},"readinessProbe":{"initialDelaySeconds":20,"periodSeconds":60,"timeoutSeconds":10},"replicaCount":2,"resources":{"limits":{"cpu":"4","memory":"1000Mi"},"requests":{"cpu":"0.5","memory":"300Mi"}},"service":{"externalPort":80,"name":"imagemagick","type":"ClusterIP"}}` | Declares the alfresco-imagemagick service used by the content repository to transform image files |
| imap | object | `{"mail":{"from":{"default":null},"to":{"default":null}},"server":{"enabled":false,"host":"0.0.0.0","imap":{"enabled":true},"imaps":{"enabled":true,"port":1144},"port":1143}}` | For a full information of configuring the imap subsystem, see https://docs.alfresco.com/content-services/latest/config/email/#enable-imap-protocol-using-alfresco-globalproperties |
| libreoffice | object | `{"environment":{"JAVA_OPTS":"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"},"image":{"internalPort":8090,"pullPolicy":"IfNotPresent","repository":"alfresco/alfresco-libreoffice","tag":"4.0.0"},"livenessProbe":{"initialDelaySeconds":10,"livenessPercent":250,"livenessTransformPeriodSeconds":600,"maxTransformSeconds":1800,"maxTransforms":99999,"periodSeconds":20,"timeoutSeconds":10},"nodeSelector":{},"podSecurityContext":{"runAsNonRoot":true,"runAsUser":33003},"readinessProbe":{"initialDelaySeconds":20,"periodSeconds":60,"timeoutSeconds":10},"replicaCount":2,"resources":{"limits":{"cpu":"4","memory":"1000Mi"},"requests":{"cpu":"0.5","memory":"400Mi"}},"service":{"externalPort":80,"name":"libreoffice","type":"ClusterIP"}}` | Declares the alfresco-libreoffice service used by the content repository to transform office files |
| mail | object | `{"encoding":"UTF-8","existingSecretName":null,"from":{"default":null,"enabled":false},"host":null,"password":null,"port":25,"protocol":"smtps","smtp":{"auth":true,"debug":false,"starttls":{"enable":true},"timeout":30000},"smtps":{"auth":true,"starttls":{"enable":true}},"username":null}` | For a full information of configuring the outbound email system, see https://docs.alfresco.com/content-services/latest/config/email/#manage-outbound-emails |
| mail.existingSecretName | string | `nil` | An existing kubernetes secret that contains MAIL_PASSWORD as per `mail.password` value |
| mail.from.default | string | `nil` | Specifies the email address from which email notifications are sent |
| mail.host | string | `nil` | SMTP(S) host server to enable delivery of site invitations, activity notifications and workflow tasks by email |
| messageBroker | object | `{"existingSecretName":null,"password":null,"secretName":"acs-alfresco-cs-brokersecret","url":null,"user":null}` | external activemq connection setting when activemq.enabled=false |
| messageBroker.existingSecretName | string | `nil` | Alternatively, provide credentials via an existing secret that contains BROKER_URL, BROKER_USERNAME and BROKER_PASSWORD keys |
| messageBroker.secretName | string | `"acs-alfresco-cs-brokersecret"` | Name of the secret managed by this chart |
| metadataKeystore.defaultKeyPassword | string | `"oKIWzVdEdA"` |  |
| metadataKeystore.defaultKeystorePassword | string | `"mp6yc0UD9e"` |  |
| msTeams | object | `{"enabled":false}` | Enable/Disable Alfresco Content Connector for Microsoft Teams |
| msTeamsService.alfresco.baseUrl | string | `"change_me_alf_base_url"` |  |
| msTeamsService.alfresco.digitalWorkspace.contextPath | string | `"/workspace/"` |  |
| msTeamsService.image.internalPort | int | `3978` |  |
| msTeamsService.image.pullPolicy | string | `"IfNotPresent"` |  |
| msTeamsService.image.repository | string | `"quay.io/alfresco/alfresco-ms-teams-service"` |  |
| msTeamsService.image.tag | string | `"2.0.0"` |  |
| msTeamsService.ingress.path | string | `"/ms-teams-service"` |  |
| msTeamsService.ingress.tls | list | `[]` |  |
| msTeamsService.livenessProbe.initialDelaySeconds | int | `10` |  |
| msTeamsService.livenessProbe.periodSeconds | int | `20` |  |
| msTeamsService.livenessProbe.timeoutSeconds | int | `10` |  |
| msTeamsService.microsoft.app.id | string | `"change_me_app_id"` |  |
| msTeamsService.microsoft.app.oauth.connectionName | string | `"alfresco"` |  |
| msTeamsService.microsoft.app.password | string | `"change_me_app_pwd"` |  |
| msTeamsService.nodeSelector | object | `{}` |  |
| msTeamsService.podSecurityContext.runAsNonRoot | bool | `true` |  |
| msTeamsService.podSecurityContext.runAsUser | int | `33041` |  |
| msTeamsService.readinessProbe.initialDelaySeconds | int | `20` |  |
| msTeamsService.readinessProbe.periodSeconds | int | `60` |  |
| msTeamsService.readinessProbe.timeoutSeconds | int | `10` |  |
| msTeamsService.replicaCount | int | `2` |  |
| msTeamsService.resources.limits.cpu | string | `"1"` |  |
| msTeamsService.resources.limits.memory | string | `"1000Mi"` |  |
| msTeamsService.resources.requests.cpu | string | `"0.5"` |  |
| msTeamsService.resources.requests.memory | string | `"1000Mi"` |  |
| msTeamsService.service.externalPort | int | `80` |  |
| msTeamsService.service.name | string | `"ms-teams-service"` |  |
| msTeamsService.service.type | string | `"ClusterIP"` |  |
| msTeamsService.teams.chat.filenameEnabled | bool | `true` |  |
| msTeamsService.teams.chat.imageEnabled | bool | `true` |  |
| msTeamsService.teams.chat.metadataEnabled | bool | `true` |  |
| ooi | object | `{"enabled":false}` | Enable/Disable Alfresco Collaboration Connector for Microsoft 365 |
| ooiService.environment.JAVA_OPTS | string | `" -Dalfresco.base-url=http://acs-alfresco-cs-repository:80"` |  |
| ooiService.image.internalPort | int | `9095` |  |
| ooiService.image.pullPolicy | string | `"IfNotPresent"` |  |
| ooiService.image.repository | string | `"quay.io/alfresco/alfresco-ooi-service"` |  |
| ooiService.image.tag | string | `"2.0.0"` |  |
| ooiService.ingress.path | string | `"/ooi-service"` |  |
| ooiService.ingress.tls | list | `[]` |  |
| ooiService.livenessProbe.initialDelaySeconds | int | `10` |  |
| ooiService.livenessProbe.periodSeconds | int | `20` |  |
| ooiService.livenessProbe.timeoutSeconds | int | `10` |  |
| ooiService.nodeSelector | object | `{}` |  |
| ooiService.podSecurityContext.runAsNonRoot | bool | `true` |  |
| ooiService.podSecurityContext.runAsUser | int | `33006` |  |
| ooiService.readinessProbe.initialDelaySeconds | int | `20` |  |
| ooiService.readinessProbe.periodSeconds | int | `60` |  |
| ooiService.readinessProbe.timeoutSeconds | int | `10` |  |
| ooiService.replicaCount | int | `2` |  |
| ooiService.resources.limits.cpu | string | `"2"` |  |
| ooiService.resources.limits.memory | string | `"1000Mi"` |  |
| ooiService.resources.requests.cpu | string | `"0.25"` |  |
| ooiService.resources.requests.memory | string | `"1000Mi"` |  |
| ooiService.service.externalPort | int | `80` |  |
| ooiService.service.name | string | `"ooi-service"` |  |
| ooiService.service.type | string | `"ClusterIP"` |  |
| pdfrenderer | object | `{"environment":{"JAVA_OPTS":"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"},"image":{"internalPort":8090,"pullPolicy":"IfNotPresent","repository":"alfresco/alfresco-pdf-renderer","tag":"4.0.0"},"livenessProbe":{"initialDelaySeconds":10,"livenessPercent":150,"livenessTransformPeriodSeconds":600,"maxTransformSeconds":1200,"maxTransforms":10000,"periodSeconds":20,"timeoutSeconds":10},"nodeSelector":{},"podSecurityContext":{"runAsNonRoot":true,"runAsUser":33001},"readinessProbe":{"initialDelaySeconds":20,"periodSeconds":60,"timeoutSeconds":10},"replicaCount":2,"resources":{"limits":{"cpu":"2","memory":"1000Mi"},"requests":{"cpu":"0.25","memory":"300Mi"}},"service":{"externalPort":80,"name":"pdfrenderer","type":"ClusterIP"}}` | Declares the alfresco-pdf-renderer service used by the content repository to transform pdf files |
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
| postgresql.primary.resources.limits.memory | string | `"8192Mi"` |  |
| postgresql.primary.resources.requests.cpu | string | `"0.5"` |  |
| postgresql.primary.resources.requests.memory | string | `"1500Mi"` |  |
| repository.adminPassword | string | `"209c6174da490caeb422f3fa5a7ae634"` | Administrator password for ACS in NTLM hash format to set at bootstrap time |
| repository.command | list | `[]` |  |
| repository.edition | string | `"Enterprise"` |  |
| repository.environment.JAVA_OPTS | string | `"-Dtransform.service.enabled=true -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80 -Dencryption.keystore.type=JCEKS -Dencryption.cipherAlgorithm=DESede/CBC/PKCS5Padding -Dencryption.keyAlgorithm=DESede -Dencryption.keystore.location=/usr/local/tomcat/shared/classes/alfresco/extension/keystore/keystore -Dmetadata-keystore.aliases=metadata -Dmetadata-keystore.metadata.algorithm=DESede"` |  |
| repository.existingSecretName | string | `nil` | An existing secret that contains REPO_ADMIN_PASSWORD as an alternative for `repository.adminPassword` value |
| repository.extraInitContainers | list | `[]` |  |
| repository.extraLogStatements | object | `{}` | Provide additional log statements by adding classes and/or packages in a key:value maner org.alfresco.repo.content.transform.TransformerDebug: debug |
| repository.extraSideContainers | list | `[]` |  |
| repository.extraVolumeMounts | list | `[]` |  |
| repository.extraVolumes | list | `[]` |  |
| repository.image.hazelcastPort | int | `5701` |  |
| repository.image.internalPort | int | `8080` |  |
| repository.image.pullPolicy | string | `"IfNotPresent"` |  |
| repository.image.repository | string | `"quay.io/alfresco/alfresco-content-repository"` |  |
| repository.image.tag | string | `"23.1.0-A19"` |  |
| repository.ingress.annotations | object | `{}` |  |
| repository.ingress.maxUploadSize | string | `"5g"` |  |
| repository.ingress.path | string | `"/"` |  |
| repository.ingress.tls | list | `[]` |  |
| repository.initContainers.db.image.pullPolicy | string | `"IfNotPresent"` |  |
| repository.initContainers.db.image.repository | string | `"busybox"` |  |
| repository.initContainers.db.image.tag | string | `"1.35.0"` |  |
| repository.initContainers.db.resources.limits.cpu | string | `"0.25"` |  |
| repository.initContainers.db.resources.limits.memory | string | `"10Mi"` |  |
| repository.licenseSecret | string | `nil` | The name of the secret holding the ACS repository license if any. it must be contained within a `data['*.lic']` property For details on how to manage license, see: https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/examples/alf_license.md |
| repository.livenessProbe.initialDelaySeconds | int | `130` |  |
| repository.livenessProbe.periodSeconds | int | `20` |  |
| repository.livenessProbe.timeoutSeconds | int | `10` |  |
| repository.nodeSelector | object | `{}` |  |
| repository.persistence.accessModes | list | `["ReadWriteMany"]` | Specify a storageClass for dynamic provisioning |
| repository.persistence.baseSize | string | `"20Gi"` |  |
| repository.persistence.data.mountPath | string | `"/usr/local/tomcat/alf_data"` |  |
| repository.persistence.data.subPath | string | `"alfresco-content-services/repository-data"` |  |
| repository.persistence.enabled | bool | `true` | Persist repository data |
| repository.persistence.existingClaim | string | `nil` | Use pre-provisioned pv through its claim (e.g. static provisioning) |
| repository.persistence.storageClass | string | `nil` | Bind PVC based on storageClass (e.g. dynamic provisioning) |
| repository.podSecurityContext.fsGroup | int | `1000` |  |
| repository.podSecurityContext.runAsGroup | int | `1000` |  |
| repository.podSecurityContext.runAsNonRoot | bool | `true` |  |
| repository.podSecurityContext.runAsUser | int | `33000` |  |
| repository.readinessProbe.failureThreshold | int | `6` |  |
| repository.readinessProbe.initialDelaySeconds | int | `60` |  |
| repository.readinessProbe.periodSeconds | int | `20` |  |
| repository.readinessProbe.timeoutSeconds | int | `10` |  |
| repository.replicaCount | int | `2` |  |
| repository.resources.limits.cpu | string | `"4"` |  |
| repository.resources.limits.memory | string | `"3000Mi"` |  |
| repository.resources.requests.cpu | string | `"1"` |  |
| repository.resources.requests.memory | string | `"1500Mi"` |  |
| repository.service.externalPort | int | `80` |  |
| repository.service.name | string | `"alfresco"` |  |
| repository.service.type | string | `"ClusterIP"` |  |
| repository.startupProbe | object | `{"failureThreshold":10,"periodSeconds":30}` | The startup probe to cover the worse case startup time for slow clusters |
| repository.strategy.type | string | `"Recreate"` |  |
| s3connector.config.bucketLocation | string | `nil` |  |
| s3connector.config.bucketName | string | `nil` |  |
| s3connector.enabled | bool | `false` | Enable the S3 Connector For a full list of properties on the S3 connector see: https://docs.alfresco.com/s3connector/references/s3-contentstore-ref-config-props.html |
| s3connector.existingSecretName | string | `nil` | An existing kubernetes secret that contains ACCESSKEY, SECRETKEY, ENCRYPTION, KMSKEYID keys |
| s3connector.secrets.accessKey | string | `nil` |  |
| s3connector.secrets.awsKmsKeyId | string | `nil` |  |
| s3connector.secrets.encryption | string | `nil` |  |
| s3connector.secrets.secretKey | string | `nil` |  |
| share | object | `{"command":[],"environment":{"CATALINA_OPTS":"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"},"extraInitContainers":[],"extraSideContainers":[],"extraVolumeMounts":[],"extraVolumes":[],"image":{"internalPort":8080,"pullPolicy":"IfNotPresent","repository":"quay.io/alfresco/alfresco-share","tag":"23.1.0-A19"},"ingress":{"annotations":{},"path":"/share","tls":[]},"livenessProbe":{"initialDelaySeconds":200,"periodSeconds":20,"timeoutSeconds":10},"nodeSelector":{},"podSecurityContext":{"runAsNonRoot":true},"readinessProbe":{"initialDelaySeconds":60,"periodSeconds":20,"timeoutSeconds":15},"replicaCount":1,"resources":{"limits":{"cpu":"4","memory":"2000Mi"},"requests":{"cpu":"1","memory":"512Mi"}},"securityContext":{"capabilities":{"drop":["NET_RAW","ALL"]},"runAsNonRoot":false},"service":{"externalPort":80,"name":"share","type":"ClusterIP"}}` | Define the alfresco-share properties to use in the k8s cluster This is the default presentation layer(UI) of Alfresco Content Services |
| tika | object | `{"environment":{"JAVA_OPTS":"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"},"image":{"internalPort":8090,"pullPolicy":"IfNotPresent","repository":"alfresco/alfresco-tika","tag":"4.0.0"},"livenessProbe":{"initialDelaySeconds":60,"livenessPercent":400,"livenessTransformPeriodSeconds":600,"maxTransformSeconds":1800,"maxTransforms":10000,"periodSeconds":20,"timeoutSeconds":10},"nodeSelector":{},"podSecurityContext":{"runAsNonRoot":true,"runAsUser":33004},"readinessProbe":{"initialDelaySeconds":60,"periodSeconds":60,"timeoutSeconds":10},"replicaCount":2,"resources":{"limits":{"cpu":"2","memory":"1000Mi"},"requests":{"cpu":"0.25","memory":"600Mi"}},"service":{"externalPort":80,"name":"tika","type":"ClusterIP"}}` | Declares the alfresco-tika service used by the content repository to transform office files |
| transformmisc | object | `{"enabled":true,"environment":{"JAVA_OPTS":"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"},"image":{"internalPort":8090,"pullPolicy":"IfNotPresent","repository":"alfresco/alfresco-transform-misc","tag":"4.0.0"},"livenessProbe":{"initialDelaySeconds":10,"livenessPercent":400,"livenessTransformPeriodSeconds":600,"maxTransformSeconds":1800,"maxTransforms":10000,"periodSeconds":20,"timeoutSeconds":10},"nodeSelector":{},"podSecurityContext":{"runAsNonRoot":true,"runAsUser":33006},"readinessProbe":{"initialDelaySeconds":20,"periodSeconds":60,"timeoutSeconds":10},"replicaCount":2,"resources":{"limits":{"cpu":"2","memory":"1000Mi"},"requests":{"cpu":"0.25","memory":"300Mi"}},"service":{"externalPort":80,"name":"transformmisc","type":"ClusterIP"}}` | Declares the alfresco-tika service used by the content repository to transform office files |
| transformrouter.environment.JAVA_OPTS | string | `"-XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| transformrouter.image.internalPort | int | `8095` |  |
| transformrouter.image.pullPolicy | string | `"IfNotPresent"` |  |
| transformrouter.image.repository | string | `"quay.io/alfresco/alfresco-transform-router"` |  |
| transformrouter.image.tag | string | `"3.0.0"` |  |
| transformrouter.livenessProbe.initialDelaySeconds | int | `140` |  |
| transformrouter.livenessProbe.periodSeconds | int | `120` |  |
| transformrouter.livenessProbe.timeoutSeconds | int | `60` |  |
| transformrouter.nodeSelector | object | `{}` |  |
| transformrouter.podSecurityContext.runAsNonRoot | bool | `true` |  |
| transformrouter.podSecurityContext.runAsUser | int | `33016` |  |
| transformrouter.readinessProbe.initialDelaySeconds | int | `140` |  |
| transformrouter.readinessProbe.periodSeconds | int | `60` |  |
| transformrouter.readinessProbe.timeoutSeconds | int | `10` |  |
| transformrouter.replicaCount | int | `2` |  |
| transformrouter.resources.limits.cpu | string | `"1"` |  |
| transformrouter.resources.limits.memory | string | `"512Mi"` |  |
| transformrouter.resources.requests.cpu | string | `"0.25"` |  |
| transformrouter.resources.requests.memory | string | `"300Mi"` |  |
| transformrouter.service.externalPort | int | `80` |  |
| transformrouter.service.name | string | `"transform-router"` |  |
| transformrouter.service.type | string | `"ClusterIP"` |  |

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
