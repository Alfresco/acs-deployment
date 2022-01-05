{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "alfresco-identity.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "keycloak.fullname" -}}
{{- printf "%s-keycloak" .Release.Name | trunc 20 | trimSuffix "-" -}}
{{- end -}}
