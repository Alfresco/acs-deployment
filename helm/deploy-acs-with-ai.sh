#!/usr/bin/env bash

helm install alfresco-content-services \
--set repository.adminPassword="admin" \
--set alfresco-infrastructure.persistence.efs.enabled=true \
--set alfresco-infrastructure.persistence.efs.dns="<efs-dns>" \
--set alfresco-search.resources.requests.memory="2500Mi",alfresco-search.resources.limits.memory="2500Mi" \
--set alfresco-search.environment.SOLR_JAVA_MEM="-Xms2000M -Xmx2000M" \
--set persistence.repository.data.subPath="${DESIREDNAMESPACE}/alfresco-content-services/repository-data" \
--set persistence.solr.data.subPath="${DESIREDNAMESPACE}/alfresco-content-services/solr-data" \
--set postgresql.postgresPassword="admin" \
--set postgresql.persistence.subPath="${DESIREDNAMESPACE}/alfresco-content-services/database-data" \
--set registryPullSecrets="<quay-pull-secret>" \
--set aws.accessKey="<ai-access-key>" \
--set aws.secretAccessKey="<ai-secret-key>" \
--set aws.region="<ai-aws-region>" \
--set aws.s3Bucket="<ai-s3-bucket-name>" \
--set aws.comprehendRoleARN="<ai-aws-role-arn>" \
--set repository.image.repository="quay.io/alfresco/alfresco-content-repository-aws" \
--set repository.image.tag="latest" \
--set share.image.repository="quay.io/alfresco/alfresco-share-aws" \
--set share.image.tag="latest" \
--set ai.enabled="true" \
--set s3connector.enabled="true" \
--set s3connector.config.bucketName="<acs-s3-bucket-name>" \
--set s3connector.config.bucketLocation="<acs-s3-region>" \
--set s3connector.secrets.accessKey="<acs-access-key>" \
--set s3connector.secrets.secretKey="<acs-secret-key>" \
--namespace=${DESIREDNAMESPACE}
