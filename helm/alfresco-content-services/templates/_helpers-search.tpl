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
    {{- else }}
      {{ fail ".Values.alfresco-repository.search.flavor must be set to elasticsearch" }}
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
