{{- define "imagemagick.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-imagemagick
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "imagemagick.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "imagemagick.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
