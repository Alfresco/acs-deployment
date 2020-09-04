# Alfresco Content Services Helm Deployment with AWS Services

This example describes how to deploy ACS onto [EKS](https://aws.amazon.com/eks) and use [S3](https://aws.amazon.com/s3) for content storage, [RDS](https://aws.amazon.com/rds) as an external database and [Amazon MQ](https://aws.amazon.com/amazon-mq) as an external message broker.

## Prerequisites

Follow the [EKS deployment](../eks-deployment.md) guide up until the [ACS](../eks-deployment.md#acs) section, once the docker registry secret is installed return to this page.

## Setup Services

The following sections describe how to setup the AWS services and highlights the information required to deploy ACS.

### S3

1. Create an S3 bucket in the same region as your cluster using the following command (replacing `YOUR-BUCKET-NAME` with a name of your choice):

    ```bash
    aws s3 mb s3://YOUR-BUCKET-NAME
    ```

2. Enable versioning using the following command (replacing `YOUR-BUCKET-NAME` with the name you chose in the previous step):

    ```bash
    aws s3api put-bucket-versioning --bucket YOUR-BUCKET-NAME --versioning-configuration Status=Enabled
    ```

3. Find the name of the role used by the nodes by running the following command (replacing `YOUR-CLUSTER-NAME` with the name you gave your cluster):

    ```bash
    aws eks describe-nodegroup --cluster-name YOUR-CLUSTER-NAME --nodegroup-name linux-nodes --query "nodegroup.nodeRole" --output text
    ```

4. In the [IAM console](https://console.aws.amazon.com/iam/home) find the role discovered in the previous step and create a new inline policy (highlighted in the screenshot below) using the JSON content below (replacing `YOUR-BUCKET-NAME` with the name you chose in the step one):

    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Action": [
                    "s3:DeleteObject",
                    "s3:PutObject",
                    "s3:GetObject"
                ],
                "Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*",
                "Effect": "Allow"
            }
        ]
    }
    ```

    The end result should resemble something similar to the screenshot below:

    ![S3 IAM Policy](./diagrams/eks-s3-iam-policy.png)

### RDS

1. Create an Aurora cluster using the "Create database" wizard in the [RDS Console](https://console.aws.amazon.com/rds/home).

    * Select the "Standard Create" option so you can choose the VPC later
    * Select the "Amazon Aurora with PostgreSQL compatibility" Edition
    * Select "11.7" for the Version
    * Provide a "DB cluster identifier" of your choosing
    * Change the "Master username" to `alfresco`
    * In the "Connectivity" section select the VPC created by eksctl that contains your EKS cluster
    * Expand the "Additional configuration" section and provide a "Initial database name" of `alfresco`
    * Leave all other options set to the default
    * Press the orange "Create database" button

2. Once the cluster has been created (it can take a few minutes) make a note of the generated master password using the "View credentials details" button in the header banner.
3. Select the database with the "Writer" role and click on the default security group link (as shown in the screenshot below)

    ![DB Security Group](./diagrams/eks-db-security-group.png)

4. Add an inbound rule for PostgreSQL traffic from the VPC CIDR range (it will be the same as the NFS rule setup earlier) as shown in the screenshot below:

    ![DB Inbound Rules](./diagrams/eks-db-inbound-rules.png)

5. Finally, take a note of the database Endpoint (shown in the screenshot in step 3)

### Amazon MQ

TODO

## Deploy

In order to use the S3 connector and external database options, the S3 connector AMP and database drivers are required, respectively. Fortunately, a Docker image has been pre-packaged with the artifacts and can be used as-is for our deployment. To use the image we can override the `repository.image.repository` property.

To enable the S3 connector ...

To use an external database ...

When we bring all this together we can deploy ACS using the command below (replacing all the `YOUR-XZY` properties with the values gathered during the setup of the services):

```bash
helm install acs alfresco-incubator/alfresco-content-services \
--set externalPort="443" \
--set externalProtocol="https" \
--set externalHost="acs.YOUR-DOMAIN-NAME" \
--set persistence.enabled=true \
--set persistence.storageClass.enabled=true \
--set persistence.storageClass.name="nfs-client" \
--set global.alfrescoRegistryPullSecrets=quay-registry-secret \
--set repository.image.repository="quay.io/alfresco/alfresco-content-repository-aws" \
--set s3connector.enabled=true \
--set s3connector.config.bucketName="YOUR-BUCKET-NAME" \
--set s3connector.config.bucketLocation="YOUR-AWS-REGION" \
--set postgresql.enabled=false \
--set database.external=true \
--set database.driver="org.postgresql.Driver" \
--set database.url="jdbc:postgresql://YOUR-DATABASE-ENDPOINT:5432/" \
--set database.user="alfresco" \
--set database.password="YOUR-DATABASE-PASSWORD" \
--atomic \
--timeout 9m0s \
--namespace=alfresco
```

NOTE: S3 can be further configured via [S3 connector documentation] just prefix options with s3connector.config. For example....

NOTE: Alternativly Aurora MySQL can be used, replace ..... with .....
--set database.driver="org.mariadb.jdbc.Driver" \
--set database.url="'jdbc:mariadb:aurora//$RDS_ENDPOINT:3306/alfresco?useUnicode=yes&characterEncoding=UTF-8'" \
