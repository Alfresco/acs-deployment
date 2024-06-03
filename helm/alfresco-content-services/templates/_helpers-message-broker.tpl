{{/*
Compute the Message broker URL

Usage: include "alfresco-content-services.mq.url" $

*/}}
{{- define "alfresco-content-services.mq.url" -}}
  {{- if .Values.messageBroker.url }}
  {{- .Values.messageBroker.url }}
  {{- else if .Values.activemq.enabled }}
  {{- $mqCtx := dict "Values" .Values.activemq "Chart" .Chart "Release" .Release }}
  {{- printf "failover:(nio://%s-broker:61616)?timeout=3000&jms.useCompression=true" (include "activemq.fullname" $mqCtx) }}
  {{- else }}
  {{- fail "Disabling in-cluster ActiveMQ requires passing (at least) messageBroker.url" }}
  {{- end }}
{{- end }}


{{/*
Render KEDA trigger for the ActiveMQ autoscaler

Usage: include "alfresco-content-services.mq.keda.scaler.trigger" $

*/}}
{{- define "alfresco-content-services.mq.keda.scaler.trigger" -}}
{{ $ctx := dict "Values" .Values.keda "Chart" .Chart "Release" .Release -}}
{{ $mqCtx := dict "Values" .Values.activemq "Chart" .Chart "Release" .Release -}}
{{ $mqAdminPort := default "8161" (.Values.activemq.services.webConsole.ports).external.webConsole -}}
- type: activemq
  metadata:
    managementEndpoint: {{ printf "%s-activemq-auth-trigger" (include "alfresco-content-services.fullname" $ctx) | trunc 63 | trimSuffix "-" }}
    brokerName: {{ template "activemq.fullname" $mqCtx }}
    targetQueueSize: "10"
  authenticationRef:
    name: {{ printf "%s-activemq-auth-trigger" (include "alfresco-content-services.fullname" $ctx) | trunc 63 | trimSuffix "-" }}
{{- end -}}
