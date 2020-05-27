{{- define "pdfrenderer.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-pdfrenderer
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "pdfrenderer.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "pdfrenderer.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
