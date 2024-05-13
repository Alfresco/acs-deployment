---
title: External infrastructure
parent: Examples
grand_parent: Helm
---


# Alfresco Content Services Helm Deployment with external infrastructure

- [Alfresco Content Services Helm Deployment with external infrastructure](#alfresco-content-services-helm-deployment-with-external-infrastructure)
  - [Activemq broker](#activemq-broker)
  - [Elasticsearch index](#elasticsearch-index)
  - [Postgresql database](#postgresql-database)

Our Helm charts includes a set of dependency which are meaningful for testing
and easy evaluation but can't be really suggested for production workloads
(unless you really understand what you are doing).

## Activemq broker

For enhanced durability and scalability, you can provide an externally
provisioned ActiveMq cluster by providing the following values:

```yaml
messageBroker:
  url: failover:(nio://YOUR-MQ-HOSTNAME:61616)?timeout=3000&jms.useCompression=true
  user: YOUR-MQ-USERNAME
  password: YOUR-MQ-PASSWORD
activemq:
  enabled: false
```

or alternatively you can provide your own secret instead of specifying
credentials as plain values:

```yaml
messageBroker:
  url: failover:(nio://YOUR-MQ-HOSTNAME:61616)?timeout=3000&jms.useCompression=true
  existingSecretName: YOUR-MQ-SECRET
activemq:
  enabled: false
alfresco-transform-service:
  messageBroker:
      name: YOUR-MQ-SECRET
alfresco-search-enterprise:
  messageBroker:
    existingSecretName: YOUR-MQ-SECRET
alfresco-repository:
  configuration:
    messageBroker:
      existingSecret:
        name: YOUR-MQ-SECRET
alfresco-sync-service:
  messageBroker:
    existingSecret:
      name: YOUR-MQ-SECRET
alfresco-ai-transformer:
  messageBroker:
    existingSecret:
      name: YOUR-MQ-SECRET
```

## Elasticsearch index

When using Search Enterprise, the default search backend since ACS v23, you can
provide connection details to an external elasticsearch cluster by providing the
following values:

```yaml
global:
  search:
    url: https://YOUR-DOMAIN-HOSTNAME/
    flavor: elasticsearch
    username: YOUR-DOMAIN-MASTER-USERNAME
    password: YOUR-DOMAIN-MASTER-PASSWORD
alfresco-repository:
  configuration:
    search:
      flavor: elasticsearch
      securecomms: https
```

or alternatively you can provide your own secret instead of specifying
credentials as plain values:

```yaml
global:
  search:
    url: https://YOUR-DOMAIN-HOSTNAME/
    flavor: elasticsearch
    existingSecretName: YOUR-ES-SECRET
alfresco-repository:
  configuration:
    search:
      flavor: elasticsearch
      securecomms: https
      existingSecret:
        name: YOUR-ES-SECRET
alfresco-search-enterprise:
  search:
    existingSecret:
      name: YOUR-ES-SECRET
```

## Postgresql database

For better performances and durability, you can provide an externally
provisioned Postgres database by providing the following values:

```yaml
database:
  external: true
  driver: org.postgresql.Driver
  url: jdbc:postgresql://YOUR-DATABASE-ENDPOINT:5432/
  user: YOUR-DATABASE-USERNAME
  password: YOUR-DATABASE-PASSWORD
postgresql:
  enabled: false
```

or alternatively you can provide your own secret instead of specifying
credentials as plain values:

```yaml
database:
  external: true
  driver: org.postgresql.Driver
  url: jdbc:postgresql://YOUR-DATABASE-ENDPOINT:5432/
  existingSecretName: YOUR-DATABASE-SECRET
postgresql:
  enabled: false
alfresco-repository:
  configuration:
    db:
      existingSecret:
        name: YOUR-DATABASE-SECRET
alfresco-search-enterprise:
  reindexing:
    db:
      existingSecret:
        name: YOUR-DATABASE-SECRET
```
