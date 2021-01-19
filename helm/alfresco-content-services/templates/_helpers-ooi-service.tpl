{{- define "ooi-service.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-ooi-service
release: {{ .Release.Name }}
component: ooiservice
{{- end }}

{{- define "ooi-service.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "ooi-service.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
