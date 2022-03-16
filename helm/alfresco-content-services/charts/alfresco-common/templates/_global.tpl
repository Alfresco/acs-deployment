{{/* vim: set filetype=mustache: */}}
{{/*
Create a keycloak url template
*/}}
{{- define "common.keycloak-url" -}}
	{{- $common := dict "Values" .Values.common -}}
	{{- $noCommon := omit .Values "common" -}}
	{{- $overrides := dict "Values" $noCommon -}}
	{{- $noValues := omit . "Values" -}}
	{{- with merge $noValues $overrides $common -}}
		{{- $proto := include "common.gateway-proto" . -}}
		{{- $host := include "common.keycloak-host" . -}}
		{{- $path := include "common.keycloak-path" . -}}
		{{- $url := printf "%s://%s%s" $proto $host $path -}}
		{{- $keycloakUrl := default $url .Values.global.keycloak.url -}}
		{{- tpl (printf "%s" $keycloakUrl ) . -}}
	{{- end -}}
{{- end -}}

{{/*
Create a gateway url template
*/}}
{{- define "common.gateway-url" -}}
	{{- $common := dict "Values" .Values.common -}}
	{{- $noCommon := omit .Values "common" -}}
	{{- $overrides := dict "Values" $noCommon -}}
	{{- $noValues := omit . "Values" -}}
	{{- with merge $noValues $overrides $common -}}
		{{- $proto := include "common.gateway-proto" . -}}
		{{- $host := include "common.gateway-host"  . -}}
		{{- $gatewayUrl := printf "%s://%s" $proto $host -}}
		{{- tpl $gatewayUrl . -}}
	{{- end -}}
{{- end -}}

{{- define "common.gateway-proto" -}}
{{- $http := toString .Values.global.gateway.http -}}
{{- if eq $http "false" }}https{{else}}http{{ end -}}
{{- end -}}

{{- define "common.gateway-https-enabled" -}}
{{- $http := toString .Values.global.gateway.http -}}
{{- default "" (eq $http "false") -}}
{{- end -}}

{{- define "common.gateway-host" -}}
{{- $value := default (include "common.gateway-domain" .) .Values.global.gateway.host -}}
{{- tpl (printf "%s" $value) . -}}
{{- end -}}

{{- define "common.gateway-domain" -}}
{{- $value := default "" .Values.global.gateway.domain -}}
{{- tpl (printf "%s" $value) . -}}
{{- end -}}

{{- define "common.keycloak-path" -}}
{{- $value := default "/auth" .Values.global.keycloak.path -}}
{{- tpl (printf "%s" $value) . -}}
{{- end -}}

{{- define "common.keycloak-host" -}}
{{- $value := default (include "common.gateway-host" .) .Values.global.keycloak.host -}}
{{- tpl (printf "%s" $value) . -}}
{{- end -}}

{{- define "common.keycloak-enabled" -}}
{{- default "" .Values.global.keycloak.enabled -}}
{{- end -}}

{{/*
Create default pull secrets
*/}}
{{- define "common.registry-pull-secrets" -}}
{{- $common := dict "Values" .Values.common -}}
{{- $noCommon := omit .Values "common" -}}
{{- $overrides := dict "Values" $noCommon -}}
{{- $noValues := omit . "Values" -}}
{{- $values := merge $noValues $overrides $common -}}
{{- with $values -}}
{{- range $value := .Values.global.registryPullSecrets }}
- name: {{ tpl (printf "%s" $value) $values | quote }}
{{- end }}
{{- range $value := .Values.registryPullSecrets }}
- name: {{ tpl (printf "%s" $value) $values | quote }}
{{- end }}

{{- end }}
{{- end -}}

{{/*
Create a default keycloak realm
*/}}
{{- define "common.keycloak-realm" -}}
	{{- $common := dict "Values" .Values.common -}}
	{{- $noCommon := omit .Values "common" -}}
	{{- $overrides := dict "Values" $noCommon -}}
	{{- $noValues := omit . "Values" -}}
	{{- with merge $noValues $overrides $common -}}
		{{- $value := .Values.global.keycloak.realm -}}
		{{- tpl (printf "%s" $value) . -}}
	{{- end -}}
{{- end -}}

{{/*
Create a default keycloak resource
*/}}
{{- define "common.keycloak-resource" -}}
	{{- $common := dict "Values" .Values.common -}}
	{{- $noCommon := omit .Values "common" -}}
	{{- $overrides := dict "Values" $noCommon -}}
	{{- $noValues := omit . "Values" -}}
	{{- with merge $noValues $overrides $common -}}
		{{- $value := .Values.global.keycloak.resource -}}
		{{- tpl (printf "%s" $value) . -}}
	{{- end -}}
{{- end -}}

{{/*
Create a default extra env templated values
*/}}
{{- define "common.extra-env" -}}
{{- $common := dict "Values" .Values.common -}}
{{- $noCommon := omit .Values "common" -}}
{{- $overrides := dict "Values" $noCommon -}}
{{- $noValues := omit . "Values" -}}
{{- with merge $noValues $overrides $common -}}
{{- tpl .Values.global.keycloak.extraEnv . -}}
{{- tpl .Values.global.extraEnv . -}}
{{- tpl .Values.extraEnv . -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for the postgresql requirement.
*/}}
{{- define "common.postgresql.fullname" -}}
{{- $postgresContext := dict "Values" .Values.postgresql "Release" .Release "Chart" (dict "Name" "postgresql") -}}
{{- if $postgresContext.Values.fullnameOverride -}}
{{- $postgresContext.Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default $postgresContext.Chart.Name $postgresContext.Values.nameOverride -}}
{{- if contains $name $postgresContext.Release.Name -}}
{{- $postgresContext.Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $postgresContext.Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for the kafka requirement.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.kafka.fullname" -}}
{{- if contains "kafka" .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "kafka" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name for the rabbitmq requirement.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.rabbitmq.fullname" -}}
{{- if contains "rabbitmq" .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name "rabbitmq" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
