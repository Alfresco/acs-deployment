{{/*
Define annotations as provided in values
*/}}
{{- define "ingress_annotations" }}
{{- range $annotation, $value := .ingress.annotations }}
  {{- if ne $annotation "nginx.ingress.kubernetes.io/server-snippet" }}
  {{- $annotation | nindent 4 }}: |
    {{- $value | nindent 6 }}
  {{- end }}
{{- end }}
{{- end }}
{{/*
Define required annotations for secure nginx ingress
*/}}
{{- define "ingress_vhost_annotations" }}
{{- if index .ingress.annotations "nginx.ingress.kubernetes.io/server-snippet" }}
  {{- range $annotation, $value := .ingress.annotations }}
    {{- if eq $annotation "nginx.ingress.kubernetes.io/server-snippet" }}
    nginx.ingress.kubernetes.io/server-snippet: |
      {{- $value | nindent 6 }}
    {{- end }}
  {{- end }}
{{- else }}
    nginx.ingress.kubernetes.io/server-snippet: |
{{- end }}
      location ~ ^/.*/(wc)?s(ervice)?/api/solr/.*$ {return 403;}
      location ~ ^/.*/proxy/.*/api/solr/.*$ {return 403;}
      location ~ ^/.*/-default-/proxy/.*/api/.*$ {return 403;}
      location ~ ^/.*/s/prometheus$ {return 403;}
{{- end }}
