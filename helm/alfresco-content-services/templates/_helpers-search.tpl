{{/*
Compute the search "flavor"

Usage: include "alfresco-content-services.search.flavor" $

*/}}
{{- define "alfresco-content-services.search.flavor" -}}
{{- with .Values }}
  {{- if .global.search.flavor }}
    {{- .global.search.flavor }}
  {{- else if (index . "alfresco-search-enterprise" "enabled") }}
      {{- print "elasticsearch" }}
  {{- else if (index . "alfresco-search" "enabled") }}
      {{- print "solr6" }}
  {{- else }}
      {{- print "noindex" }}
  {{- end }}
{{- end }}
{{- end -}}
