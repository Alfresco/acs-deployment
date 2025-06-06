---
title: acs-sso-example
parent: Charts
grand_parent: Helm
---

# acs-sso-example

![Version: 1.3.1](https://img.shields.io/badge/Version-1.3.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 25.1.0](https://img.shields.io/badge/AppVersion-25.1.0-informational?style=flat-square)

An example Chart to demonstrate how to compose your own Alfresco platform
with SSO on kubernetes using a nthrid party Keycloak.
if you're familiar with [Helm](ttps://helm.sh) &
[Kubernetes](https://kubernetes.io) taking a look at the `values.yaml` should
be enough but the principals are also documented in two differents steps:

* Composing your ACS from individual component charts we provide.
  Check the [step by step documentation](./docs/step-by-step-guide.md)
* SSO integration, to add keycloak and configure Alfresco applications
  accordingly: [SSO guide](./docs/sso-guide.md)

> Note: this chart is just an example that can run on a localhost only.
> It ships ACS repo, the repository database, the message broker, the
> Keycloak IdP and front end applications (Share and Content app) & no other
> component.

:warning: All components have persistence disabled so all data is lost after a
deployment is destroyed or rolled back!

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/acs-deployment>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.6.2 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-content-app(alfresco-adf-app) | 0.2.2 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-repository | 0.9.4 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-share | 1.3.1 |
| https://codecentric.github.io/helm-charts | keycloakx | 6.0.0 |
| oci://registry-1.docker.io/bitnamicharts | repository-database(postgresql) | 13.4.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| activemq | object | check values.yaml | Configure the ACS ActiveMQ message broker as per https://github.com/Alfresco/alfresco-helm-charts/tree/activemq-3.4.1/charts/activemq |
| alfresco-content-app | object | check values.yaml | Configure the Alfresco Conent-app as per https://github.com/Activiti/activiti-cloud-common-chart/tree/8.2.0/charts/common |
| alfresco-repository | object | check values.yaml | Configure the ACS repository as per https://github.com/Alfresco/alfresco-helm-charts/tree/alfresco-repository-0.1.3/charts/alfresco-repository |
| alfresco-share | object | check values.yaml | Configure the Alfresco Share as per https://github.com/Alfresco/alfresco-helm-charts/tree/alfresco-share-0.3.0/charts/alfresco-share |
| global.known_urls | list | `["http://localhost"]` | list of trusted URLs. URLs a re used to configure Cross-origin protections Also the first entry is considered the main hosting domain of the platform. |
| keycloakx | object | check values.yaml | Configure the ACS Keycloak Identity provider as per https://github.com/codecentric/helm-charts/tree/keycloakx-2.3.0 |
| keycloakx.admin.password | string | random ascii string | Keycloak admin password. By default generated on first deployment, to get its value use:<br> <code>kubectl get secrets keycloak -o jsonpath='{@.data.KC_BOOTSTRAP_ADMIN_PASSWORD}' | base64 -d</code> |
| keycloakx.admin.realm[0] | object | `{"clients":[{"clientId":"alfresco","enabled":true,"implicitFlowEnabled":true,"publicClient":true,"redirectUris":"{{- $redirectUris := list }} {{- range (index (include \"alfresco-common.known.urls\" $ | mustFromJson) \"known_urls\") }} {{- $redirectUris = append $redirectUris (printf \"%s/*\" .) }} {{- end }} {{- $redirectUris }}","standardFlowEnabled":true,"webOrigins":"{{ index (include \"alfresco-common.known.urls\" $ | mustFromJson) \"known_urls\" }}"}],"defaultLocale":"en","enabled":true,"id":"alfresco","internationalizationEnabled":true,"loginTheme":"alfresco","realm":"alfresco","sslRequired":"none","supportedLocales":["ca","de","en","es","fr","it","ja","lt","nl","no","pt-BR","ru","sv","zh-CN"],"users":[{"credentials":[{"type":"password","value":"secret"}],"email":"admin@example.org","enabled":true,"firstName":"admin","lastName":"admin","username":"admin"}]}` | Alfresco Realm definition |
| keycloakx.admin.realm[0].users[0] | object | `{"credentials":[{"type":"password","value":"secret"}],"email":"admin@example.org","enabled":true,"firstName":"admin","lastName":"admin","username":"admin"}` | default Alfresco admin user |
| keycloakx.admin.realm[0].users[0].credentials[0].value | string | `"secret"` | default Alfresco admin password |
| keycloakx.admin.username | string | `"admin"` | Keycloak admin username |
| repository-database | object | check values.yaml | Configure the ACS repository Postgres database as per https://github.com/bitnami/charts/tree/002c752f871c8fa068a770dc80fec4cf798798ab/bitnami/postgresql |
