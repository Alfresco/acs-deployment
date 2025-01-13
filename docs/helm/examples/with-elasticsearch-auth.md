---
title: ACS with local elasticsearch cluster with auth enabled
parent: Examples
grand_parent: Helm
---

# Deploying Elasticsearch with Kibana and Authentication Enabled

This guide demonstrates how to deploy Elasticsearch with Kibana and
authentication enabled using the Alfresco ACS Deployment repository.  

> :warning: This example demonstrates how to use an embedded Elasticsearch cluster
> with authentication enabled. However, it is intended for demonstration purposes
> only and is **not recommended for production use**. We strongly advise against using
> an embedded Elasticsearch cluster in production environments. This example is
> provided solely for cases where the embedded setup is specifically needed, such
> as for testing or development scenarios.

## Prerequisites

Ensure you have the following:

- Helm installed on your system.
- Kubernetes cluster configured and running.

## Steps to Deploy

### 1. Create a Secret

Create env file with passwords. Customize the values as needed for your setup.

```txt
elastic-user=elastic
elasticsearch-password=alfresco
kibana-password=alfrescokibana
AUDIT_ELASTICSEARCH_USERNAME=elastic
AUDIT_ELASTICSEARCH_PASSWORD=alfresco
SEARCH_USERNAME=elastic
SEARCH_PASSWORD=alfresco
```

Create a Kubernetes secret containing the credentials for Elasticsearch and
Kibana using created env file.

```bash
kubectl create secret generic elastic-search-secret \
    --namespace=default \
    --from-env-file=elastic.env
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
