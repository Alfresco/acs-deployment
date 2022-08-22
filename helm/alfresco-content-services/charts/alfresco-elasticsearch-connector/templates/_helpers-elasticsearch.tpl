{{- define "spring.elasticsearch.config" -}}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.elasticsearch.protocol | default .Values.global.elasticsearch.protocol }}://{{ .Values.elasticsearch.host | default .Values.global.elasticsearch.host }}:{{ .Values.elasticsearch.port | default .Values.global.elasticsearch.port }}"
  SPRING_ELASTICSEARCH_REST_USERNAME: "{{ .Values.elasticsearch.user | default .Values.global.elasticsearch.user }}"
  SPRING_ELASTICSEARCH_REST_PASSWORD: "{{ .Values.elasticsearch.password  | default .Values.global.elasticsearch.password }}"
{{- end -}}
