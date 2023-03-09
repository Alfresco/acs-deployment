# Helm values examples

This folder contains some additional values that can be used to quickstart the
testing of helm charts.

The following snippet are meant to be used with a local chart checked out and inside the `helm/alfresco-content-services` folder:

```sh
git clone https://github.com/Alfresco/acs-deployment.git
cd helm/alfresco-content-services
```

Multiple values can be combined together to achieve multiple results (e.g. enterprise search on localhost deployment)

## Enterprise localhost deployment

```sh
helm upgrade --install -n alfresco acs . \
  --values ../../docs/helm/values/desktop_values.yaml \
  --set global.tracking.sharedsecret=$(openssl rand 20 -base64)
```

## Search Enterprise deployment

```sh
helm upgrade --install -n alfresco acs . \
  --values ../../docs/helm/values/desktop_values.yaml \
  --values ../../docs/helm/values/enterprise_search_values.yaml
```
