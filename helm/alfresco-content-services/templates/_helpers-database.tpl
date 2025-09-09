{{/*
Compute the repository database URL

Usage: include "alfresco-content-services.database.repo" $

*/}}
{{- define "alfresco-content-services.database.repo" -}}
{{- with .Values }}
  {{- if and (not .database.url) (not .postgresql.enabled) }}
    {{- fail "You must either set database.url or postgresql.enabled" }}
  {{- end }}
  {{- if .database.url }}
    {{- .database.url }}
  {{- else }}
    {{- $pg_port := .postgresql.primary.service.ports.postgresql | toString }}
    {{- printf "postgresql://%s-%s:%s/%s" $.Release.Name .postgresql.nameOverride $pg_port .postgresql.auth.database }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Compute the sync-service database URL

Usage: include "alfresco-content-services.database.sync" $

*/}}
{{- define "alfresco-content-services.database.sync" -}}
{{- with .Values }}
  {{- if and (not .database.sync.url) (not (index . "postgresql-sync" "enabled")) }}
    {{- fail "You must either set database.sync.url or postgresql-sync.enabled values" }}
  {{- end }}
  {{- if .database.sync.url }}
    {{- .database.sync.url }}
  {{- else }}
    {{- $pg_port := index . "postgresql-sync" "primary" "service" "ports" "postgresql" | toString }}
    {{- printf "postgresql://%s-%s:%s/%s" $.Release.Name (index . "postgresql-sync" "nameOverride") $pg_port (index . "postgresql-sync" "auth" "database") }}
  {{- end }}
{{- end }}
{{- end -}}
