{{- define "url.builder" -}}
{{- if or (and (eq .protocol "https") (eq .port "443")) (and (eq .protocol "http") (eq .port "80")) -}}
{{ .protocol }}://{{ .host }}
{{- else -}}
{{ .protocol }}://{{ .host }}:{{ .port }}
{{- end -}}
{{- end -}}
