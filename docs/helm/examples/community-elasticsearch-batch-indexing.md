---
title: ACS Community with Elasticsearch batch indexing
parent: Examples
grand_parent: Helm
---

# Deploying ACS Community with Elasticsearch batch indexing

`community_values.yaml` installs ACS Community with Elasticsearch batch
indexing by default: an out-of-process indexer (`alfresco-search-community`)
reads content from the repository and populates an embedded Elasticsearch
cluster, which the repository then queries for search. This is mutually
exclusive with Solr (`alfresco-search`) and with Enterprise search
(`alfresco-search-enterprise`) - the chart fails the render if more than one
search backend is enabled.

## Requirements

- The repository image must be `26.2.0` or newer (the default tag in
  `community_values.yaml` already satisfies this). Older versions don't have the
  Community `elasticsearch` search subsystem and the repository would fail to
  start with `No bean named 'elasticsearch' available`.

## Installing the Helm chart

Download the
[community_values.yaml file](https://github.com/Alfresco/acs-deployment/blob/master/helm/alfresco-content-services/community_values.yaml)
and install ACS Community with it:

```bash
helm install acs alfresco/alfresco-content-services \
  --values=community_values.yaml \
  --set global.search.sharedSecret=$(openssl rand -hex 24) \
  --namespace=alfresco
```

`global.search.sharedSecret` is required: it authenticates the batch indexer
against the repository's legacy Solr tracking webscripts API, which it uses
regardless of the primary search flavor.

## Notes

> :warning: `community_values.yaml` deploys an embedded Elasticsearch cluster
> with no authentication. This is intended for testing or development only and
> is **not recommended for production use**. For production, point the
> deployment at an externally managed Elasticsearch cluster via
> `global.search.url`.

To run the embedded Elasticsearch cluster with authentication enabled, see
[ACS with local elasticsearch cluster with auth enabled](./with-elasticsearch-auth.md).
