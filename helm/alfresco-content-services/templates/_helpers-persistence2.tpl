{{- define "data_volume2" -}}
{{- $svc_name2 := .service.name -}}
{{- with .persistence -}}
{{- $sc_name2 := .storageClass | default "default" -}}
- name: data
  persistentVolumeClaim:
    claimName: >-
      {{ .existingClaim | default (printf "%s-%s-pvc" $svc_name $sc_name ) }}
{{- end -}}
{{- end -}}

{{- define "component_pvc2" -}}
{{ $svc_name2 := .service.name }}
{{- with .persistence }}
{{- $sc_name := .storageClass | default "default" -}}
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
   name: {{ printf "%s-%s-pvc" $svc_name2 $sc_name2 }}
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
      storage: {{ .baseSize | default "20Gi" }}
{{- end }}
{{- end -}}
