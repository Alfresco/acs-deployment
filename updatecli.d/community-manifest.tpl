---
name: Images updates for ACS community

{{- define "wip_suffix" -}}
  (\.[0-9]+)*(-[AM]\.?[0-9]+)?
{{- end }}

scms:

sources:
  repositoryTag:
    name: ACS repository tag
    kind: dockerimage
    spec:
      image: alfresco/alfresco-content-repository-community
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "acs" "version" }}{{ template "wip_suffix" }}$
  shareTag:
    name: Share repository tag
    kind: dockerimage
    spec:
      image: alfresco/alfresco-share
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "share" "version" }}{{ template "wip_suffix" }}$

targets:
  repositoryCompose:
    name: Repo image tag
    kind: yaml
    sourceid: repositoryTag
    transformers:
      - addprefix: "alfresco/alfresco-content-repository-community:"
    spec:
      file: {{ .acs.compose_target }}
      key: >-
        {{ .acs.compose_key }}
  shareCompose:
    name: Share image tag
    kind: yaml
    sourceid: shareTag
    transformers:
      - addprefix: "alfresco/alfresco-share:"
    spec:
      file: {{ .share.compose_target }}
      key: >-
        {{ .share.compose_key }}
