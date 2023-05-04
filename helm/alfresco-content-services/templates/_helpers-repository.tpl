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

{{/*
Get Alfresco Repository Service Port ("external")
*/}}
{{- define "repository.svcPort" -}}
{{- $defaultSvcPort := 80 }}
{{- if hasKey .Values.repository "service" }}
  {{- coalesce .Values.repository.service.externalPort $defaultSvcPort | int }}
{{- else }}
  {{- $defaultSvcPort | int }}
{{- end }}
{{- end -}}

{{/*
Get Alfresco Repository container Port ("internal")
*/}}
{{- define "repository.containerPort" -}}
{{- .Values.repository.image.internalPort | default 8080 | int }}
{{- end -}}
