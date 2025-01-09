---
title: ACS with local elasticsearch cluster with auth enabled
parent: Examples
grand_parent: Helm
---

# Deploying Elasticsearch with Kibana and Authentication Enabled

This guide demonstrates how to deploy Elasticsearch with Kibana and
authentication enabled using the Alfresco ACS Deployment repository.  

## Prerequisites

Ensure you have the following:

- Helm installed on your system.
- Kubernetes cluster configured and running.

## Steps to Deploy

### 1. Create a Secret

First, create a Kubernetes secret containing the credentials for Elasticsearch
and Kibana. Customize the values as needed for your setup.

```bash
kubectl create secret generic elastic-search-secret \
    --namespace=default \
    --from-literal=elastic-user=elastic \
    --from-literal=elasticsearch-password=alfresco \
    --from-literal=kibana-password=alfrescokibana \
    --from-literal=AUDIT_ELASTICSEARCH_USERNAME=elastic \
    --from-literal=AUDIT_ELASTICSEARCH_PASSWORD=alfresco \
    --from-literal=SEARCH_USERNAME=elastic \
    --from-literal=SEARCH_PASSWORD=alfresco
```

### 2. Understand the Patch File

Patch file `docs/helm/values/elasticsearch_auth_values.yaml` defines the configuration
for enabling authentication and integrating Elasticsearch and Kibana with the
Alfresco deployment. Update the patch file to match your requirements if
necessary.

### 3. Deploy the Infrastructure

Deploy the ACS stack with the appropriate values files.

```bash
helm install acs ./helm/alfresco-content-services \
    --set global.search.sharedSecret="$(openssl rand -hex 24)" \
    --set global.known_urls=http://localhost \
    --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
    --values docs/helm/values/local-dev_values.yaml \
    --values docs/helm/values/elasticsearch_auth_values.yaml
```

## Accessing Kibana

After the deployment is successful:

1. Open your browser and navigate to: `http://localhost/kibana`

2. Use the credentials specified in the secret to log in.

   - **Username**: elastic
   - **Password**: alfresco

You should now have access to Kibana with Elasticsearch authentication enabled.
