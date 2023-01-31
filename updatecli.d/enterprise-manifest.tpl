---
title: Images updates for ACS latest

{{- define "quay_auth" }}
      username: {{ requiredEnv "QUAY_USERNAME" }}
      password: {{ requiredEnv "QUAY_PASSWORD" }}
{{- end }}

scms:
  ourRepo:
    kind: github
    spec:
      user: alfresco-build
      email: alfresco-build@hyland.com
      username: alfresco-build
      owner: Alfresco
      repository: acs-deployment
      branch: master
      token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
  searchEnterprise:
    name: Alfresco Elasticsearch connector
    kind: github
    spec:
      owner: Alfresco
      repository: alfresco-elasticsearch-connector
      branch: master
      username: alfresco-build
      token: {{ requiredEnv "UPDATECLI_GITHUB_TOKEN" }}
      directory: /tmp/updatecli/searchEnterprise

sources:
  syncTag:
    name: Sync Service image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/service-sync
      {{ template "quay_auth" }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "sync" "version" }}{{ index . "sync" "pattern" }}$
  adwTag:
    name: Alfresco Digital Workspace tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-digital-workspace
      {{ template "quay_auth" }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "adw" "version" }}{{ index . "adw" "pattern" }}$
  {{ if index . "search-enterprise" }}
  searchEnterpriseTag:
    name: Search Enterprise tag
    kind: gittag
    scmid: searchEnterprise
    spec:
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "search-enterprise" "version" }}{{ index . "search-enterprise" "pattern" }}$
  {{ end }}
  repositoryTag:
    name: ACS repository tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-content-repository
      {{ template "quay_auth" }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "acs" "version" }}{{ index . "acs" "pattern" }}$
  shareTag:
    name: Share repository tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-share
      {{ template "quay_auth" }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "share" "version" }}{{ index . "share" "pattern" }}$
  {{ if index . "adminApp" }}
  adminAppTag:
    name: Alfresco admin application tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-admin-app
      {{ template "quay_auth" }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "adminApp" "version" }}{{ index . "adminApp" "pattern" }}$
  {{ end }}

actions:
  default:
    kind: github/pullrequest
    scmid: ourRepo
    spec:
      title: "{{ requiredEnv "JIRA_ID" }} Bump component versions"
      draft: true
      labels:
        - updatecli

targets:
  repositoryCompose:
    name: Repo image tag
    kind: yaml
    scmid: ourRepo
    sourceid: repositoryTag
    transformers:
      - addprefix: "quay.io/alfresco/alfresco-content-repository:"
    spec:
      file: {{ .acs.compose_target }}
      key: >-
        {{ .acs.compose_key }}
  repositoryValues:
    name: Repo image tag
    kind: yaml
    scmid: ourRepo
    sourceid: repositoryTag
    spec:
      file: {{ .acs.helm_target }}
      key: >-
        {{ .acs.helm_key }}
  shareCompose:
    name: Share image tag
    kind: yaml
    scmid: ourRepo
    sourceid: shareTag
    transformers:
      - addprefix: "quay.io/alfresco/alfresco-share:"
    spec:
      file: {{ .share.compose_target }}
      key: >-
        {{ .share.compose_key }}
  shareValues:
    name: Share image tag
    kind: yaml
    scmid: ourRepo
    sourceid: shareTag
    spec:
      file: {{ .share.helm_target }}
      key: >-
        {{ .share.helm_key }}
  syncCompose:
    name: Sync image tag
    kind: yaml
    scmid: ourRepo
    sourceid: syncTag
    transformers:
      - addprefix: "quay.io/alfresco/service-sync:"
    spec:
      file: {{ .sync.compose_target }}
      key: >-
        {{ .sync.compose_key }}
  syncValues:
    name: Sync image tag
    kind: yaml
    scmid: ourRepo
    sourceid: syncTag
    spec:
      file: {{ .sync.helm_target }}
      key: >-
        {{ .sync.helm_key }}
  {{- if index . "search-enterprise" }}
  {{- if index . "search-enterprise" "compose_target" }}
  searchEnterpriseCompose:
    name: Search Enterprise image tag
    kind: yaml
    scmid: ourRepo
    sourceid: searchEnterpriseTag
    transformers:
      - addprefix: "quay.io/alfresco/alfresco-elasticsearch-live-indexing:"
    spec:
      file: {{ index . "search-enterprise" "compose_target" }}
      key: >-
        {{ index . "search-enterprise" "compose_key" }}
  {{- end }}
  {{- $target_searchEnt := index . "search-enterprise" "helm_target" }}
  searchEnterpriseReindexingValues:
    name: Search Enterprise image tag
    kind: yaml
    scmid: ourRepo
    sourceid: searchEnterpriseTag
    spec:
      file: {{ $target_searchEnt }}
      key: {{ index . "search-enterprise" "helm_keys" "Reindexing" }}
  {{- range $key, $value := index . "search-enterprise" "helm_keys" "Liveindexing" }}
  searchEnterprise{{ $key }}Values:
    name: Search Enterprise image tag
    kind: yaml
    scmid: ourRepo
    sourceid: searchEnterpriseTag
    spec:
      file: {{ $target_searchEnt }}
      key: {{ $value }}
  {{- end }}
  {{- end }}
  adwCompose:
    name: ADW image tag
    kind: yaml
    scmid: ourRepo
    sourceid: adwTag
    transformers:
      - addprefix: "quay.io/alfresco/alfresco-digital-workspace:"
    spec:
      file: {{ .adw.compose_target }}
      key: >-
        {{ .adw.compose_key }}
  adwValues:
    name: ADW image tag
    kind: yaml
    scmid: ourRepo
    sourceid: adwTag
    spec:
      file: {{ .adw.helm_target }}
      key: >-
        {{ .adw.helm_key }}
  {{ if index . "adminApp" }}
  adminAppCompose:
    name: Alfresco Control Center
    kind: yaml
    scmid: ourRepo
    sourceid: adminAppTag
    transformers:
      - addprefix: "quay.io/alfresco/alfresco-admin-app:"
    spec:
      file: {{ .adminApp.compose_target }}
      key: >-
        {{ .adminApp.compose_key }}
  adminAppValues:
    name: Helm chart default values file
    kind: yaml
    scmid: ourRepo
    sourceid: adminAppTag
    spec:
      file: {{ .adminApp.helm_target }}
      key: >-
        {{ .adminApp.helm_key }}
  {{ end }}
