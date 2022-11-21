{{- define "data_volume" -}}
{{- $svc_name := .service.name -}}
{{- with .persistence -}}
{{- $sc_name := .storageClass.name | default "default" -}}
- name: data
  persistentVolumeClaim:
    claimName: >-
      {{ .existingClaim | default (printf "%s-%s-pvc" $svc_name $sc_name ) }}
{{- end -}}
{{- end -}}

{{- define "component_pvc" -}}
{{ $svc_name := .service.name }}
{{- with .persistence }}
{{- $sc_name := .storageClass.name | default "default" -}}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ printf "%s-%s-pvc" $svc_name $sc_name }}
spec:
  {{- if .storageClass.enabled }}
  volumeMode: {{ .storageClass.volumeMode | default "Filesystem" }}
  accessModes:
  {{- range .storageClass.accessModes }}
    - {{ . }}
  {{- end }}
  storageClassName: {{ .storageClass.name | default "null" }}
  {{- end }}
  resources:
    requests:
      storage: {{ .baseSize | default "20Gi" }}
{{- end }}
{{- end -}}
