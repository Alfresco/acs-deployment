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
"alfrescosearch" IS THE CHART NAME. THE VALUE HAS TO BE HARD CODED.
".Chart.Name" CANNOT BE USED FOR THESE TEMPLATES AS THE TEMPLATE WILL BE REFERENCED FROM OTHER CHARTS.
*/}}

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
