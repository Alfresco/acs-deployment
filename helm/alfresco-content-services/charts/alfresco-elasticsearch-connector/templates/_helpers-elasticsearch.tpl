{{- define "spring.elasticsearch.config" -}}
  SPRING_ELASTICSEARCH_REST_URIS: "{{ .Values.elasticsearch.protocol | default .Values.global.elasticsearch.protocol }}://{{ .Values.elasticsearch.host | default .Values.global.elasticsearch.host }}:{{ .Values.elasticsearch.port | default .Values.global.elasticsearch.port }}"
{{- end -}}
