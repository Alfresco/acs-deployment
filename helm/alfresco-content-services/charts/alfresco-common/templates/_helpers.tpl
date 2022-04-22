{{- define "content-services.shortname" -}}
{{- $name := (.Values.NameOverride | default (printf "%s" "alfresco-cs")) -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "alfresco.shortname" -}}
{{- $name := (.Values.NameOverride | default (printf "%s" "alfresco-")) -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
