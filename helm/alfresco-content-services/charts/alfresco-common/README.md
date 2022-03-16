# alfresco-common

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: library](https://img.shields.io/badge/Type-library-informational?style=flat-square)

Alfresco Common Template Library This chart is not deployable by itself.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | allows customising affinity |
| config.args | string | `"-c"` |  |
| config.command | string | `"sh"` |  |
| config.env.APPLICATION_PROPERTIES | string | `"{{ .Values.config.mountPath | trimSuffix \"/\" }}/application.properties"` |  |
| config.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the config image |
| config.image.repository | string | `"docker.io/busybox"` | Image used to run config init container at startup |
| config.image.tag | float | `1.32` | Image tag for the config image |
| config.mountPath | string | `"/opt/config/"` |  |
| config.resources | object | `{"limits":{"cpu":"10m","memory":"16Mi"},"requests":{"cpu":"10m","memory":"16Mi"}}` | Resource requests and limits for the config container |
| config.securityContext | object | `{"allowPrivilegeEscalation":false,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | SecurityContext for the config container |
| config.volumeName | string | `"config"` |  |
| db.ddlAuto | string | `"validate"` |  |
| db.driver | string | `"org.postgresql.Driver"` |  |
| db.generateDdl | bool | `false` |  |
| db.password | string | `nil` |  |
| db.platform | string | `"org.hibernate.dialect.PostgreSQLDialect"` |  |
| db.uri | string | `nil` |  |
| db.username | string | `"postgres"` |  |
| enabled | bool | `false` | generate resources only if true, false by default so you can just use the partials |
| env | object | `{}` | add env entries to deployments as dict |
| extraEnv | string | `""` | add env entries to deployments as string |
| extraInitContainers | string | `""` | adds extraInitContainers to deployments |
| extraVolumeMounts | string | `""` | add additional volume mounts as yaml string |
| extraVolumes | string | `""` | add additional volumes as yaml string |
| global.extraEnv | string | `""` | adds global extraEnv to deployments |
| global.gateway.domain | string | `""` | configure default domain for gateway host, i.e. "{{ .Release.Name }}.127.0.0.1.nip.io" |
| global.gateway.host | string | `""` | configure default gateway host Helm template, i.e. "gateway.{{ .Values.global.gateway.domain }}" |
| global.gateway.http | bool | `true` | toggle creating http or https ingress rules, supports literal or boolean values |
| global.gateway.tlsacme | bool | `false` | used to enable automatic TLS for ingress if http is false |
| global.kafka.brokers | string | `""` |  |
| global.kafka.extraEnv | string | `""` |  |
| global.kafka.port | int | `9092` |  |
| global.keycloak.enabled | bool | `true` |  |
| global.keycloak.extraEnv | string | `""` | adds Keycloak extraEnv to deployments |
| global.keycloak.host | string | `""` | configure default keycloak host template, i.e "identity.{{ .Values.global.gateway.domain }}" |
| global.keycloak.path | string | `"/auth"` | configure default keycloak path |
| global.keycloak.realm | string | `"activiti"` | configure default Keycloak realm |
| global.keycloak.resource | string | `"activiti"` | configure default Keycloak resource |
| global.keycloak.url | string | `""` | overrides gateway host configuration |
| global.messaging.broker | string | `""` | configure message broker type for all deployments with messaging.enabled set to 'true' |
| global.messaging.destinationIllegalCharsRegex | string | `"[\\t\\s*#:]"` | Configure regex expression to use for replacement of illegal characters in the destination names. |
| global.messaging.destinationIllegalCharsReplacement | string | `"-"` | Configure replacement character for illegal characters in the destination names. |
| global.messaging.destinationPrefix | string | `""` | Set destination separator to use to build full destinations, i.e. <prefix>_destination. |
| global.messaging.destinationSeparator | string | `"_"` | Set destination separator to use to build full destinations, i.e. prefix<_>destination. |
| global.messaging.destinationTransformers | string | `"toLowerCase,escapeIllegalChars"` | Comma separated list of transformer functions to apply conversion to all destination name for producers, consumers and connectors |
| global.messaging.destinationTransformersEnabled | bool | `false` | Enable destination name transformers to apply conversion to all destination name for producers, consumers and connectors |
| global.messaging.destinations | object | `{}` | Configure destination properties to apply customization to producers and consumer channel bindings with matching destination key. |
| global.messaging.partitionCount | int | `2` | Set partition count for partitioned mode. |
| global.messaging.partitioned | bool | `false` | Enable partitioned messaging configuration for engine events producer and consumers |
| global.rabbitmq.extraEnv | string | `""` |  |
| global.rabbitmq.host | string | `""` |  |
| global.rabbitmq.password | string | `"guest"` |  |
| global.rabbitmq.username | string | `"guest"` |  |
| global.registryPullSecrets | list | `[]` | configure pull secrets for all deployments |
| hpa.enabled | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"activiti/replaceme"` |  |
| image.tag | string | `"latest"` |  |
| ingress.annotations | object | `{}` | configure ingress annotations as key:value pairs |
| ingress.enabled | bool | `true` | set to false to disable ingress record generation |
| ingress.hostName | string | `nil` | if set, overrides .Values.global.gateway.host configuration |
| ingress.path | string | `"/"` | set ingress path |
| ingress.servicePort | string | `nil` | the Service port targeted by the Ingress, defaults to service.externalPort |
| ingress.subPaths | list | `[]` | set multiple ingress subpaths |
| ingress.tls | string | `nil` | set to true in order to enable TLS on the ingress record |
| ingress.tlsSecret | string | `nil` | if tls is set to true, you must declare what secret will store the key/certificate for TLS |
| initContainers | list | `[]` | add additional initContainers as list |
| javaOpts.extra | string | `""` | provide extra options for Java runtime, i.e. -Djavax.net.ssl.truststore=/mnt/secrets/cacerts |
| javaOpts.other | string | `"-XX:+UnlockExperimentalVMOptions -Dsun.zip.disableMemoryMapping=true -XX:+UseParallelGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90"` |  |
| javaOpts.xms | string | `"256m"` |  |
| javaOpts.xmx | string | `"1024m"` |  |
| kafka.brokers | string | `"{{ tpl .Values.global.kafka.brokers $ }}"` |  |
| kafka.extraEnv | string | `"{{ tpl .Values.global.kafka.extraEnv $ }}"` |  |
| kafka.port | string | `"{{ .Values.global.kafka.port }}"` |  |
| liquibase.args | list | `["-jar","liquibase.jar"]` | arguments for liquibase container |
| liquibase.enabled | bool | `false` |  |
| liquibase.env | object | `{}` | add env entries to liquibase init container as dict |
| liquibase.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the liquibase image |
| liquibase.image.repository | string | `nil` | image used to run liquibase database migrations @default image.repository |
| liquibase.image.tag | string | `nil` | Image tag for the liquibase image @default image.tag |
| livenessProbe.failureThreshold | int | `4` |  |
| livenessProbe.initialDelaySeconds | int | `60` |  |
| livenessProbe.path | string | `nil` | set liveness probe path, each service should provide its own value or default @default empty, each service should provide its own value or template or default probePath |
| livenessProbe.periodSeconds | int | `15` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `4` |  |
| messaging.consumer.config.script | string | `"echo activiti.cloud.messaging.broker={{ .Values.global.messaging.broker }} >> $APPLICATION_PROPERTIES\necho activiti.cloud.messaging.partitioned={{ .Values.global.messaging.partitioned }} >> $APPLICATION_PROPERTIES\necho activiti.cloud.messaging.partition-count={{ .Values.global.messaging.partitionCount }} >> $APPLICATION_PROPERTIES\necho activiti.cloud.messaging.instance-index=${HOSTNAME##*-} >> $APPLICATION_PROPERTIES\n"` |  |
| messaging.enabled | bool | `false` |  |
| messaging.producer.config.script | string | `"echo activiti.cloud.messaging.broker={{ .Values.global.messaging.broker }} >> $APPLICATION_PROPERTIES\necho activiti.cloud.messaging.partitioned={{ .Values.global.messaging.partitioned }} >> $APPLICATION_PROPERTIES\necho activiti.cloud.messaging.partition-count={{ .Values.global.messaging.partitionCount }} >> $APPLICATION_PROPERTIES\n"` |  |
| messaging.role | string | `""` | required configuration of the messaging role, i.e. producer, consumer, or connector |
| nodeSelector | object | `{}` | allows customising nodeSelector |
| pgchecker.image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for the pgchecker image |
| pgchecker.image.repository | string | `"docker.io/busybox"` | Image used to check Postgresql readiness at startup |
| pgchecker.image.tag | float | `1.32` | Image tag for the pgchecker image |
| pgchecker.resources | object | `{"limits":{"cpu":"10m","memory":"16Mi"},"requests":{"cpu":"10m","memory":"16Mi"}}` | Resource requests and limits for the pgchecker container |
| pgchecker.securityContext | object | `{"allowPrivilegeEscalation":false,"runAsGroup":1000,"runAsNonRoot":true,"runAsUser":1000}` | SecurityContext for the pgchecker container |
| podAnnotations | object | `{}` | configure deployment pod podAnnotations as dict |
| podLabels | object | `{}` | configure deployment pod podLabels as dict |
| podSecurityContext | object | `{}` |  |
| postgresql.enabled | bool | `false` |  |
| postgresql.name | string | `"postgresql"` |  |
| postgresql.port | int | `5432` |  |
| probePath | string | `nil` | set default probe path for both liveness and readiness @default empty, each service should provide its own value or template, i.e. '{{ tpl .Values.ingress.path . }}/actuator/health' |
| rabbitmq.enabled | bool | `false` |  |
| rabbitmq.extraEnv | string | `"{{ tpl .Values.global.rabbitmq.extraEnv $ }}"` |  |
| rabbitmq.host | string | `"{{ tpl .Values.global.rabbitmq.host $ | default (include \"common.rabbitmq.fullname\" $) }}"` |  |
| rabbitmq.password | string | `"{{ .Values.global.rabbitmq.password }}"` |  |
| rabbitmq.username | string | `"{{ .Values.global.rabbitmq.username }}"` |  |
| readinessProbe.failureThreshold | int | `4` |  |
| readinessProbe.initialDelaySeconds | int | `20` |  |
| readinessProbe.path | string | `nil` | set readiness probe path, each service should provide its own value or default @default empty, each service should provide its own value or template or default probePath |
| readinessProbe.periodSeconds | int | `15` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `3` |  |
| registryPullSecrets | list | `[]` | configures additional pull secrets for this deployment |
| replicaCount | int | `1` | number of replicas |
| resources | object | `{}` | configure resources requests and limits for deployment |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.envType | string | `"backend"` | which type of env, currently supported ones are either backend which is the default or frontend |
| service.externalPort | int | `80` |  |
| service.internalPort | int | `8080` |  |
| service.name | string | `nil` |  |
| service.nodePort | string | `nil` |  |
| service.portName | string | `"http"` |  |
| service.portProtocol | string | `"TCP"` |  |
| service.type | string | `"ClusterIP"` |  |
| sidecars | list | `[]` | add additional sidecar containers as list |
| statefulset.podManagementPolicy | string | `"Parallel"` |  |
| statefulset.updateStrategyType | string | `"RollingUpdate"` |  |
| terminationGracePeriodSeconds | int | `20` |  |
| tolerations | list | `[]` | allows customising tolerations |
| volumeMounts | list | `[]` | add additional volume mounts as list |
| volumes | list | `[]` | add additional volumes as list |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.7.0](https://github.com/norwoodj/helm-docs/releases/v1.7.0)
