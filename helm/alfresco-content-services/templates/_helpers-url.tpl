{{- define "alf.protocol" -}}
{{ .Values.externalProtocol | default "http" }}
{{- end -}}

{{- define "alf.repo.host" -}}
{{ .Values.externalHost | default (printf "%s-repository" (include "content-services.shortname" .)) }}
{{- end -}}

{{- define "alf.repo.port" -}}
{{ .Values.externalPort | default .Values.repository.service.externalPort | toString }}
{{- end -}}

{{- define "alf.share.host" -}}
{{ .Values.externalHost | default (printf "%s-share" (include "content-services.shortname" .)) }}
{{- end -}}

{{- define "alf.share.port" -}}
{{ .Values.externalPort | default .Values.share.service.externalPort | toString }}
{{- end -}}

{{- define "url.builder" -}}
{{- if or (and (eq .protocol "https") (eq .port "443")) (and (eq .protocol "http") (eq .port "80")) -}}
{{ .protocol }}://{{ .host }}
{{- else -}}
{{ .protocol }}://{{ .host }}:{{ .port }}
{{- end -}}
{{- end -}}
