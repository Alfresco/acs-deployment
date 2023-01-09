{{- define "default-pod-security-context" }}
    runAsNonRoot: true
    runAsUser: 33099
    fsGroupChangePolicy: OnRootMismatch
{{- end }}

{{- define "default-security-context" }}
    runAsNonRoot: true
    allowPrivilegeEscalation: false
    capabilities:
      drop:
        - NET_RAW
        - ALL
{{- end }}

{{- define "component-pod-security-context" }}
  securityContext:
{{- if .podSecurityContext }}
    {{- .podSecurityContext | toYaml | nindent 4 }}
{{- else }}
{{- include "default-pod-security-context" . }}
{{- end }}
{{- end }}

{{- define "component-security-context" }}
  securityContext:
{{- if .securityContext }}
  {{- .securityContext | toYaml | nindent 4 }}
{{- else }}
{{- include "default-security-context" . }}
{{- end }}
{{- end }}
