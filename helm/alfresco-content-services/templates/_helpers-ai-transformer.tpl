{{- define "ai-transformer.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-ai-transformer
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "ai-transformer.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "ai-transformer.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
