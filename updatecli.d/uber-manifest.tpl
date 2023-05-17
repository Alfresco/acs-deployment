---
title: Images updates for all versions of Helm charts and Docker compose

{{- define "quay_auth" }}
      username: {{ requiredEnv "QUAY_USERNAME" }}
      password: {{ requiredEnv "QUAY_PASSWORD" }}
{{- end }}

scms:
  ourRepo:
    kind: github
    spec:
      user: {{ requiredEnv "GIT_AUTHOR_USERNAME" }}
      email: {{ requiredEnv "GIT_AUTHOR_EMAIL" }}
      owner: Alfresco
      repository: acs-deployment
      branch: {{ requiredEnv "GIT_BRANCH" }}
      username: alfresco-build
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

actions:
  default:
    kind: github/pullrequest
    scmid: ourRepo
    spec:
      title: "{{ requiredEnv "JIRA_ID" }} Bump component versions"
      draft: true
      labels:
        - updatecli

sources:
  {{- if index . "adminApp" }}
  adminAppTag:
    name: Alfresco admin application tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-control-center
      {{ template "quay_auth" }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "adminApp" "version" }}{{ index . "adminApp" "pattern" }}$
  {{- end }}
  {{- if index . "adw" }}
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
  {{- end }}
  {{ $repo_image := index . "acs" "image" }}
  repositoryTag:
    name: ACS repository tag
    kind: dockerimage
    spec:
      image: {{ $repo_image }}
      {{ if eq (printf "%.8s" $repo_image) "quay.io/" }}
      {{ template "quay_auth" }}
      {{ end }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "acs" "version" }}{{ index . "acs" "pattern" }}$
  {{- if index . "search-enterprise" }}
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
  {{- if index . "search" }}
  {{ $search_image := index . "search" "image" }}
  searchTag:
    name: Alfresco Search Services
    kind: dockerimage
    spec:
      image: {{ $search_image }}
      {{ if eq (printf "%.8s" $search_image) "quay.io/" }}
      {{ template "quay_auth" }}
      {{ end }}
      versionFilter:
        kind: semver
        pattern: >-
          {{ index . "search" "version" }}
  {{- end }}
  {{ $share_image := index . "share" "image" }}
  shareTag:
    name: Share repository tag
    kind: dockerimage
    spec:
      image: {{ $share_image }}
      {{ if eq (printf "%.8s" $share_image) "quay.io/" }}
      {{ template "quay_auth" }}
      {{ end }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "share" "version" }}{{ index . "share" "pattern" }}$
  {{- if index . "sync" }}
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
  {{- end }}
  {{- if index . "onedrive" }}
  onedriveTag:
    name: Onedrive (OOI) Service image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-ooi-service
      {{ template "quay_auth" }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "onedrive" "version" }}{{ index . "onedrive" "pattern" }}$
  {{- end }}
  {{- if index . "msteams" }}
  msteamsTag:
    name: MS Teams Service image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-ms-teams-service
      {{ template "quay_auth" }}
      versionFilter:
        kind: regex
        pattern: >-
          ^{{ index . "msteams" "version" }}{{ index . "msteams" "pattern" }}$
  {{- end }}
  {{- if index . "intelligence" }}
  intelligenceTag:
    name: Intelligence Service image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-ai-docker-engine
      {{ template "quay_auth" }}
      versionFilter:
        kind: semver
        pattern: >-
          {{ index . "intelligence" "version" }}
  {{- end }}
  {{- if index . "trouter" }}
  trouterTag:
    name: Alfresco Transform Router image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-transform-router
      {{ template "quay_auth" }}
      versionFilter:
        kind: semver
        pattern: >-
          {{ index . "trouter" "version" }}
  {{- end }}
  {{- if index . "tengine-aio" }}
  tengine-aioTag:
    name: Alfresco All-In-One Transform Engine image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-transform-core-aio
      {{ template "quay_auth" }}
      versionFilter:
        kind: semver
        pattern: >-
          {{ index . "tengine-aio" "version" }}
  {{- end }}
  {{- if index . "tengine-misc" }}
  tengine-miscTag:
    name: Alfresco misc Transform Engine image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-transform-misc
      {{ template "quay_auth" }}
      versionFilter:
        kind: semver
        pattern: >-
          {{ index . "tengine-misc" "version" }}
  {{- end }}
  {{- if index . "tengine-im" }}
  tengine-imTag:
    name: Alfresco ImageMagick Transform Engine image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-imagemagick
      {{ template "quay_auth" }}
      versionFilter:
        kind: semver
        pattern: >-
          {{ index . "tengine-im" "version" }}
  {{- end }}
  {{- if index . "tengine-lo" }}
  tengine-loTag:
    name: Alfresco LibreOffice Transform Engine image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-libreoffice
      {{ template "quay_auth" }}
      versionFilter:
        kind: semver
        pattern: >-
          {{ index . "tengine-lo" "version" }}
  {{- end }}
  {{- if index . "tengine-pdf" }}
  tengine-pdfTag:
    name: Alfresco PDF Transform Engine image tag
    kind: dockerimage
    spec:
      image: quay.io/alfresco/alfresco-pdf-renderer
      {{ template "quay_auth" }}
      versionFilter:
        kind: semver
        pattern: >-
          {{ index . "tengine-pdf" "version" }}
  {{- end }}


