{{/*
Compute the Message broker URL

Usage: include "alfresco-content-services.mq.url" $

*/}}
{{- define "alfresco-content-services.mq.url" -}}
  {{- if .Values.activemq.enabled }}
  {{- printf "failover:(nio://%s-broker:61616)?timeout=3000&jms.useCompression=true" (include "content-services.activemq.fullname" .) }}
  {{- else }}
  {{ required "Disabling in-cluster ActiveMQ requires passing (at least) messageBroker.url" .Values.messageBroker.url }}
  {{- end }}
{{- end }}
