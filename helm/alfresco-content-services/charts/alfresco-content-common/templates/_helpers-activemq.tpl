{{- define "activemq.config" -}}
{{- if .Values.activemq.enabled -}}
  ACTIVEMQ_URL: nio://{{ .Release.Name }}-activemq-broker:61616
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
    {{ .Values.messageBroker.url | default (printf "nio://%s-activemq-broker:61616" .Release.Name) }}
  {{- if .Values.messageBroker.user }}
  SPRING_ACTIVEMQ_USER: {{ .Values.messageBroker.user | quote }}
  {{- end }}
  {{- if .Values.messageBroker.password }}
  SPRING_ACTIVEMQ_PASSWORD: {{ .Values.messageBroker.password | quote }}
  {{- end }}
{{- end -}}
