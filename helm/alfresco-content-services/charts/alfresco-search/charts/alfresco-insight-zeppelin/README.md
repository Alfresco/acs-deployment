# alfresco-insight-zeppelin

![Version: 1.0.3](https://img.shields.io/badge/Version-1.0.3-informational?style=flat-square)

A Helm chart for deploying Alfresco Insight Zeppelin

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-charts.alfresco.com/incubator | alfresco-common | 0.1.0-SNAPSHOT |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global | object | `{"alfrescoRegistryPullSecrets":"quay-registry-secret","strategy":{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0}}}` | Apply your secret file in k8s environment to access quay.io images (Example: https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/SECRETS.md) Global definition of Docker registry pull secret which can be overridden from parent ACS Helm chart(s) |
| image.internalPort | int | `9090` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"quay.io/alfresco/insight-zeppelin"` |  |
| image.tag | string | `"1.4.0"` |  |
| ingress.path | string | `"/zeppelin"` |  |
| insightzeppelin.enabled | bool | `false` |  |
| livenessProbe.initialDelaySeconds | int | `130` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| nodeSelector | object | `{}` |  |
| readinessProbe.initialDelaySeconds | int | `60` |  |
| readinessProbe.periodSeconds | int | `20` |  |
| readinessProbe.timeoutSeconds | int | `10` |  |
| replicaCount | int | `1` | Define the alfresco-insight-zeppelin properties to use in the k8s cluster This is chart will be installed as part of Alfresco Insight Engine |
| repository | object | `{}` | The parent chart will set the values for "repository.host" and "repository.port" |
| resources.limits.memory | string | `"1024Mi"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| service.externalPort | int | `80` |  |
| service.name | string | `"zeppelin"` |  |
| service.type | string | `"ClusterIP"` |  |
