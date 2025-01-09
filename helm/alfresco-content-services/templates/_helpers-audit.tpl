{{/*
Get Alfresco Audit Storage URL for testing
*/}}
{{- define "alfresco-content-services.audit.serviceName" -}}
{{- with (index .Values "alfresco-audit-storage") }}
  {{- if .enabled }}
    {{- $aasCtx := dict "Values" . "Chart" $.Chart "Release" $.Release }}
    {{- $aasServiceName := include "alfresco-audit-storage.fullname" $aasCtx }}
    {{- $aasServicePort := .service.port | toString }}
    {{- printf "http://%s:%s" $aasServiceName $aasServicePort }}
  {{- end }}
{{- end }}
{{- end }}
