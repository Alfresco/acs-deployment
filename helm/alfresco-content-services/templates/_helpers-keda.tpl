{{/*
Render KEDA trigger for the ActiveMQ autoscaler

Usage: include "alfresco-content-services.mq.keda.scaler.trigger" $

*/}}
{{- define "alfresco-content-services.mq.keda.scaler.trigger" -}}
{{ $ctx := dict "Values" .Values.keda "Chart" .Chart "Release" .Release -}}
{{ $mqCtx := dict "Values" .Values.activemq "Chart" .Chart "Release" .Release -}}
{{ $mqAdminPort := default "8161" (.Values.activemq.services.webConsole.ports).external.webConsole -}}
{{- if and (not .Values.messageBroker.webConsole) (not .Values.activemq.enabled) }}
{{- fail "Enabling queue based autoscaling requires to provide the address of the we console of your external broker or enable embeded ActiveMQ" }}
{{- end }}
- type: activemq
  metadata:
    managementEndpoint: {{ .Values.messageBroker.webConsole | default (printf "%s-web-console:%v" (include "activemq.fullname" $mqCtx) $mqAdminPort) }}
    brokerName: {{ template "activemq.fullname" $mqCtx }}
    targetQueueSize: "10"
    restAPITemplate: {{ .Values.messageBroker.restAPITemplate }}
  authenticationRef:
    name: {{ printf "%s-activemq-auth-trigger" (include "alfresco-content-services.fullname" $ctx) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Render KEDA trigger for the ActiveMQ autoscaler

Usage: include "alfresco-content-services.mq.keda.scaler.trigger" $

*/}}
{{- define "alfresco-content-services.keda.scaler.options" -}}
pollingInterval: {{ .autoscaling.kedaPollingInterval | default 15 }}
initialCooldownPeriod: {{ .autoscaling.kedaInitialCooldownPeriod | default 300 }}
cooldownPeriod: {{ .autoscaling.kedaCooldownPeriod | default 900 }}
idleReplicaCount: {{ .autoscaling.kedaIdleReplicas | default 0 }}
minReplicaCount:  {{ .autoscaling.minReplicas }}
maxReplicaCount:  {{ .autoscaling.maxReplicas }}
advanced:
  horizontalPodAutoscalerConfig:
    behavior: {{- toYaml .autoscaling.behavior }}
{{- end -}}
