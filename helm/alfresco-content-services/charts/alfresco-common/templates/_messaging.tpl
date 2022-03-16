{{/* Validate values of Activiti Cloud - Messaging System */}}
{{- define "common.messaging.validateValues" -}}
{{- if not (hasKey .Values.global .Values.global.messaging.broker) -}}
{{- required "\nActiviti Cloud: Messaging System\nYou can only use supported messaging system.\nPlease enable only 'rabbitmq` or 'kafka' as messaging system.\n" nil -}}
{{- end -}}
{{- end -}}

{{/*
  Create SPRING_RABBITMQ_* env.
*/}}
{{- define "common.messaging.rabbitmq-env" -}}
- name: ACTIVITI_CLOUD_MESSAGING_BROKER
  value: rabbitmq
- name: SPRING_RABBITMQ_HOST
  value: {{ tpl .Values.rabbitmq.host $ | required "rabbitmq.host is required" }}
{{- if tpl .Values.rabbitmq.username $ }}
- name: SPRING_RABBITMQ_USERNAME
  value: {{ tpl .Values.rabbitmq.username $ }}
{{- end }}
{{- if tpl .Values.rabbitmq.password $ }}
- name: SPRING_RABBITMQ_PASSWORD
  value: {{ tpl .Values.rabbitmq.password $ }}
{{- end }}
{{ tpl .Values.rabbitmq.extraEnv $ }}
{{- end -}}

{{/*
  Create SPRING_CLOUD_STREAM_KAFKA_* env.
*/}}
{{- define "common.messaging.kafka-env" -}}
- name: ACTIVITI_CLOUD_MESSAGING_BROKER
  value: kafka
- name:  SPRING_CLOUD_STREAM_KAFKA_BINDER_BROKERS
  value: {{ tpl .Values.kafka.brokers $ | required "kafka.brokers is required" }}
- name:  SPRING_CLOUD_STREAM_KAFKA_BINDER_DEFAULTBROKERPORT
  value: {{ tpl .Values.kafka.port $ | default "9092" | quote }}
{{ tpl .Values.kafka.extraEnv $ }}
{{- end -}}
