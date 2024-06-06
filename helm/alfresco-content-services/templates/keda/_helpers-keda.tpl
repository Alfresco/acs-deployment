{{/*
Render KEDA trigger for the ActiveMQ scaler

Usage: include "alfresco-content-services.mq.keda.scaler.trigger" $

*/}}
{{- define "alfresco-content-services.mq.keda.scaler.trigger" -}}
{{ $ctx := dict "Values" .Values.keda "Chart" .Chart "Release" .Release -}}
{{ $mqCtx := dict "Values" .Values.activemq "Chart" .Chart "Release" .Release -}}
{{ $mqAdminPort := default "8161" (.Values.activemq.services.webConsole.ports).external.webConsole -}}
{{ $hasAllBrokerProps := false }}
{{- with .Values.messageBroker }}
{{ $hasAllBrokerProps = and .webConsole .brokerName }}
{{- end }}
{{- if and (not $hasAllBrokerProps) (not .Values.activemq.enabled) }}
{{- fail "Enabling queue based autoscaling requires to provide the address of the web console and the broker name of your external broker or enable embeded ActiveMQ" }}
{{- end }}
- type: activemq
  metadata:
    managementEndpoint: {{ .Values.messageBroker.webConsole | default (printf "%s-web-console.%s.svc:%v" (include "activemq.fullname" $mqCtx) .Release.Namespace $mqAdminPort) }}
    brokerName: {{ .Values.messageBroker.brokerName | default (include "activemq.fullname" $mqCtx) }}
    {{- with .Values.messageBroker }}
    restAPITemplate: {{ .restAPITemplate }}
    {{- end }}
  authenticationRef:
    name: {{ printf "%s-activemq-auth-trigger" (include "alfresco-content-services.fullname" $ctx) | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Render KEDA scaler options for the ActiveMQ scaler

Usage: include "alfresco-content-services.keda.scaler.options" $

*/}}
{{- define "alfresco-content-services.keda.scaler.options" -}}
pollingInterval: {{ .autoscaling.kedaPollingInterval | default 15 }}
initialCooldownPeriod: {{ .autoscaling.kedaInitialCooldownPeriod | default 300 }}
{{- if not .autoscaling.kedaIdleDisabled }}
cooldownPeriod: {{ .autoscaling.kedaCooldownPeriod | default 900 }}
idleReplicaCount: 0
{{- end }}
minReplicaCount:  {{ .autoscaling.minReplicas }}
maxReplicaCount:  {{ .autoscaling.maxReplicas }}
advanced:
  horizontalPodAutoscalerConfig:
    behavior: {{- toYaml .autoscaling.behavior | nindent 6 }}
{{- end -}}
