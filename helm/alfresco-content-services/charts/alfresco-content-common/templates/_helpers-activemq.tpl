{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "activemq.fullname" -}}
{{- printf "%s-activemq" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "activemq.config" -}}
{{- if .Values.activemq.enabled -}}
  ACTIVEMQ_URL: {{ printf "nio://%s-broker:61616" (include "activemq.fullname" .) }}
  ACTIVEMQ_USER: {{ .Values.activemq.adminUser.username | quote | default "" }}
  ACTIVEMQ_PASSWORD: {{ .Values.activemq.adminUser.password |  quote | default "" }}
{{- else -}}
  ACTIVEMQ_URL: {{ .Values.messageBroker.url | quote }}
  ACTIVEMQ_USER: {{ .Values.messageBroker.user | quote | default ""  }}
  ACTIVEMQ_PASSWORD: {{ .Values.messageBroker.password | quote | default "" }}
{{- end -}}
{{- end -}}

{{- define "spring.activemq.config" -}}
  SPRING_ACTIVEMQ_BROKERURL: |-
    {{ .Values.messageBroker.url | default (printf "failover:(nio://%s-broker:61616)?timeout=3000&jms.useCompression=true" (include "activemq.fullname" .)) }}
  {{- if .Values.messageBroker.user }}
  SPRING_ACTIVEMQ_USER: {{ .Values.messageBroker.user | quote }}
  {{- end }}
  {{- if .Values.messageBroker.password }}
  SPRING_ACTIVEMQ_PASSWORD: {{ .Values.messageBroker.password | quote }}
  {{- end }}
{{- end -}}
