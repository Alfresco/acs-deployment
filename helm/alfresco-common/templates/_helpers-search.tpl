{{/*
Create a default fully qualified name.
*/}}
{{- define "alfresco-search.fullName" -}}
{{- printf "%s-alfresco-search" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Alfresco Search2 Host
*/}}
{{- define "alfresco-search.host" -}}
{{- if index $.Values "alfresco-search" "enabled" -}}
  {{ printf "%s-solr" (include "alfresco-search.fullName" .) -}}
{{- else -}}
  {{ index $.Values "alfresco-search" "external" "host" | default "localhost" -}}
{{- end -}}
{{- end -}}

{{/*
Get Alfresco Search Port
*/}}
{{- define "alfresco-search.port" -}}
{{- if index $.Values "alfresco-search" "enabled" -}}
  {{ print (index .Values "alfresco-search" "service" "externalPort") -}}
{{- else -}}
  {{ index $.Values "alfresco-search" "external" "port" | default "8983" -}}
{{- end -}}
{{- end -}}

{{/*
Get Alfresco Solr context
*/}}
{{- define "alfresco-search.baseurl" -}}
{{- if index $.Values "alfresco-search" "enabled" -}}
  /solr
{{- else -}}
  {{ index $.Values "alfresco-search" "external" "context" | default "/solr" -}}
{{- end -}}
{{- end -}}

{{/*
Required Solr secret
*/}}
{{- define "tracking-shared-secret" -}}
  {{- required "You need to provide a shared secret for Solr/repo authentication , see https://github.com/Alfresco/acs-deployment/tree/master/docs/helm" .Values.global.tracking.sharedsecret -}}
{{- end }}
