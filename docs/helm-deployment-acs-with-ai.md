### Deploying ACS with Alfresco Intelligence Services enabled

By default, [Alfresco Intelligence Services](http://docs.alfresco.com/intelligence/concepts/ai-welcome.html) feature is disabled. 

To deploy ACS with this feature enabled, you can use [helm/deploy-acs-with-ai.sh](../helm/deploy-acs-with-ai.sh) script. Before running it, following environment variables need to be configured:

```
export DESIREDNAMESPACE="<k8s_namespace>"
export EXTERNALHOST="<external_host>"
export ALF_ADMIN_PWD="<md5_of_the_admin_password>"
export EFS_SERVER="<efs_dns>"
export ALF_DB_PWD="<db_password>"
export QUAY_PULL_SECRET="<quay_pull_secret_name>"
export AI_AWS_ACCESS_KEY_ID="<ai_iam_user_access_key_id>"
export AI_AWS_SECRET_KEY="<ai_iam_user_secret_key>"
export AI_AWS_REGION="<ai_aws_region>"
export AI_AWS_S3_BUCKET_NAME="<ai_s3_bucket_name>"
export AI_AWS_COMPREHEND_ROLE_ARN="<ai_iam_role_arn_for_comprehend>"
export ACS_S3_BUCKET_NAME="<s3_connector_bucket_name>"
export ACS_S3_REGION="<s3_connector_bucket_region>"
export ACS_ACCESS_KEY_ID="<s3_connector_iam_user_access_key_id>"
export ACS_SECRET_KEY="<s3_connector_iam_user_secret_key>"
```

The `helm install` command uses an additional file, [helm/alfresco-content-services/ai-reference-values.yaml](../helm/alfresco-content-services/ai-reference-values.yaml), to override some of the default values. The docker image tags will change, as we release and package new versions of Alfresco Intelligence Services.

**Notes:** 
* Follow [these steps](helm-deployment-aws_kops.md#setting-up-alfresco-content-services) to install `nginx-ingress` and to configure some of the environment variables:
```
export DESIREDNAMESPACE="<k8s_namespace>"
export EXTERNALHOST="<external_host>"
export ALF_ADMIN_PWD="<md5_of_the_admin_password>"
export EFS_SERVER="<efs_dns>"
export ALF_DB_PWD="<db_password>"
export QUAY_PULL_SECRET="<quay_pull_secret_name>"
```
* For additional information on the S3 Connector benefits, installation and configuration, see the [Alfresco Content Connector for AWS S3 documentation](https://docs.alfresco.com/s3connector/concepts/s3-contentstore-overview.html).
* For additional information on the `AI_AWS_*` variables and configuration, see the [AWS Setup documentation](https://docs.alfresco.com/intelligence/concepts/aws-setup.html).
