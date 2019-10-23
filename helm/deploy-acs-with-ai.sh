#!/usr/bin/env bash

# The following environment variables can either be inherited 
# from the parent shell or overwritten here in the script:
#export DESIREDNAMESPACE="<k8s_namespace>"
#export EXTERNALHOST="<external_host>"
#export ALF_ADMIN_PWD="<md5_of_the_admin_password>"
#export EFS_SERVER="<efs_dns>"
#export ALF_DB_PWD="<db_password>"
#export QUAY_PULL_SECRET="<quay_pull_secret_name>"
#export AI_AWS_ACCESS_KEY_ID="<ai_iam_user_access_key_id>"
#export AI_AWS_SECRET_KEY="<ai_iam_user_secret_key>"
#export AI_AWS_REGION="<ai_aws_region>"
#export AI_AWS_S3_BUCKET_NAME="<ai_s3_bucket_name>"
#export AI_AWS_COMPREHEND_ROLE_ARN="<ai_iam_role_arn_for_comprehend>"
#export ACS_S3_BUCKET_NAME="<s3_connector_bucket_name>"
#export ACS_S3_REGION="<s3_connector_bucket_region>"
#export ACS_ACCESS_KEY_ID="<s3_connector_iam_user_access_key_id>"
#export ACS_SECRET_KEY="<s3_connector_iam_user_secret_key>"

echo "Deploying alfresco-content-services charts..."
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
    --set global.alfrescoRegistryPullSecrets="${QUAY_PULL_SECRET}" \
    --set ai.aws.accessKey="${AI_AWS_ACCESS_KEY_ID}" \
    --set ai.aws.secretAccessKey="${AI_AWS_SECRET_KEY}" \
    --set ai.aws.region="${AI_AWS_REGION}" \
    --set ai.aws.s3Bucket="${AI_AWS_S3_BUCKET_NAME}" \
    --set ai.aws.comprehendRoleARN="${AI_AWS_COMPREHEND_ROLE_ARN}" \
    --set s3connector.config.bucketName="${ACS_S3_BUCKET_NAME}" \
    --set s3connector.config.bucketLocation="${ACS_S3_REGION}" \
    --set s3connector.secrets.accessKey="${ACS_ACCESS_KEY_ID}" \
    --set s3connector.secrets.secretKey="${ACS_SECRET_KEY}" \
    --namespace="${DESIREDNAMESPACE}"

echo "Deploying alfresco-content-services charts... Done"

exit 0
