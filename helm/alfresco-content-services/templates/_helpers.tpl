{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "content-services.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "content-services.shortname" -}}
{{- $name := (.Values.nameOverride | default (printf "%s" "alfresco-cs")) -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "alfresco.shortname" -}}
{{- $name := (.Values.nameOverride | default (printf "%s" "alfresco-")) -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "alfresco-content-services.activemq.url" -}}
{{- $context := dict "Chart" (dict "Name" "activemq") "Release" .Release "Values" (index .Values "alfresco-infrastructure" "activemq") -}}
{{- $name := include "activemq.fullname" $context -}}
{{- printf "nio://%s-broker:61616" $name }}
{{- end -}}

{{- define "alfresco-content-services.alfresco-search.host" -}}
{{- $context := dict "Chart" (dict "Name" "alfresco-search") "Release" .Release "Values" (index .Values "alfresco-search") -}}
{{- include "alfresco-search.host" $context -}}
{{- end -}}

{{- define "alfresco-content-services.alfresco-search.port" -}}
{{- $context := dict "Chart" (dict "Name" "alfresco-search") "Release" .Release "Values" (index .Values "alfresco-search") -}}
{{- index $context "service" "externalPort" -}}
{{- end -}}
