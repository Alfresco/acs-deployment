---
title: Content Connector for Intelligence Cloud
parent: Examples
grand_parent: Helm
---

# ACS Helm Deployment with Content Connector for Intelligence Cloud (CIC)

The [Alfresco Content Connector for Intelligence Cloud
(CIC)](https://github.com/Alfresco/alfresco-helm-charts/tree/main/charts/alfresco-connector-cic)
integrates ACS with Hyland's Intelligence Cloud platform. It deploys three
services — `live-ingester`, `bulk-ingester`, and `nucleus-sync` — and is
disabled by default.

## Prerequisites

- A running Kubernetes cluster with the ACS umbrella chart deployed.
- Credentials for a Hyland Intelligence Cloud environment
  (`HX_CLIENT_ID`, `HX_CLIENT_SECRET`, `HX_ENV_KEY`, `HX_APP_SOURCE_ID`).

## Create Secrets

Create a Kubernetes secret containing the CIC credentials:

```bash
kubectl create secret generic cic-secrets \
  --namespace=<your-namespace> \
  --from-literal=HX_CLIENT_ID=sc-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx \
  --from-literal=HX_CLIENT_SECRET=your-client-secret \
  --from-literal=HX_ENV_KEY=alfresco-ci-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx \
  --from-literal=HX_APP_SOURCE_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxxx
```

Create a second secret with the Alfresco repository credentials (used by the
live-ingester and nucleus-sync to authenticate against the repository REST API):

```bash
kubectl create secret generic repository-admin-secret \
  --namespace=<your-namespace> \
  --from-literal=REPOSITORY_USERNAME=admin \
  --from-literal=REPOSITORY_PASSWORD=<your-repo-password> \
  --from-literal=REPOSITORY_CLIENT_ID=<your-oauth-client-id> \
  --from-literal=REPOSITORY_CLIENT_SECRET=<your-oauth-client-secret>
```

## Deploy

Use the reference values file provided in
[`docs/helm/values/with-cic_values.yaml`](https://raw.githubusercontent.com/Alfresco/acs-deployment/master/docs/helm/values/with-cic_values.yaml)
as a starting point. Adjust the URLs for your target environment
(staging/production) and reference the secret created above:

```bash
helm upgrade --install alfresco-content-services alfresco/alfresco-content-services \
  --values local-dev_values.yaml \
  --values with-cic_values.yaml \
  --namespace=<your-namespace>
```

No ACS repository extension or additional JVM properties are required — CIC
operates independently over the message broker and shared filestore that are
already wired up by the umbrella chart.
