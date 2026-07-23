---
title: Upgrades
parent: Docker Compose
---

# Upgrading the Docker Compose files

Our Docker Compose files are continuously improved and sometimes arise the need
to introduce a breaking change.

To get an overview of the changes in each release, first take a look at the
release notes that are available via [GitHub
Releases](https://github.com/Alfresco/acs-deployment/releases).

Here follows a more detailed explanation of any breaking change grouped by
version in which they have been released.

## 10.7.0

* `community-compose.yaml` now uses Elasticsearch, alongside a `batch-indexing`
  component and Kibana, instead of Solr6 for search. This mirrors the
  `alfresco-search-community` option already available in the Helm chart. The
  `solr6` service, its `8083` browser port, and the related `-Dsolr.*` JAVA_OPTS
  have been removed from the Community compose file. Kibana is now available at
  `http://localhost:5601`.

## 10.3.0

* Starting with ACS 26, the `alfresco-activemq:6.2.x` Docker image used by the
  Docker Compose bundles has authentication enabled by default. This change
  provides better security and ensures that credentials are required and
  validated for each component when connecting to ActiveMQ. When using this
  image, make sure that:
  * on the broker (`alfresco-activemq` service), `ACTIVEMQ_ADMIN_LOGIN` and
    `ACTIVEMQ_ADMIN_PASSWORD` are set, and
  * in each ACS service that connects to ActiveMQ, `SPRING_ACTIVEMQ_USER` and
    `SPRING_ACTIVEMQ_PASSWORD` are configured with the same values.

  When using older ActiveMQ images (prior to `alfresco-activemq:6.2.x`),
  authentication remains disabled by default for backward compatibility, but we
  recommend upgrading to the latest image to benefit from improved security and
  performance.

## 9.1.0

* We have started to leverage
  [extends](https://docs.docker.com/compose/how-tos/multiple-compose-files/extends/)
  feature of docker compose to improve maintainability of the compose files we
  provide. This means that any compose file in
  [docker-compose](https://github.com/Alfresco/acs-deployment/tree/master/docker-compose)
  folder cannot be used anymore as a standalone file but must be invoked within
  that folder.

  If you want to further customize the compose files, make sure to understand
  and use the definitions included in the
  [commons](https://github.com/Alfresco/acs-deployment/tree/master/docker-compose/commons)
  folder.

* We've introduced an anonymous volume for the alfresco service to ensure
  content store data remains intact across container restarts. This
  enhancement improves the user experience when fine-tuning Compose files and
  allows for repeated use of `docker compose up -d` without data loss.

## 8.5.0

* The Docker Compose deployment has moved from a custom NGINX based proxy to a
  Traefik based proxy. If you customized the previous NGINX proxy
  configuration, see the [Alfresco Proxy (proxy)](README.md#alfresco-proxy-proxy)
  section for how to configure Traefik instead.
