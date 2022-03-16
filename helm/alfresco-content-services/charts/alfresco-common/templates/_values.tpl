{{/*
Renders a value that contains template.
Usage:
{{ include "common.values.tpl" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "common.values.tpl" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}
