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

{{- define "database.jdbcurl" -}}
{{- if (.Values.database.url) }}
{{- printf "%s" .Values.database.url -}}
{{- else }}
{{- $host := (printf "%s-%s" .Release.Name .Values.postgresql.nameOverride . ) -}}
{{- printf "jdbc:postgresql://%s:%s/%s" $host .Values.postgresql.service.port .Values.postgresql.postgresDatabase -}}
{{- end }}
{{- end -}}