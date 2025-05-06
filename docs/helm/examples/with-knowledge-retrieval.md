---
title: ACS with Knowledge Retrieval instance
parent: Examples
grand_parent: Helm
---

# Deploying ACS + Knowledge Retrieval

This guide demonstrates how to deploy connector for Knowledge Retirieval using
the Alfresco ACS Deployment repository.

## Prerequisites

Ensure you have the following:

- Helm installed on your system.
- Kubernetes cluster configured and running.

## Steps to Deploy

### Create a Secret

Create env file with credentials. Customize the values as needed for your setup.

```txt
HX_CLIENT_ID=sc-e26b1939-0012-4fb6-b270-d63188d6b78c
HX_CLIENT_SECRET=yoursecret
HX_ENV_KEY=alfresco-kd-ci-8931ff99-97d8-4c36-a235-ba9269286322
HX_APP_SOURCE_ID=984b2de8-528a-488a-94c2-342e84ec8eb0
```

Create a Kubernetes secret containing the credentials for Knowledge Retrieval instance

```bash
kubectl create secret generic hxi-secrets \
    --namespace=default \
    --from-env-file=hxi.env
```

### Ingress

See [ingress-nginx](../ingress-nginx.md) section.

### ACS Chart

See [desktop-deployment](../desktop-deployment.md#acs) section.

### Enterprise local values

Download `local-dev_values.yaml` file as described in
[desktop-deployment](../desktop-deployment.md#enterprise-localhost-deployment)
section.

### Understand the Patch File

The `hxi.yml` patch file defines the configuration for the Knowledge Retrieval.
It includes settings for secrets and URLs required by both the repository and
the live ingester instances.

```bash
curl -fO https://github.com/Alfresco/acs-deployment/blob/master/docs/helm/values/hxi.yml
```

### Deploy the Infrastructure

Deploy the ACS stack with the appropriate values files.

```bash
helm install acs alfresco/alfresco-content-services \
    --set global.known_urls=http://localhost \
    --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
    --values local-dev_values.yaml \
    --values hxi.yaml
```
