{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "activemq.fullname" -}}
{{- printf "%s-activemq" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "activemq.env" -}}
- name: ACTIVEMQ_URL
  value: $(BROKER_URL)
- name: ACTIVEMQ_USER
  value: $(BROKER_USERNAME)
- name: ACTIVEMQ_PASSWORD
  value: $(BROKER_PASSWORD)
{{- end -}}

{{- define "spring.activemq.env" -}}
- name: JAVA_OPTS
  value: >-
    $(JAVA_OPTS)
    -Dmessaging.broker.url=$(BROKER_URL)
    -Dmessaging.username=$(BROKER_USERNAME)
    -Dmessaging.password=$(BROKER_PASSWORD)
{{- end -}}
