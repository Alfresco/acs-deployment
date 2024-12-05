---
title: Microsoft Teams Connector
parent: Examples
grand_parent: Helm
---

# ACS Helm Deployment with Microsoft Teams Connector

The [Alfresco Microsoft Teams Connector](https://support.hyland.com/p/alfresco) enables
Microsoft Teams clients to be used to search content within ACS and send
messages to Teams Chat / Channels with preview links to Alfresco Digital
Workspace. By default, this feature is disabled.

This example describes how to deploy ACS onto [EKS](https://aws.amazon.com/eks)
with Microsoft Teams Integration enabled.

## Prerequisites

Follow the [AWS Services](with-aws-services.md) example up until the
[Deploy](with-aws-services.md#deploy) section and return to this page.

## Deploy

When we bring all this together we can deploy ACS using the command below (replacing all the `YOUR-XZY` properties with the values gathered during the setup of the services):

```bash
helm install acs alfresco/alfresco-content-services \
  --set alfresco-repository.persistence.enabled=true \
  --set alfresco-transform-service.filestore.persistence.enabled=true \
  --set alfresco-transform-service.filestore.persistence.storageClass="nfs-client" \
  --set global.known_urls=https://acs.YOUR-DOMAIN-NAME \
  --set global.search.sharedSecret:=$(openssl rand -hex 24) \
  --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
  --set postgresql.enabled=false \
  --set database.external=true \
  --set database.driver="org.postgresql.Driver" \
  --set database.url="jdbc:postgresql://YOUR-DATABASE-ENDPOINT:5432/" \
  --set database.user="alfresco" \
  --set database.password="YOUR-DATABASE-PASSWORD" \
  --set activemq.enabled=false \
  --set messageBroker.url="YOUR-MQ-ENDPOINT" \
  --set messageBroker.user="alfresco" \
  --set messageBroker.password="YOUR-MQ-PASSWORD" \
  --set msTeams.enabled=true \
  --set alfresco-connector-msteams.alfresco.baseUrl="https://acs.YOUR-DOMAIN-NAME:443" \
  --set alfresco-connector-msteams.alfresco.digitalWorkspace.contextPath="/workspace/" \
  --set alfresco-connector-msteams.microsoft.app.id="YOUR-MS-APP-ID" \
  --set alfresco-connector-msteams.microsoft.app.password="YOUR-MS-APP-PWD" \
  --set alfresco-connector-msteams.microsoft.app.oauth.connectionName="alfresco" \
  --set alfresco-connector-msteams.teams.chat.filenameEnabled=true \
  --set alfresco-connector-msteams.teams.chat.metadataEnabled=true \
  --set alfresco-connector-msteams.teams.chat.imageEnabled=true \
  --atomic \
  --timeout 10m0s \
  --namespace=alfresco
```
