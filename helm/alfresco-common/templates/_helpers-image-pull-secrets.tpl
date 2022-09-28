{{- define "alfresco-content-services.imagePullSecrets" }}
{{- if .Values.global.alfrescoRegistryPullSecrets }}
imagePullSecrets:
  - name: {{ .Values.global.alfrescoRegistryPullSecrets }}
{{- end }}
{{- end }}
