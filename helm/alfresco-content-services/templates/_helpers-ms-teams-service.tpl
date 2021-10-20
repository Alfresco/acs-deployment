{{- define "ms-teams-service.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-ms-teams-service
release: {{ .Release.Name }}
component: msteamsservice
{{- end }}

{{- define "ms-teams-service.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "ms-teams-service.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
