# alfresco-sync-service

![Version: 3.0.9](https://img.shields.io/badge/Version-3.0.9-informational?style=flat-square)

Alfresco Sync Service

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://kubernetes-charts.alfresco.com/incubator | alfresco-common | 0.3.0-SNAPSHOT |
| https://raw.githubusercontent.com/bitnami/charts/archive-full-index/bitnami/ | common | 1.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| contentServices.installationName | string | `nil` | Specify when installing as a standalone chart, not as a subchart of ACS. must match the release name of the ACS release |
| database | object | `{"external":false}` | Defines properties required by sync service for connecting to the database If you set database.external to true you will have to setup the JDBC driver, user, password and JdbcUrl as `driver`, `user`, `password` & `url` subelements of `database`. Also make sure that the container has the db driver |
| global | object | `{"alfrescoRegistryPullSecrets":"quay-registry-secret","strategy":{"rollingUpdate":{"maxSurge":1,"maxUnavailable":0}}}` | Global definition of Docker registry pull secret which can be overridden from parent ACS Helm chart(s) |
| ingress.extraAnnotations | string | `nil` | useful when running Sync service without SSL termination done by a load balancer, e.g. when ran on Minikube for testing purposes nginx.ingress.kubernetes.io/ssl-redirect: "false" |
| ingress.tls | list | `[]` |  |
| initContainers.activemq.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainers.activemq.image.repository | string | `"bash"` |  |
| initContainers.activemq.image.tag | string | `"5.1.16"` |  |
| initContainers.activemq.resources.limits.memory | string | `"10Mi"` |  |
| initContainers.activemq.resources.requests.memory | string | `"5Mi"` |  |
| initContainers.postgres.image.pullPolicy | string | `"IfNotPresent"` |  |
| initContainers.postgres.image.repository | string | `"busybox"` |  |
| initContainers.postgres.image.tag | string | `"1.35.0"` |  |
| initContainers.postgres.resources.limits.memory | string | `"10Mi"` |  |
| initContainers.postgres.resources.requests.memory | string | `"5Mi"` |  |
| messageBroker | object | `{"existingSecretName":null,"url":null}` | messageBroker object allow to pass ActiveMQ connection details. url: provides URI formatted string, see: https://activemq.apache.org/failover-transport-reference user: username to authenticate as. password: credential to use to authenticate to the broker. |
| nodeSelector | object | `{}` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| podSecurityContext.runAsGroup | int | `1000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `33020` |  |
| postgresql-syncservice.enabled | bool | `true` | If true, install the postgresql chart alongside Alfresco Sync service. Note: Set this to false if you use an external database. |
| postgresql-syncservice.image.pullPolicy | string | `"IfNotPresent"` |  |
| postgresql-syncservice.image.tag | string | `"11.7.0"` |  |
| postgresql-syncservice.name | string | `"postgresql-syncservice"` |  |
| postgresql-syncservice.nameOverride | string | `"postgresql-syncservice"` |  |
| postgresql-syncservice.postgresConfig.log_min_messages | string | `"LOG"` |  |
| postgresql-syncservice.postgresConfig.max_connections | int | `450` |  |
| postgresql-syncservice.postgresqlDatabase | string | `"syncservice-postgresql"` |  |
| postgresql-syncservice.postgresqlPassword | string | `"admin"` |  |
| postgresql-syncservice.postgresqlUsername | string | `"alfresco"` |  |
| postgresql-syncservice.replicaCount | int | `1` |  |
| postgresql-syncservice.resources.limits.memory | string | `"1500Mi"` |  |
| postgresql-syncservice.resources.requests.memory | string | `"1500Mi"` |  |
| postgresql-syncservice.service.port | int | `5432` |  |
| replicaCount | int | `1` |  |
| repository.host | string | `"alfresco-cs-repository"` |  |
| repository.port | int | `80` |  |
| syncservice.enabled | bool | `true` |  |
| syncservice.environment.EXTRA_JAVA_OPTS | string | `""` |  |
| syncservice.environment.JAVA_OPTS | string | `"-Dsync.metrics.reporter.graphite.enabled=false -Dsync.metrics.reporter.graphite.address=127.0.0.1 -Dsync.metrics.reporter.graphite.port=2003 -XX:MinRAMPercentage=50 -XX:MaxRAMPercentage=80"` |  |
| syncservice.horizontalPodAutoscaling.CPU.enabled | bool | `true` |  |
| syncservice.horizontalPodAutoscaling.CPU.targetAverageUtilization | int | `80` |  |
| syncservice.horizontalPodAutoscaling.enabled | bool | `true` |  |
| syncservice.horizontalPodAutoscaling.maxReplicas | int | `3` |  |
| syncservice.horizontalPodAutoscaling.memory.enabled | bool | `true` |  |
| syncservice.horizontalPodAutoscaling.memory.targetAverageUtilization | int | `60` | For the memory a lower threshold(60) for the targetAverageUtilization is needed. We need to allow the resource metrics to be queried by the metrics-server, before the pod is killed # by Kubernetes due to reaching memory limits(the infamous message one might see in the pod events history "Terminated: OOMKilled"). The metrics are checked every 15 seconds by default, configured by the global cluster flag --horizontal-pod-autoscaler-sync-period |
| syncservice.horizontalPodAutoscaling.minReplicas | int | `1` |  |
| syncservice.image.internalPort | int | `9090` |  |
| syncservice.image.pullPolicy | string | `"IfNotPresent"` |  |
| syncservice.image.repository | string | `"quay.io/alfresco/service-sync"` |  |
| syncservice.image.tag | string | `"4.0.0-M5"` |  |
| syncservice.ingress.path | string | `"/syncservice"` |  |
| syncservice.livenessProbe.initialDelaySeconds | int | `150` |  |
| syncservice.livenessProbe.periodSeconds | int | `30` |  |
| syncservice.livenessProbe.timeoutSeconds | int | `10` |  |
| syncservice.readinessProbe.failureThreshold | int | `12` |  |
| syncservice.readinessProbe.initialDelaySeconds | int | `20` |  |
| syncservice.readinessProbe.periodSeconds | int | `10` |  |
| syncservice.readinessProbe.timeoutSeconds | int | `10` |  |
| syncservice.resources.limits.cpu | string | `"2"` |  |
| syncservice.resources.limits.memory | string | `"2000Mi"` |  |
| syncservice.resources.requests.cpu | string | `"2"` |  |
| syncservice.resources.requests.memory | string | `"2000Mi"` |  |
| syncservice.service.externalPort | int | `80` |  |
| syncservice.service.name | string | `"syncservice"` |  |
| syncservice.service.type | string | `"NodePort"` |  |

Please refer to the [documentation](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/README.md) for information on the Helm charts and deployment instructions.
