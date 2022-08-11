{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "activemq.fullname" -}}
{{- printf "%s-activemq" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "activemq.config" -}}
  ACTIVEMQ_URL: "$BROKER_URL"
  ACTIVEMQ_USER: "$BROKER_USERNAME"
  ACTIVEMQ_PASSWORD: "$BROKER_PASSWORD"
{{- end -}}

{{- define "spring.activemq.config" -}}
  SPRING_ACTIVEMQ_BROKERURL: "$BROKER_URL"
  SPRING_ACTIVEMQ_USER: "$BROKER_USERNAME"
  SPRING_ACTIVEMQ_PASSWORD: "$BROKER_PASSWORD"
{{- end -}}
