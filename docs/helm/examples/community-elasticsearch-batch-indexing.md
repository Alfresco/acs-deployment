---
title: ACS Community with Elasticsearch batch indexing
parent: Examples
grand_parent: Helm
---

# Deploying ACS Community with Elasticsearch batch indexing

ACS Community uses Solr for search by default. As an alternative, Community can
run Elasticsearch batch indexing via the `alfresco-search-community` component:
an out-of-process indexer reads content from the repository and populates an
Elasticsearch cluster, which the repository then queries for search.

## Requirements

- The repository image must be
  `alfresco/alfresco-content-repository-community:26.2.0-A.23` or newer. The
  Community `elasticsearch` search subsystem is not present in `26.1.0` (the
  default tag in `community_values.yaml`) and the repository would fail to start
  with `No bean named 'elasticsearch' available`.
- This option is mutually exclusive with Solr (`alfresco-search`) and with
  Enterprise search (`alfresco-search-enterprise`). The chart fails the render if
  more than one search backend is enabled. `community_values.yaml` already
  disables Enterprise search, so the overlay below only needs to turn Solr off.

## Configuring the Helm chart

On top of the
[community_values.yaml file](https://github.com/Alfresco/acs-deployment/blob/master/helm/alfresco-content-services/community_values.yaml),
provide an overlay that switches the backend to Elasticsearch. Save it as
`community-es_values.yaml`:

```yaml
alfresco-repository:
  image:
    tag: 26.2.0-A.23
  configuration:
    search:
      flavor: elasticsearch
alfresco-search:
  enabled: false
alfresco-search-community:
  enabled: true
elasticsearch:
  enabled: true
```

Then install ACS Community with both values files:

```bash
helm install acs alfresco/alfresco-content-services \
  --values=community_values.yaml \
  --values=community-es_values.yaml \
  --namespace=alfresco
```

## Notes

> :warning: Enabling `elasticsearch.enabled` deploys an embedded Elasticsearch
> cluster with no authentication. This is intended for testing or development
> only and is **not recommended for production use**. For production, point the
> deployment at an externally managed Elasticsearch cluster via
> `global.search.url`.

To run the embedded Elasticsearch cluster with authentication enabled, see
[ACS with local elasticsearch cluster with auth enabled](./with-elasticsearch-auth.md).
