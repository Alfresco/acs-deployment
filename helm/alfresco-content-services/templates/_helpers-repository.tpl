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

{{- define "java_tool_option" -}}
  {{- if .Values.global.tracking_secret -}}
    {{- printf "-Dsolr.sharedSecret=%s " .Values.global.tracking_secret -}}
  {{- end -}}
{{- end }}
