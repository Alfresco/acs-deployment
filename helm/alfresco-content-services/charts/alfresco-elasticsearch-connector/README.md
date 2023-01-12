# alfresco-elasticsearch-connector

![Version: 0.2.0-SNAPSHOT](https://img.shields.io/badge/Version-0.2.0--SNAPSHOT-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.3.0-M1](https://img.shields.io/badge/AppVersion-3.3.0--M1-informational?style=flat-square)

A Helm chart for deploying Alfresco Elasticsearch connector

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-charts.alfresco.com/incubator | alfresco-common | 0.3.0-SNAPSHOT |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| contentMediaTypeCache.enabled | bool | `true` |  |
| contentMediaTypeCache.refreshTime | string | `"0 0 * * * *"` |  |
| elasticsearch | object | `{"existingSecretName":null,"host":null,"password":null,"port":null,"protocol":null,"user":null}` | Overrides .Values.global.elasticsearch |
| fullnameOverride | string | `""` |  |
| global.alfrescoRegistryPullSecrets | string | `"quay-registry-secret"` |  |
| global.elasticsearch | object | `{"existingSecretName":null,"host":null,"password":null,"port":null,"protocol":null,"user":null}` | Shared connections details for Elasticsearch/Opensearch |
| global.elasticsearch.existingSecretName | string | `nil` | An existing secret that contains ELASTICSEARCH_USERNAME and ELASTICSEARCH_PASSWORD keys |
| global.elasticsearch.host | string | `nil` | The host where service is available |
| global.elasticsearch.password | string | `nil` | The password required to access the service, if any |
| global.elasticsearch.port | string | `nil` | The port where service is available |
| global.elasticsearch.protocol | string | `nil` | Valid values are http or https |
| global.elasticsearch.user | string | `nil` | The username required to access the service, if any |
| imagePullSecrets | list | `[]` |  |
| indexName | string | `"alfresco"` |  |
| liveIndexing.content.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.content.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-content"` |  |
| liveIndexing.content.image.tag | string | `"3.3.0-M1"` |  |
| liveIndexing.content.replicaCount | int | `1` |  |
| liveIndexing.mediation.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.mediation.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-mediation"` |  |
| liveIndexing.mediation.image.tag | string | `"3.3.0-M1"` |  |
| liveIndexing.metadata.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.metadata.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-metadata"` |  |
| liveIndexing.metadata.image.tag | string | `"3.3.0-M1"` |  |
| liveIndexing.metadata.replicaCount | int | `1` |  |
| liveIndexing.path.image.pullPolicy | string | `"IfNotPresent"` |  |
| liveIndexing.path.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-live-indexing-path"` |  |
| liveIndexing.path.image.tag | string | `"3.3.0-M1"` |  |
| liveIndexing.path.replicaCount | int | `1` |  |
| messageBroker.password | string | `nil` | Broker password |
| messageBroker.url | string | `nil` | Broker URL formatted as per: https://activemq.apache.org/failover-transport-reference |
| messageBroker.user | string | `nil` | Broker username |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| parentNameOverride | string | `""` |  |
| pathIndexingComponent.enabled | bool | `true` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| reindexing.enabled | bool | `true` |  |
| reindexing.image.pullPolicy | string | `"IfNotPresent"` |  |
| reindexing.image.repository | string | `"quay.io/alfresco/alfresco-elasticsearch-reindexing"` |  |
| reindexing.image.tag | string | `"3.3.0-M1"` |  |
| reindexing.pathIndexingEnabled | bool | `true` |  |
| reindexing.postgresql.database | string | `"alfresco"` |  |
| reindexing.postgresql.existingSecretName | string | `nil` | An existing secret that contains DATABASE_USERNAME and DATABASE_PASSWORD keys |
| reindexing.postgresql.hostname | string | `"postgresql-acs"` |  |
| reindexing.postgresql.port | int | `5432` |  |
| reindexing.postgresql.url | string | `nil` |  |
| resources.limits.memory | string | `"2048Mi"` |  |
| resources.requests.memory | string | `"256Mi"` |  |
| securityContext | object | `{}` |  |
| tolerations | list | `[]` |  |
