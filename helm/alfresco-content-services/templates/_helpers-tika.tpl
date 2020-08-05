{{- define "tika.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-tika
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "tika.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "tika.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
