{{/* THE TEMPLATES DEFINED BELOW ARE SUPPOSSED TO BE USED FOR THIS CHART ONLY */}}

{{/*
Get Alfresco Search Internal Port
*/}}
{{- define "alfresco-search.internalPort" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- print .Values.insightEngineImage.internalPort -}}
{{- else }}
{{- print .Values.searchServicesImage.internalPort -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Pull Policy
*/}}
{{- define "alfresco-search.pullPolicy" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- print .Values.insightEngineImage.pullPolicy -}}
{{- else }}
{{- print .Values.searchServicesImage.pullPolicy -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Docker Image
*/}}
{{- define "alfresco-search.dockerImage" -}}
{{- if and (.Values.type) (eq (.Values.type | toString) "insight-engine") }}
{{- printf "%s:%s" .Values.insightEngineImage.repository .Values.insightEngineImage.tag -}}
{{- else }}
{{- printf "%s:%s" .Values.searchServicesImage.repository .Values.searchServicesImage.tag -}}
{{- end }}
{{- end -}}
