{{- define "data_volume" -}}
{{- $svc_name := .service.name -}}
{{- with .persistence -}}
{{- $sc_name := .storageClass | default "default" -}}
- name: data
  persistentVolumeClaim:
    claimName: >-
      {{ .existingClaim | default (printf "%s-%s-pvc" $svc_name $sc_name ) }}
{{- end -}}
{{- end -}}

{{- define "component_pvc" -}}
{{ $svc_name := .service.name }}
{{- with .persistence }}
{{- $sc_name := .storageClass | default "default" -}}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ printf "%s-%s-pvc" $svc_name $sc_name }}
spec:
  {{- if .storageClass }}
  storageClassName: {{ .storageClass | quote }}
  {{- end }}
  {{- if .accessModes }}
  accessModes:
  {{- range .accessModes }}
    - {{ . }}
  {{- end }}
  {{- end }}
  volumeMode: {{ .volumeMode | default "Filesystem" }}
  resources:
    requests:
      storage: {{ .baseSize | default "20Gi" | quote }}
{{- end }}
{{- end -}}
