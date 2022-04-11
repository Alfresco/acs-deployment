{{- define "activemq.config" -}}
{{- if .Values.activemq.enabled -}}
ACTIVEMQ_URL: nio://{{ .Release.Name }}-activemq-broker:61616
ACTIVEMQ_USER: {{ .Values.activemq.adminUser.username }}
ACTIVEMQ_PASSWORD: {{ .Values.activemq.adminUser.password }}
{{- else -}}
ACTIVEMQ_URL: {{ .Values.messageBroker.url }}
ACTIVEMQ_USER: {{ .Values.messageBroker.user }}
ACTIVEMQ_PASSWORD: {{ .Values.messageBroker.password }}
{{- end -}}
{{- end -}}
