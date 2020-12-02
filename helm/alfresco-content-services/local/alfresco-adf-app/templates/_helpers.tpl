{{/*
Create a default fully qualified name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "alfresco-adf-app.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "alfresco-adf-app.selectorLabels" -}}
app: {{ template "alfresco-adf-app.fullname" . }}
release: {{ .Release.Name }}
{{- end }}

{{- define "alfresco-adf-app.labels" -}}
chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{ include "alfresco-adf-app.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}

{{/*
Create an ingress url template
*/}}
{{- define "common.ingress-url" -}}
  {{- $common := dict "Values" .Values.common -}}
  {{- $noCommon := omit .Values "common" -}}
  {{- $overrides := dict "Values" $noCommon -}}
  {{- $noValues := omit . "Values" -}}
  {{- with merge $noValues $overrides $common -}}
    {{- $proto := include "common.gateway-proto" . -}}
    {{- $host := include "common.ingress-host" . -}}
    {{- $path := include "common.ingress-path" . -}}
    {{- $pathNoSlash := ternary $path "" (ne $path "/") -}}
    {{- $url := printf "%s://%s%s" $proto $host $pathNoSlash -}}
    {{- $ingressUrl := default $url .Values.ingress.url -}}
    {{- tpl (printf "%s" $ingressUrl ) . -}}
  {{- end -}}
{{- end -}}


