---
title: Keycloak server
parent: Examples
grand_parent: Helm
---

# ACS Helm Deployment with an external Keycloak server

In this section we are going to describe how to install Alfresco with Helm on
your Kubernetes cluster using an externally provisioned (or third party)
Keycloak server.

## Prerequisites

* Have already created a realm with default settings (e.g. `alfresco`)
* Have already created a client inside the previously mentioned realm with:
  * Implicit flow enabled
  * Redirect URIs and Web Origins appropriately configured for your Alfresco installation

You can further customize the login appearance by applying the
[alfresco keycloak theme](https://github.com/Alfresco/alfresco-keycloak-theme).

## Helm configuration

You can follow your [preferred helm deployment guide](../), but before proceeding with
the `helm install` or `helm upgrade` commands, you need to provide additional values and
a configmap as described below.

### Repository config

Set the following values:

```yaml
config:
  repository:
    additionalGlobalProperties:
      "authentication.chain": identity-service1:identity-service,alfrescoNtlm1:alfrescoNtlm
      "identity-service.authentication.enabled": true
      "identity-service.realm": YOUR-REALM
      "identity-service.auth-server-url": https://ids.example.com
      "identity-service.enable-basic-auth": true
      "alfresco_user_store.adminusername": "admin@alfresco.com"
```

* `alfresco_user_store.adminusername` can be used to override the default admin username,
  in case your realm admin user doesn't match the default `admin` username.

### Share config

Create a configmap which overrides the identity service properties:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: share-properties
data:
  share.properties: |
    aims.enabled=true
    aims.realm = YOUR-REALM
    aims.resource = YOUR-CLIENT-ID
    aims.publicClient = true
    aims.principalAttribute = sub
    aims.authServerUrl = https://ids.example.com
```

And set the following values:

```yaml
share:
  extraVolumes:
    - name: share-properties
      configMap:
        name: share-properties
  extraVolumeMounts:
    - name: share-properties
      mountPath: >-
        /usr/local/tomcat/webapps/share/WEB-INF/classes/share-config.properties
      subPath: share.properties
```

### Digital Workspace and Control Center config

Set the following values:

```yaml
alfresco-digital-workspace:
  env:
    APP_CONFIG_AUTH_TYPE: OAUTH
    APP_CONFIG_OAUTH2_HOST: https://ids.example.com/realms/YOUR-REALM
    APP_CONFIG_OAUTH2_CLIENTID: YOUR-CLIENT-ID
alfresco-control-center:
  env:
    APP_CONFIG_AUTH_TYPE: OAUTH
    APP_CONFIG_OAUTH2_HOST: https://ids.example.com/realms/YOUR-REALM
    APP_CONFIG_OAUTH2_CLIENTID: YOUR-CLIENT-ID
```

Please search the [Alfresco Products Official Documentation][alfresco-docs-site]
for more configuration options.

[alfresco-docs-site]: https://support.hyland.com/r/alfresco
