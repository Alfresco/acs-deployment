{{/*
Compute the search "flavor"

Usage: include "alfresco-content-services.search.flavor" $

*/}}
{{- define "alfresco-content-services.search.flavor" -}}
{{- with .Values }}
  {{- if .global.search.flavor }}
    {{- .global.search.flavor }}
  {{- else if (index . "alfresco-search-enterprise" "enabled") }}
    {{- if eq (index . "alfresco-repository" "configuration" "search" "flavor") "elasticsearch" }}
      {{- print "elasticsearch" }}
    {{- else if not (index . "alfresco-search" "enabled") }}
      {{ fail ".Values.alfresco-repository.search.flavor must be set to elasticsearch" }}
    {{- else }}
      {{- print "solr6" }}{{/* migration scenario when both engines are enabled */}}
    {{- end }}
  {{- else if (index . "alfresco-search" "enabled") }}
    {{- if eq (index . "alfresco-repository" "configuration" "search" "flavor") "solr6" }}
      {{- print "solr6" }}
    {{- else }}
      {{ fail ".Values.alfresco-repository.search.flavor must be set to solr6" }}
    {{- end }}
  {{- else }}
    {{- print "noindex" }}
  {{- end }}
{{- end }}
{{- end -}}

{{/*
Compute the url for elasticsearch for audit

Usage: include "alfresco-content-services.audit.elasticsearchUrl" $

*/}}
{{- define "alfresco-content-services.audit.elasticsearchUrl" -}}
{{- $elasticsearch_audit_url := "" }}
  {{- if .Values.global.auditIndex.url }}
    {{- $elasticsearch_audit_url = .Values.global.auditIndex.url }}
  {{- else }}
    {{- with (index .Values "elasticsearch") }}
      {{- if .enabled }}
        {{- $auditEsHost := printf "%s-%s" $.Release.Name (($.Values.global.elasticsearch).service.name | default "elasticsearch") }}
        {{- $auditEsPort := ($.Values.global.elasticsearch).service.ports.restApi | default 9200 }}
        {{- $auditEsProto := .protocol | default "http" }}
        {{- $elasticsearch_audit_url = coalesce $.Values.global.auditIndex.url (printf "%s://%s:%v" $auditEsProto $auditEsHost $auditEsPort) }}
      {{- else if index $.Values "alfresco-audit-storage" "enabled" }}
        {{- fail "Chart is configured to use Alfresco Audit Storage but no index backend has been provided. Set one using either global.auditIndex.url or elasticsearch.enabled" }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- print $elasticsearch_audit_url }}
{{- end -}}
