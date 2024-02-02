# acs-sso-example

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 23.2.0-A12](https://img.shields.io/badge/AppVersion-23.2.0--A12-informational?style=flat-square)

An example Chart to demonstrate how to compose your own Alfresco platform
with SSO on kubernetes using a nthrid party Keycloak.
if you're familiar with [Helm](ttps://helm.sh) &
[Kubernetes](https://kubernetes.io) taking a look at the `values.yaml` should
be enough but the principals are also documented in two differents steps:

* Composing your ACS from individual component charts we provide.
  Check the [step by step documentation](./docs/step-by-step-guide.md)
* SSO integration, to add keycloak and configure Alfresco applications
  accordingly: [SSO guide](./docs/step-by-step-guide.md)

> Note: this chart is just an example that can run on a localhost only.
> It ships ACS repo, the repository database, the message broker, the
> Keycloak IdP and front end applications (Share and Content app) & no other
> component.

:warning: All components have persistence disabled so all data is lost after a
deployment is destroyed or rolled back!

**Homepage:** <https://www.alfresco.com>

## Source Code

* <https://github.com/Alfresco/acs-deployment/helm/acs-sso-example>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://activiti.github.io/activiti-cloud-helm-charts | alfresco-content-app(common) | 8.2.0 |
| https://alfresco.github.io/alfresco-helm-charts/ | activemq | 3.4.1 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-repository | 0.1.3 |
| https://alfresco.github.io/alfresco-helm-charts/ | alfresco-share | 0.3.0 |
| https://codecentric.github.io/helm-charts | keycloakx | 2.3.0 |
| oci://registry-1.docker.io/bitnamicharts | repository-database(postgresql) | 13.4.0 |

## Values

<table>
	<thead>
		<th>Key</th>
		<th>Type</th>
		<th>Default</th>
		<th>Description</th>
	</thead>
	<tbody>
		<tr>
			<td>activemq</td>
			<td>object</td>
			<td><pre lang="">
check values.yaml
</pre>
</td>
			<td>Configure the ACS ActiveMQ message broker as per https://github.com/Alfresco/alfresco-helm-charts/tree/activemq-3.4.1/charts/activemq</td>
		</tr>
		<tr>
			<td>alfresco-content-app</td>
			<td>object</td>
			<td><pre lang="">
check values.yaml
</pre>
</td>
			<td>Configure the Alfresco Conent-app as per https://github.com/Activiti/activiti-cloud-common-chart/tree/8.2.0/charts/common</td>
		</tr>
		<tr>
			<td>alfresco-repository</td>
			<td>object</td>
			<td><pre lang="">
check values.yaml
</pre>
</td>
			<td>Configure the ACS repository as per https://github.com/Alfresco/alfresco-helm-charts/tree/alfresco-repository-0.1.3/charts/alfresco-repository</td>
		</tr>
		<tr>
			<td>alfresco-share</td>
			<td>object</td>
			<td><pre lang="">
check values.yaml
</pre>
</td>
			<td>Configure the Alfresco Share as per https://github.com/Alfresco/alfresco-helm-charts/tree/alfresco-share-0.3.0/charts/alfresco-share</td>
		</tr>
		<tr>
			<td>global.known_urls</td>
			<td>list</td>
			<td><pre lang="json">
[
  "http://localhost"
]
</pre>
</td>
			<td>list of trusted URLs. URLs a re used to configure Cross-origin protections Also the first entry is considered the main hosting domain of the platform.</td>
		</tr>
		<tr>
			<td>keycloakx</td>
			<td>object</td>
			<td><pre lang="">
check values.yaml
</pre>
</td>
			<td>Configure the ACS Keycloak Identity provider as per https://github.com/codecentric/helm-charts/tree/keycloakx-2.3.0</td>
		</tr>
		<tr>
			<td>keycloakx.admin.password</td>
			<td>string</td>
			<td><pre lang="">
random ascii string
</pre>
</td>
			<td>Keycloak admin password. By default generated on first deployment, to get its value use:<br> <code>kubectl get secrets keycloak -o jsonpath='{@.data.KEYCLOAK_ADMIN_PASSWORD}' | base64 -d</code></td>
		</tr>
		<tr>
			<td>keycloakx.admin.realm[0]</td>
			<td>object</td>
			<td><pre lang="json">
{
  "clients": [
    {
      "clientId": "alfresco",
      "enabled": true,
      "implicitFlowEnabled": true,
      "publicClient": true,
      "redirectUris": "{{- $redirectUris := list }} {{- range (index (include \"alfresco-common.known.urls\" $ | mustFromJson) \"known_urls\") }} {{- $redirectUris = append $redirectUris (printf \"%s/*\" .) }} {{- end }} {{- $redirectUris }}",
      "standardFlowEnabled": true,
      "webOrigins": "{{ index (include \"alfresco-common.known.urls\" $ | mustFromJson) \"known_urls\" }}"
    }
  ],
  "defaultLocale": "en",
  "enabled": true,
  "id": "alfresco",
  "internationalizationEnabled": true,
  "loginTheme": "alfresco",
  "realm": "alfresco",
  "sslRequired": "none",
  "supportedLocales": [
    "ca",
    "de",
    "en",
    "es",
    "fr",
    "it",
    "ja",
    "lt",
    "nl",
    "no",
    "pt-BR",
    "ru",
    "sv",
    "zh-CN"
  ],
  "users": [
    {
      "credentials": [
        {
          "type": "password",
          "value": "secret"
        }
      ],
      "enabled": true,
      "username": "admin"
    }
  ]
}
</pre>
</td>
			<td>Alfresco Realm definition</td>
		</tr>
		<tr>
			<td>keycloakx.admin.realm[0].users[0].credentials[0].value</td>
			<td>string</td>
			<td><pre lang="json">
"secret"
</pre>
</td>
			<td>default Alfresco admin password</td>
		</tr>
		<tr>
			<td>keycloakx.admin.realm[0].users[0].username</td>
			<td>string</td>
			<td><pre lang="json">
"admin"
</pre>
</td>
			<td>default Alfresco admin user</td>
		</tr>
		<tr>
			<td>keycloakx.admin.username</td>
			<td>string</td>
			<td><pre lang="json">
"admin"
</pre>
</td>
			<td>Keycloak admin username</td>
		</tr>
		<tr>
			<td>repository-database</td>
			<td>object</td>
			<td><pre lang="">
check values.yaml
</pre>
</td>
			<td>Configure the ACS repository Postgres database as per https://github.com/bitnami/charts/tree/002c752f871c8fa068a770dc80fec4cf798798ab/bitnami/postgresql</td>
		</tr>
	</tbody>
</table>

