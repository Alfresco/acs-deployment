#!/usr/bin/env bash

helm install alfresco-content-services \
-f alfresco-content-services/ai-reference-values.yaml \
--set externalProtocol="https" \
--set externalHost="${EXTERNALHOST}" \
--set externalPort="443" \
--set repository.adminPassword="${ALF_ADMIN_PWD}" \
--set alfresco-infrastructure.persistence.efs.enabled=true \
--set alfresco-infrastructure.persistence.efs.dns="${EFS_SERVER}" \
--set alfresco-search.resources.requests.memory="2500Mi",alfresco-search.resources.limits.memory="2500Mi" \
--set alfresco-search.environment.SOLR_JAVA_MEM="-Xms2000M -Xmx2000M" \
--set persistence.repository.data.subPath="${DESIREDNAMESPACE}/alfresco-content-services/repository-data" \
--set persistence.solr.data.subPath="${DESIREDNAMESPACE}/alfresco-content-services/solr-data" \
--set postgresql.postgresPassword="${ALF_DB_PWD}" \
--set postgresql.persistence.subPath="${DESIREDNAMESPACE}/alfresco-content-services/database-data" \
--set registryPullSecrets="<quay-pull-secret>" \
--set ai.aws.accessKey="<ai-access-key>" \
--set ai.aws.secretAccessKey="<ai-secret-key>" \
--set ai.aws.region="<ai-aws-region>" \
--set ai.aws.s3Bucket="<ai-s3-bucket-name>" \
--set ai.aws.comprehendRoleARN="<ai-aws-role-arn>" \
--set s3connector.config.bucketName="<acs-s3-bucket-name>" \
--set s3connector.config.bucketLocation="<acs-s3-region>" \
--set s3connector.secrets.accessKey="<acs-access-key>" \
--set s3connector.secrets.secretKey="<acs-secret-key>" \
--namespace=${DESIREDNAMESPACE}
