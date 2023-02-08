{{- define "spring.elasticsearch.config" -}}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.elasticsearch.protocol | default .Values.global.elasticsearch.protocol }}://{{ .Values.elasticsearch.host | default .Values.global.elasticsearch.host }}:{{ .Values.elasticsearch.port | default .Values.global.elasticsearch.port }}"
{{- end -}}

{{- define "spring.elasticsearch.env.credentials" -}}
- name: SPRING_ELASTICSEARCH_REST_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ default (printf "%s-elasticsearch-secret" (include "alfresco-elasticsearch-connector.fullName" $)) $.Values.global.elasticsearch.existingSecretName }}
      key: ELASTICSEARCH_USERNAME
- name: SPRING_ELASTICSEARCH_REST_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ default (printf "%s-elasticsearch-secret" (include "alfresco-elasticsearch-connector.fullName" $)) $.Values.global.elasticsearch.existingSecretName }}
      key: ELASTICSEARCH_PASSWORD
{{- end -}}