targets:
  {{- if index . "adminApp" }}
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
  {{- end }}
  {{- if index . "adw" }}
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
  {{- end }}
  repositoryCompose:
    name: Repo image tag
    kind: yaml
    scmid: ourRepo
    sourceid: repositoryTag
    transformers:
      - addprefix: "{{ index . "acs" "image" }}:"
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
  {{- if index . "search" }}
  searchCompose:
    name: search image tag
    kind: yaml
    scmid: ourRepo
    sourceid: searchTag
    transformers:
      - addprefix: "{{ index . "search" "image" }}:"
    spec:
      file: {{ .search.compose_target }}
      key: >-
        {{ .search.compose_key }}
  {{- if and .search.helm_target .search.helm_key }}
  searchValues:
    name: search image tag
    kind: yaml
    scmid: ourRepo
    sourceid: searchTag
    spec:
      file: {{ .search.helm_target }}
      key: >-
        {{ .search.helm_key }}
  {{- end }}
  {{- end }}
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
  {{- if index . "search-enterprise" "helm_target" }}
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
  {{- end }}
  shareCompose:
    name: Share image tag
    kind: yaml
    scmid: ourRepo
    sourceid: shareTag
    transformers:
      - addprefix: "{{ index . "share" "image" }}:"
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
  {{- if index . "onedrive" }}
  onedriveValues:
    name: Onedrive image tag
    kind: yaml
    scmid: ourRepo
    sourceid: onedriveTag
    spec:
      file: {{ .onedrive.helm_target }}
      key: >-
        {{ .onedrive.helm_key }}
  {{- end }}
  {{- if index . "msteams" }}
  msteamsValues:
    name: MS Teams image tag
    kind: yaml
    scmid: ourRepo
    sourceid: msteamsTag
    spec:
      file: {{ .msteams.helm_target }}
      key: >-
        {{ .msteams.helm_key }}
  {{- end }}
  {{- if index . "intelligence" }}
  intelligenceValues:
    name: Alfresco Intelligence image tag
    kind: yaml
    scmid: ourRepo
    sourceid: intelligenceTag
    spec:
      file: {{ .intelligence.helm_target }}
      key: >-
        {{ .intelligence.helm_key }}
  {{- end }}
  {{- if index . "trouter" }}
  trouterValues:
    name: Alfresco Transform Router image tag
    kind: yaml
    scmid: ourRepo
    sourceid: trouterTag
    spec:
      file: {{ .trouter.helm_target }}
      key: >-
        {{ .trouter.helm_key }}
  {{- end }}
  {{- if index . "tengine-aio" }}
  tengine-aioCompose:
    name: Alfresco All-In-One Transform Engine image tag
    kind: yaml
    scmid: ourRepo
    sourceid: tengine-aioTag
    transformers:
      - addprefix: "{{ index . "tengine-aio" "image" }}:"
    spec:
      file: {{ index . "tengine-aio" "compose_target" }}
      key: >-
        {{ index . "tengine-aio" "compose_key" }}
  {{- end }}
  {{- if index . "tengine-misc" }}
  tengine-miscValues:
    name: Alfresco misc Transform Engine image tag
    kind: yaml
    scmid: ourRepo
    sourceid: tengine-miscTag
    spec:
      file: {{ index . "tengine-misc" "helm_target" }}
      key: >-
        {{ index . "tengine-misc" "helm_key" }}
  {{- end }}
  {{- if index . "tengine-im" }}
  tengine-imValues:
    name: Alfresco ImageMagick Transform Engine image tag
    kind: yaml
    scmid: ourRepo
    sourceid: tengine-imTag
    spec:
      file: {{ index . "tengine-im" "helm_target" }}
      key: >-
        {{ index . "tengine-im" "helm_key" }}
  {{- end }}
  {{- if index . "tengine-lo" }}
  tengine-loValues:
    name: Alfresco LibreOffice Transform Engine image tag
    kind: yaml
    scmid: ourRepo
    sourceid: tengine-loTag
    spec:
      file: {{ index . "tengine-lo" "helm_target" }}
      key: >-
        {{ index . "tengine-lo" "helm_key" }}
  {{- end }}
  {{- if index . "tengine-pdf" }}
  tengine-pdfValues:
    name: Alfresco PDF Transform Engine image tag
    kind: yaml
    scmid: ourRepo
    sourceid: tengine-pdfTag
    spec:
      file: {{ index . "tengine-pdf" "helm_target" }}
      key: >-
        {{ index . "tengine-pdf" "helm_key" }}
  {{- end }}
  {{- if index . "sync" }}
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
  {{- end }}
