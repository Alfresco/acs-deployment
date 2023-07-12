{{/*
Alfresco Repository index subsystem
*/}}
{{- define "repository.indexSubsystem" -}}
{{- if or (index .Values "alfresco-search" "enabled") (index .Values "alfresco-search" "external" "host") -}}
  solr6
{{- else if index .Values "alfresco-search-enterprise" "enabled" -}}
  elasticsearch
{{- else -}}
  none
{{- end }}
{{- end -}}

{{/*
Alfresco Repository search configuration
*/}}
{{- define "repository.indexConfig" -}}
{{- if index .Values "alfresco-search" "external" "host" }}
-Dsolr.host={{ index .Values "alfresco-search" "external" "host" }}
-Dsolr.port={{ index .Values "alfresco-search" "external" "port" | default 8983 }}
-Dsolr.base.url={{ template "alfresco-search.baseurl" . }}
-Dsolr.secureComms={{ .Values.global.tracking.auth | default "secret" }}
{{- else if index .Values "alfresco-search" "enabled" -}}
{{- $alfrescoSearchContext := dict "Chart" $.Chart "Release" $.Release "Values" (index .Values "alfresco-search") }}
-Dsolr.host={{ template "alfresco-search.host" $alfrescoSearchContext }}
-Dsolr.port={{ template "alfresco-search.svcPort" $alfrescoSearchContext }}
-Dsolr.base.url={{ index .Values "alfresco-search" "ingress" "path" | default "/solr" }}
-Dsolr.secureComms={{ .Values.global.tracking.auth | default "secret" }}
{{- else if index .Values "alfresco-search-enterprise" "enabled" }}
{{- template "repo.elasticsearch.config" . }}
{{- end }}
{{- end -}}
