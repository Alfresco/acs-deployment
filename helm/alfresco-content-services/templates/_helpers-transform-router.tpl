{{- define "transform-router.selectorLabels" -}}
app: {{ template "alfresco.shortname" . }}-router
release: {{ .Release.Name }}
component: transformrouter
{{- end }}

{{- define "transform-router.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "transform-router.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
