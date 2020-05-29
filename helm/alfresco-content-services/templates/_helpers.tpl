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

{{- define "content-services.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" -}}
{{- end }}

{{- define "alfresco.shortname" -}}
{{- $name := (.Values.nameOverride | default (printf "%s" "alfresco-")) -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* ======================================================================== */}}

{{/*
THE TEMPLATES DEFINED BELOW WILL BE USED BY OTHER CHARTS.
"alfresco-search" IS THE CHART NAME. THE VALUE HAS TO BE HARD CODED.
".Chart.Name" CANNOT BE USED FOR THESE TEMPLATES AS THE TEMPLATE WILL BE REFERENCED FROM OTHER CHARTS.
*/}}

{{/*
Get Alfresco Search Full Name
*/}}
{{- define "alfresco-search.fullName" -}}
{{- $name := (.Values.alfresco-search.nameOverride | default (printf "%s" "alfresco-search")) -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Get Alfresco Search Host
*/}}
{{- define "alfresco-search.host" -}}
{{- printf "%s-%s-%s" .Release.Name "alfresco-search" "solr" -}}
{{- end -}}

{{/*
Get Alfresco Search Port
*/}}
{{- define "alfresco-search.port" -}}
{{- print (index .Values "alfresco-search" "service" "externalPort") -}}
{{- end -}}

{{/* ======================================================================== */}}

{{/* THE TEMPLATES DEFINED BELOW ARE SUPPOSSED TO BE USED FOR THIS CHART ONLY */}}

{{/*
Get Alfresco Search Internal Port
*/}}
{{- define "alfresco-search.internalPort" -}}
{{- if and (.Values.alfresco-search.type) (eq (.Values.alfresco-search.type | toString) "insight-engine") }}
{{- print .Values.alfresco-search.insightEngineImage.internalPort -}}
{{- else }}
{{- print .Values.alfresco-search.searchServicesImage.internalPort -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Pull Policy
*/}}
{{- define "alfresco-search.pullPolicy" -}}
{{- if and (.Values.alfresco-search.type) (eq (.Values.alfresco-search.type | toString) "insight-engine") }}
{{- print .Values.alfresco-search.insightEngineImage.pullPolicy -}}
{{- else }}
{{- print .Values.alfresco-search.searchServicesImage.pullPolicy -}}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Search Docker Image
*/}}
{{- define "alfresco-search.dockerImage" -}}
{{- if and (.Values.alfresco-search.type) (eq (.Values.alfresco-search.type | toString) "insight-engine") }}
{{- printf "%s:%s" .Values.alfresco-search.insightEngineImage.repository .Values.alfresco-search.insightEngineImage.tag -}}
{{- else }}
{{- printf "%s:%s" .Values.alfresco-search.searchServicesImage.repository .Values.alfresco-search.searchServicesImage.tag -}}
{{- end }}
{{- end -}}
