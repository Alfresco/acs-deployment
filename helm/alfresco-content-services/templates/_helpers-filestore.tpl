{{- define "filestore.selectorLabels" -}}
app: {{ template "alfresco.shortname" . }}-filestore
release: {{ .Release.Name }}
component: transformers
{{- end }}

{{- define "filestore.labels" -}}
chart: {{ include "content-services.chart" . }}
{{ include "filestore.selectorLabels" . }}
heritage: {{ .Release.Service }}
{{- end }}
