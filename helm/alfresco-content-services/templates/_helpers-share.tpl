{{- define "share.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-share
release: {{ .Release.Name }}
component: share
{{- end }}

{{- define "share.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "share.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
