# acs-sso-example

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 23.1.1](https://img.shields.io/badge/AppVersion-23.1.1-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-content-app(common) | 8.2.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.4.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-repository | 0.1.3 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-share | 0.3.0 |
| https://codecentric.github.io/helm-charts | keycloakx | 2.3.0 |
| oci://registry-1.docker.io/bitnamicharts | repository-database(postgresql) | 13.4.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq.adminUser.password | string | `"alfresco"` |  |
| activemq.adminUser.user | string | `"alfresco"` |  |
| activemq.persistence.enabled | bool | `false` |  |
| alfresco-content-app.enabled | bool | `true` |  |
| alfresco-content-app.env.API_URL | string | `"{protocol}//{hostname}{:port}"` |  |
| alfresco-content-app.env.APP_CONFIG_AUTH_TYPE | string | `"OAUTH"` |  |
| alfresco-content-app.env.APP_CONFIG_OAUTH2_CLIENTID | string | `"alfresco"` |  |
| alfresco-content-app.env.APP_CONFIG_OAUTH2_HOST | string | `"{protocol}//{hostname}{:port}/auth/realms/alfresco"` |  |
| alfresco-content-app.env.APP_CONFIG_OAUTH2_REDIRECT_SILENT_IFRAME_URI | string | `"{protocol}//{hostname}{:port}/assets/silent-refresh.html"` |  |
| alfresco-content-app.env.APP_CONFIG_PROVIDER | string | `"ECM"` |  |
| alfresco-content-app.image.pullPolicy | string | `"IfNotPresent"` |  |
| alfresco-content-app.image.repository | string | `"alfresco/alfresco-content-app"` |  |
| alfresco-content-app.image.tag | string | `"4.3.0"` |  |
| alfresco-content-app.ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"5g"` |  |
| alfresco-content-app.ingress.annotations."nginx.ingress.kubernetes.io/proxy-buffer-size" | string | `"8k"` |  |
| alfresco-content-app.ingress.hostName | string | `"localhost"` |  |
| alfresco-content-app.ingress.ingressClassName | string | `"nginx"` |  |
| alfresco-content-app.ingress.path | string | `"/workspace"` |  |
| alfresco-content-app.ingress.tls | list | `[]` |  |
| alfresco-content-app.nameOverride | string | `"alfresco-content-app"` |  |
| alfresco-content-app.resources.limits.cpu | string | `"1"` |  |
| alfresco-content-app.resources.limits.memory | string | `"1024Mi"` |  |
| alfresco-content-app.resources.requests.cpu | string | `"0.25"` |  |
| alfresco-content-app.resources.requests.memory | string | `"256Mi"` |  |
| alfresco-content-app.securityContext.capabilities.drop[0] | string | `"NET_RAW"` |  |
| alfresco-content-app.securityContext.capabilities.drop[1] | string | `"ALL"` |  |
| alfresco-content-app.securityContext.runAsNonRoot | bool | `true` |  |
| alfresco-content-app.securityContext.runAsUser | int | `101` |  |
| alfresco-content-app.service.envType | string | `"frontend"` |  |
| alfresco-repository.configuration.db.existingConfigMap.name | string | `"repository-database"` |  |
| alfresco-repository.configuration.db.existingSecret.name | string | `"repository-database"` |  |
| alfresco-repository.configuration.messageBroker.existingConfigMap.name | string | `"repository-message-broker"` |  |
| alfresco-repository.configuration.messageBroker.existingSecret.name | string | `"repository-message-broker"` |  |
| alfresco-repository.configuration.repository.existingConfigMap | string | `"repository-properties"` |  |
| alfresco-repository.image.repository | string | `"alfresco/alfresco-content-repository-community"` |  |
| alfresco-repository.image.tag | string | `"23.2.0-A12"` |  |
| alfresco-repository.ingress.hosts[0].host | string | `"localhost"` |  |
| alfresco-repository.ingress.hosts[0].paths[0].path | string | `"/"` |  |
| alfresco-repository.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| alfresco-repository.ingress.hosts[0].paths[1].path | string | `"/api-explorer"` |  |
| alfresco-repository.ingress.hosts[0].paths[1].pathType | string | `"Prefix"` |  |
| alfresco-repository.replicaCount | int | `1` |  |
| alfresco-share.extraVolumeMounts[0].mountPath | string | `"/usr/local/tomcat/webapps/share/WEB-INF/classes/share-config.properties"` |  |
| alfresco-share.extraVolumeMounts[0].name | string | `"share-properties"` |  |
| alfresco-share.extraVolumeMounts[0].subPath | string | `"share-properties"` |  |
| alfresco-share.extraVolumes[0].configMap.name | string | `"share-properties"` |  |
| alfresco-share.extraVolumes[0].name | string | `"share-properties"` |  |
| alfresco-share.image.repository | string | `"alfresco/alfresco-share"` |  |
| alfresco-share.image.tag | string | `"23.2.0-A12"` |  |
| alfresco-share.ingress.hosts[0].host | string | `"localhost"` |  |
| alfresco-share.ingress.hosts[0].paths[0].path | string | `"/share"` |  |
| alfresco-share.ingress.hosts[0].paths[0].pathType | string | `"Prefix"` |  |
| alfresco-share.nameOverride | string | `"alfresco-share"` |  |
| alfresco-share.repository.existingConfigMap.name | string | `"share-repository"` |  |
| global.known_urls | list | `["http://localhost"]` | list of trusted URLs. URLs a re used to configure Cross-origin protections Also the first entry is considered the main hosting domain of the platform. |
| keycloakx.admin.password | string | `nil` | @default randomly generated on first deployment get value using: kubectl get secrets keycloak -o jsonpath='{@.data.KEYCLOAK_ADMIN_PASSWORD}' | base64 -d |
| keycloakx.admin.realm[0].clients[0].clientId | string | `"alfresco"` |  |
| keycloakx.admin.realm[0].clients[0].enabled | bool | `true` |  |
| keycloakx.admin.realm[0].clients[0].implicitFlowEnabled | bool | `true` |  |
| keycloakx.admin.realm[0].clients[0].publicClient | bool | `true` |  |
| keycloakx.admin.realm[0].clients[0].redirectUris[0] | string | `"http://localhost/*"` |  |
| keycloakx.admin.realm[0].clients[0].standardFlowEnabled | bool | `true` |  |
| keycloakx.admin.realm[0].clients[0].webOrigins[0] | string | `"http://localhost"` |  |
| keycloakx.admin.realm[0].defaultLocale | string | `"en"` |  |
| keycloakx.admin.realm[0].enabled | bool | `true` |  |
| keycloakx.admin.realm[0].id | string | `"alfresco"` |  |
| keycloakx.admin.realm[0].internationalizationEnabled | bool | `true` |  |
| keycloakx.admin.realm[0].loginTheme | string | `"alfresco"` |  |
| keycloakx.admin.realm[0].realm | string | `"alfresco"` |  |
| keycloakx.admin.realm[0].sslRequired | string | `"none"` |  |
| keycloakx.admin.realm[0].supportedLocales[0] | string | `"ca"` |  |
| keycloakx.admin.realm[0].supportedLocales[10] | string | `"pt-BR"` |  |
| keycloakx.admin.realm[0].supportedLocales[11] | string | `"ru"` |  |
| keycloakx.admin.realm[0].supportedLocales[12] | string | `"sv"` |  |
| keycloakx.admin.realm[0].supportedLocales[13] | string | `"zh-CN"` |  |
| keycloakx.admin.realm[0].supportedLocales[1] | string | `"de"` |  |
| keycloakx.admin.realm[0].supportedLocales[2] | string | `"en"` |  |
| keycloakx.admin.realm[0].supportedLocales[3] | string | `"es"` |  |
| keycloakx.admin.realm[0].supportedLocales[4] | string | `"fr"` |  |
| keycloakx.admin.realm[0].supportedLocales[5] | string | `"it"` |  |
| keycloakx.admin.realm[0].supportedLocales[6] | string | `"ja"` |  |
| keycloakx.admin.realm[0].supportedLocales[7] | string | `"lt"` |  |
| keycloakx.admin.realm[0].supportedLocales[8] | string | `"nl"` |  |
| keycloakx.admin.realm[0].supportedLocales[9] | string | `"no"` |  |
| keycloakx.admin.realm[0].users[0].credentials[0].type | string | `"password"` |  |
| keycloakx.admin.realm[0].users[0].credentials[0].value | string | `"secret"` |  |
| keycloakx.admin.realm[0].users[0].enabled | bool | `true` |  |
| keycloakx.admin.realm[0].users[0].username | string | `"admin"` |  |
| keycloakx.admin.username | string | `"admin"` | Keycloak admin username |
| keycloakx.command[0] | string | `"/opt/keycloak/bin/kc.sh"` |  |
| keycloakx.command[1] | string | `"start"` |  |
| keycloakx.command[2] | string | `"--http-enabled=true"` |  |
| keycloakx.command[3] | string | `"--http-port=8080"` |  |
| keycloakx.command[4] | string | `"--hostname-strict=false"` |  |
| keycloakx.command[5] | string | `"--hostname-strict-https=false"` |  |
| keycloakx.command[6] | string | `"--import-realm"` |  |
| keycloakx.extraEnv | string | `"- name: JAVA_OPTS_APPEND\n  value: >-\n    -Djgroups.dns.query={{ include \"keycloak.fullname\" . }}-headless\n"` |  |
| keycloakx.extraEnvFrom | string | `"- configMapRef:\n    name: keycloak\n- secretRef:\n    name: keycloak\n"` |  |
| keycloakx.extraInitContainers | string | `"- image: busybox:1.36\n  imagePullPolicy: IfNotPresent\n  name: theme-fetcher\n  command: [sh]\n  args:\n    - -c\n    - |\n      wget https://github.com/Alfresco/alfresco-keycloak-theme/releases/download/0.3.5/alfresco-keycloak-theme-0.3.5.zip -O alfresco.zip\n      unzip -d /themes alfresco.zip\n  volumeMounts:\n    - name: theme\n      mountPath: /themes\n"` |  |
| keycloakx.extraVolumeMounts | string | `"- name: theme\n  mountPath: /opt/keycloak/themes\n- name: realm\n  mountPath: /opt/keycloak/data/import\n"` |  |
| keycloakx.extraVolumes | string | `"- name: theme\n  emptyDir: {}\n- name: realm\n  secret:\n    secretName: keycloak-realm\n"` |  |
| keycloakx.http.relativePath | string | `"/auth"` |  |
| keycloakx.ingress.enabled | bool | `true` |  |
| keycloakx.ingress.rules[0].host | string | `"localhost"` |  |
| keycloakx.ingress.rules[0].paths[0].path | string | `"{{ .Values.http.relativePath }}"` |  |
| keycloakx.ingress.rules[0].paths[0].pathType | string | `"Prefix"` |  |
| keycloakx.ingress.tls | list | `[]` |  |
| keycloakx.nameOverride | string | `"keycloak"` |  |
| repository-database.auth.database | string | `"alfresco"` |  |
| repository-database.auth.password | string | `"alfresco"` |  |
| repository-database.auth.username | string | `"alfresco"` |  |
| repository-database.nameOverride | string | `"repository-database"` |  |
| repository-database.primary.extendedConfiguration | string | `"max_connections = 150\nshared_buffers = 512MB\neffective_cache_size = 2GB\nwal_level = minimal\nmax_wal_senders = 0\nmax_replication_slots = 0\nlog_min_messages = LOG\n"` |  |
| repository-database.primary.persistence.enabled | bool | `false` |  |
| repository-database.primary.resources.limits.cpu | string | `"4"` |  |
| repository-database.primary.resources.limits.memory | string | `"4Gi"` |  |
| repository-database.primary.resources.requests.cpu | string | `"250m"` |  |
| repository-database.primary.resources.requests.memory | string | `"1Gi"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
