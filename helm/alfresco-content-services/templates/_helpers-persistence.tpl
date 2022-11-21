{{- define "data_volume" -}}
{{- $svc_name := .service.name -}}
{{- with .persistence -}}
{{- $sc_name := default .storageClass.name "default" . -}}
- name: data
  persistentVolumeClaim:
    claimName: >-
      {{ .existingClaim | default .name (printf "%s-%s" $svc_name $sc_name ) }}
{{- end -}}
{{- end -}}

{{- define "component_pvc" -}}
{{ $svc_name := .service.name }}
{{- with .persistence }}
{{ $sc_name := default .storageClass.name "default" . }}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ default .name (printf "%s-%s" $svc_name $sc_name) }}
  spec:
    {{- if .storageClass.enabled }}
    accessModes:
    {{- range .storageClass.accessModes }}
      - {{ . }}
    {{- end }}
    storageClassName: {{ .storageClass.name | default "null" }}
    {{- end }}
    resources:
      requests:
        storage: {{ default .baseSize "20Gi" . }}
{{- end -}}
{{- end -}}
