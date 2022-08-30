{{- define "alfresco-content-services.imagePullSecrets" }}
{{- if .Values.global.alfrescoRegistryPullSecrets }}
imagePullSecrets:
  - name: {{ .Values.global.alfrescoRegistryPullSecrets }}
  {{- if .Values.global.registryPullSecrets }}
  {{- range $secret := .Values.global.registryPullSecrets }}
  - name: {{ $secret }}
  {{- end }}
  {{- end }}
{{- end }}
{{- end }}
