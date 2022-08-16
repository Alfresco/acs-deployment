{{- define "alfresco-content-services.imagePullSecrets" }}
    {{- if .Values.global.alfrescoRegistryPullSecrets }}
    # only set this secret if a private docker registry variable is defined
    imagePullSecrets:
        - name: {{ .Values.global.alfrescoRegistryPullSecrets }}
    {{- end }}
{{- end }}