{{- define "ooi-service.selectorLabels" -}}
app: {{ template "content-services.shortname" . }}-ooi-service
release: {{ .Release.Name }}
component: ooi-service
{{- end }}

{{- define "ooi-service.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "ooi-service.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
