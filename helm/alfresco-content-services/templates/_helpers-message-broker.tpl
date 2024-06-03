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
