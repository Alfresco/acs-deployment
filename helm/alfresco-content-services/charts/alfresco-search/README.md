# alfresco-search

![Version: 1.0.5-SNAPSHOT](https://img.shields.io/badge/Version-1.0.5--SNAPSHOT-informational?style=flat-square)

A Helm chart for deploying Alfresco Search

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
|  | alfresco-insight-zeppelin | 1.0.4-SNAPSHOT |
| https://kubernetes-charts.alfresco.com/incubator | alfresco-common | 0.3.0-SNAPSHOT |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| alfresco-insight-zeppelin.insightzeppelin.enabled | bool | `false` |  |
| environment.SOLR_CREATE_ALFRESCO_DEFAULTS | string | `"alfresco,archive"` |  |
| global | object | `{"alfrescoRegistryPullSecrets":"quay-registry-secret","tracking":{"auth":"secret","sharedsecret":null}}` | Apply your secret file in k8s environment to access quay.io images (Example: https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/SECRETS.md) Global definition of Docker registry pull secret which can be overridden from parent ACS Helm chart(s) |
| global.tracking.auth | string | `"secret"` | Select how solr and repo authenticate to each other none: work only prior to acs 7.2 (and was the default) secret: use a shared secret (to specify using `tracking.sharedsecret`) https: to use mTLS auth (require appropriate certificate configuration) |
| global.tracking.sharedsecret | string | `nil` | Shared secret to authenticate repo/solr traffic |
| ingress.basicAuth | string | `nil` | Default solr basic auth user/password: admin / admin You can create your own with htpasswd utilility & encode it with base640. Example: `echo -n "$(htpasswd -nbm admin admin)" | base64 | tr -d '\n'` # i.e. admin / admin basicAuth: YWRtaW46JGFwcjEkVVJqb29uS00kSEMuS1EwVkRScFpwSHB2a3JwTDd1Lg== |
| ingress.enabled | bool | `false` | Expose the solr admin console behind basic auth |
| ingress.existingSecretName | string | `nil` | An existing secret that contains an `auth` key with a value in the same format of `ingress.basicAuth` |
| ingress.path | string | `"/solr"` |  |
| ingress.tls | list | `[]` |  |
| ingress.whitelist_ips | string | `"0.0.0.0/0"` | Comma separated list of IP CIDR to limit search endpoint over the internet |
| initContainer.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainer.image.repository | string | `"busybox"` |  |
| initContainer.image.tag | string | `"1.35.0"` |  |
| initContainer.resources.limits.memory | string | `"10Mi"` |  |
| initContainer.resources.requests.memory | string | `"5Mi"` |  |
| insightEngineImage.internalPort | int | `8983` |  |
| insightEngineImage.pullPolicy | string | `"IfNotPresent"` |  |
| insightEngineImage.repository | string | `"quay.io/alfresco/insight-engine"` |  |
| insightEngineImage.tag | string | `"2.0.6-A4"` |  |
| livenessProbe.initialDelaySeconds | int | `130` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| nodeSelector | object | `{}` | Define the alfresco-search properties to use in the k8s cluster This is the search provider used by alfresco-content-repository |
| persistence | object | `{"EbsPvConfiguration":{"fsType":"ext4"},"VolumeSizeRequest":"10Gi","chownWithDynamicProvisioning":false,"enabled":true,"search":{"data":{"mountPath":"/opt/alfresco-search-services/data","subPath":"alfresco-content-services/solr-data"}}}` | Defines the mounting points for the persistence required by the apps in the cluster the solr data folder containing the indexes for the alfresco-search-services is mapped to alfresco-content-services/solr-data |
| persistence.VolumeSizeRequest | string | `"10Gi"` | Only define if you have a specific claim already created existingClaim: "search-master-claim" |
| podSecurityContext.fsGroup | int | `33007` |  |
| podSecurityContext.runAsGroup | int | `33007` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33007` |  |
| readinessProbe.initialDelaySeconds | int | `60` |  |
| readinessProbe.periodSeconds | int | `20` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| repository | object | `{}` | The parent chart will set the values for "repository.host" and "repository.port" |
| resources.limits.memory | string | `"2000Mi"` |  |
| resources.requests.memory | string | `"2000Mi"` | Alfresco Search Services requests memory |
| searchServicesImage.internalPort | int | `8983` |  |
| searchServicesImage.pullPolicy | string | `"IfNotPresent"` |  |
| searchServicesImage.repository | string | `"quay.io/alfresco/search-services"` |  |
| searchServicesImage.tag | string | `"2.0.6-A4"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"solr"` |  |
| service.type | string | `"ClusterIP"` |  |
| type | string | `"search-services"` | Define the type of Alfresco Search to use. The default is Alfresco Search Services. The type can be set to use Insight Engine with --set alfresco-search.type="insight-engine",alfresco-search.global.alfrescoRegistryPullSecrets="quay-registry-secret",alfresco-insight-zeppelin.enabled="true" As the Docker Image for Insight Engine is not publicly available the alfrescoRegistryPullSecrets has to be set More information can be found on https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/SECRETS.md |
