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

{{- define "repo.url" -}}
{{- include "url.builder" (dict "protocol" (include "alf.protocol" $) "host" (include "alf.repo.host" $) "port" (include "alf.repo.port" $) ) }}
{{- end -}}

{{- define "share.url" -}}
{{- include "url.builder" (dict "protocol" (include "alf.protocol" $) "host" (include "alf.share.host" $) "port" (include "alf.share.port" $) ) }}
{{- end -}}

{{- define "url.builder" -}}
{{- if or (and (eq .protocol "https") (eq .port "443")) (and (eq .protocol "http") (eq .port "80")) -}}
{{ .protocol }}://{{ .host }}
{{- else -}}
{{ .protocol }}://{{ .host }}:{{ .port }}
{{- end -}}
{{- end -}}
