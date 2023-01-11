# activemq

![Version: 2.2.0-SNAPSHOT](https://img.shields.io/badge/Version-2.2.0--SNAPSHOT-informational?style=flat-square) ![AppVersion: 5.17.1](https://img.shields.io/badge/AppVersion-5.17.1-informational?style=flat-square)

A Helm chart Providing Apache ActiveMQ.

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-charts.alfresco.com/incubator | alfresco-common | 0.3.0-SNAPSHOT |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| adminUser.password | string | `"admin"` |  |
| adminUser.username | string | `"admin"` |  |
| enabled | bool | `true` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"alfresco/alfresco-activemq"` |  |
| image.tag | string | `"5.17.1-jre11-rockylinux8"` |  |
| livenessProbe.failureThreshold | int | `1` |  |
| livenessProbe.initialDelaySeconds | int | `130` |  |
| livenessProbe.periodSeconds | int | `20` |  |
| livenessProbe.timeoutSeconds | int | `10` |  |
| nodeSelector | object | `{}` |  |
| persistence.accessModes | list | `["ReadWriteOnce"]` | defines type of access required by the persistent volume [Access_Modes] (https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes) |
| persistence.baseSize | string | `"20Gi"` |  |
| persistence.data.mountPath | string | `"/opt/activemq/data"` |  |
| persistence.data.subPath | string | `"alfresco-infrastructure/activemq-data"` |  |
| persistence.enabled | bool | `true` |  |
| persistence.existingClaim | string | `nil` |  |
| persistence.storageClass | string | `nil` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsUser | int | `33031` |  |
| readinessProbe | object | `{"failureThreshold":6,"initialDelaySeconds":60,"periodSeconds":20,"timeoutSeconds":10}` | The ActiveMQ readiness probe is used to check startup only as a failure of the liveness probe later will result in the pod being restarted. |
| replicaCount | int | `1` |  |
| resources.limits.memory | string | `"2048Mi"` |  |
| resources.requests.memory | string | `"512Mi"` |  |
| service.name | string | `"activemq"` |  |
| services.broker.ports.external.amqp | int | `5672` |  |
| services.broker.ports.external.openwire | int | `61616` |  |
| services.broker.ports.external.stomp | int | `61613` |  |
| services.broker.ports.internal.amqp | int | `5672` |  |
| services.broker.ports.internal.openwire | int | `61616` |  |
| services.broker.ports.internal.stomp | int | `61613` |  |
| services.broker.type | string | `"ClusterIP"` |  |
| services.webConsole.ports.external.webConsole | int | `8161` |  |
| services.webConsole.ports.internal.webConsole | int | `8161` |  |
| services.webConsole.type | string | `"NodePort"` |  |
