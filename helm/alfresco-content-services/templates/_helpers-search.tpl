{{/* THE TEMPLATES DEFINED BELOW ARE USED ALFRESCOSEARCH SERVICE */}}

{{/*
Get Alfresco Search Full Name
*/}}
{{- define "alfrescosearch.fullName" -}}
{{- $name := (.Values.alfrescosearch.nameOverride | default (printf "%s" "alfrescosearch")) -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get Alfresco Search Host
*/}}
{{- define "alfrescosearch.host" -}}
{{- printf "%s-%s-%s" .Release.Name "alfrescosearch" "solr" -}}
{{- end -}}

{{/*
Get Alfresco Search Port
*/}}
{{- define "alfrescosearch.port" -}}
{{- print (index .Values "alfrescosearch" "service" "externalPort") -}}
{{- end -}}

{{/* ======================================================================== */}}

{{/* THE TEMPLATES DEFINED BELOW ARE SUPPOSSED TO BE USED FOR THIS CHART ONLY */}}

{{/*
Get Alfresco Search Internal Port
*/}}
{{- define "alfrescosearch.internalPort" -}}
{{- if and (.Values.alfrescosearch.type) (eq (.Values.alfrescosearch.type | toString) "insight-engine") }}
{{- print .Values.alfrescosearch.insightEngineImage.internalPort -}}
{{- else }}
{{- print .Values.alfrescosearch.searchServicesImage.internalPort -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Pull Policy
*/}}
{{- define "alfrescosearch.pullPolicy" -}}
{{- if and (.Values.alfrescosearch.type) (eq (.Values.alfrescosearch.type | toString) "insight-engine") }}
{{- print .Values.alfrescosearch.insightEngineImage.pullPolicy -}}
{{- else }}
{{- print .Values.alfrescosearch.searchServicesImage.pullPolicy -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Docker Image
*/}}
{{- define "alfrescosearch.dockerImage" -}}
{{- if and (.Values.alfrescosearch.type) (eq (.Values.alfrescosearch.type | toString) "insight-engine") }}
{{- printf "%s:%s" .Values.alfrescosearch.insightEngineImage.repository .Values.alfrescosearch.insightEngineImage.tag -}}
{{- else }}
{{- printf "%s:%s" .Values.alfrescosearch.searchServicesImage.repository .Values.alfrescosearch.searchServicesImage.tag -}}
{{- end }}
{{- end -}}
