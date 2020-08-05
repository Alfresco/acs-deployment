{{- define "repository.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-repository
release: {{ .Release.Name }}
component: repository
{{- end }}

{{- define "repository.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "repository.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
