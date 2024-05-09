---
title: Intelligence Services
parent: Examples
grand_parent: Helm
---

# ACS Helm Deployment with Intelligence Services

By default, [Alfresco Intelligence
Services](https://docs.alfresco.com/intelligence/concepts/ai-welcome.html)
feature is disabled, this example describes how to deploy ACS onto
[EKS](https://aws.amazon.com/eks) with AIS enabled.

The diagram below shows the deployment produced by this example:

![Helm with Intelligence Services](../images/helm-eks-s3-rds-mq-ai.png)

## Prerequisites

Follow the [AWS Services](with-aws-services.md) example up until the
[Deploy](with-aws-services.md#deploy) section and return to this page.

## Setup S3 Bucket

Follow the steps in the official documentation to [setup an IAM user and an S3
bucket](https://docs.alfresco.com/intelligence/concepts/aws-setup.html) for use
by AIS.

## Deploy

Create a local values file to contain Helm charts' configuration options (`ai-values.yaml`):

```yaml
alfresco-ai-transformer:
  enabled: true
  aws:
    accessKeyId: YOUR-AI-AWS-ACCESS-KEY-ID
    secretAccessKey: YOUR-AI-AWS-SECRET-KEY
    region: YOUR-AWS-REGION
    s3Bucket: YOUR-AI-BUCKET-NAME
    comprehendRoleARN: YOUR-AI-AWS-COMPREHEND-ROLE-ARN
alfresco-transform-service:
  filestore:
    persistence.enabled: true
    storageClass: nfs-client
  transformrouter:
    environment:
      JAVA_OPTS: -XX:MaxRAMPercentage=80
      TRANSFORMER_URL_AWS_AI: http://alfresco-intelligence-service
      TRANSFORMER_QUEUE_AWS_AI: "org.alfresco.transform.engine.ai-aws.acs"
      TRANSFORMER_ROUTES_ADDITIONAL_AI: "/etc/ats-routes/ai-pipeline-routes.json"
    volumeMounts:
      - name: ai-transform-routes
        mountPath: /etc/ats-routes
    volumes:
      - name: ai-routes
        configMap:
          names: ai-transform-pipelines
          items:
            - key: ai-pipeline-routes.json
              path: ai-pipeline-routes.json
```

> Replace AWS credentials and Kubernetes storageClass with actual values

When we bring all this together we can deploy ACS using the command below
(replacing all the `YOUR-XZY` properties with the values gathered during the
setup of the services):

```bash
helm install acs alfresco/alfresco-content-services \
  --set global.known_urls=https://acs.YOUR-DOMAIN-NAME \
  --set global.search.sharedSecret=$(openssl rand -hex 24) \
  --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
  --set alfresco-repository.persistence.enabled=false \
  --set alfresco-repository.image.repository="quay.io/alfresco/alfresco-content-repository-aws" \
  --set share.image.repository="quay.io/alfresco/alfresco-share-aws" \
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
  --set global.ai.enabled=true \
  -f ai-values.yaml \
  --atomic \
  --timeout 10m0s \
  --namespace=alfresco
```
