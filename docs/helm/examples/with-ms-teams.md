# Alfresco Content Services Helm Deployment with Microsoft Teams Connector (Microsoft Teams Integration)

The [Alfresco Microsoft Teams Connector](https://docs.alfresco.com/)enables Microsoft Teams clients to be
used to search content within ACS (Alfesco Content Services) and send messages to Teams Chat / Channels with preview links to Alfresco Digital Workspace. By default, this feature is disabled.

This example describes how to deploy ACS onto [EKS](https://aws.amazon.com/eks) with Microsoft Teams Integration enabled.

The diagram below shows the deployment produced by this example:

![Helm with Microsoft Teams Integration](../diagrams/helm-eks-s3-rds-mq-ms-teams-TODO.png)

## Prerequisites

Follow the [AWS Services](with-aws-services.md) example up until the [Deploy](with-aws-services.md#deploy) section and return to this page.

## Deploy

When we bring all this together we can deploy ACS using the command below (replacing all the `YOUR-XZY` properties with the values gathered during the setup of the services):

```bash
helm install acs alfresco/alfresco-content-services \
  --set repository.persistence.enabled=true \
  --set filestore.persistence.enabled=true \
  --set filestore.persistence.storageClass="nfs-client" \
  --set global.known_urls=https://acs.YOUR-DOMAIN-NAME \
  --set global.tracking.sharedsecret=$(openssl rand -hex 24) \
  --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
  --set s3connector.enabled=true \
  --set s3connector.config.bucketName="YOUR-BUCKET-NAME" \
  --set s3connector.config.bucketLocation="YOUR-AWS-REGION" \
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
  --set msTeamsService.alfresco.baseUrl="https://acs.YOUR-DOMAIN-NAME:443"
  --set msTeamsService.alfresco.digitalWorkspace.contextPath="/workspace/" \
  --set msTeamsService.microsoft.app.id="YOUR-MS-APP-ID" \
  --set msTeamsService.microsoft.app.password="YOUR-MS-APP-PWD" \
  --set msTeamsService.microsoft.app.oauth.connectionName="alfresco" \
  --set msTeamsService.teams.chat.filenameEnabled=true \
  --set msTeamsService.teams.chat.metadataEnabled=true \
  --set msTeamsService.teams.chat.imageEnabled=true \
  --atomic \
  --timeout 10m0s \
  --namespace=alfresco
```
