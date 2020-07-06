# Alfresco Content Services Deployment with S3 Connector module for content storage with encryption

This documentation demonstrates how to use an AWS S3 bucket for content storage, along with encryption using AWS KMS (Key Management Service) with the Alfresco Content Connector for AWS S3 module (S3 Connector).

Below is an example set up in the US-East-1 (N.Virginia) region.

## Export Kops setup environment variables

```bash
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_DEFAULT_REGION="us-east-1"
export KOPS_NAME="myacs"
export KOPS_STATE_STORE=s3://<somes3bucket>
export CLUSTER_NAME="myacs.mydomain.com"
```

## Create Kubernetes cluster with Kops

Follow the steps outlined in [Setting up a Kubernetes cluster on AWS with Kops](../helm-deployment-aws_kops.md#setting-up-kubernetes-cluster-on-aws-with-kops).

Once the Kubernetes cluster is up and running with an nginx-ingress controller, an S3 bucket is required for ACS Deployment with the S3 Connector module.

## Create an S3 bucket for ACS content storage

From the **AWS Console**, select **Services** -> **S3** -> **Create bucket** ->
```
Bucket Name: unique-acs-s3-bucket
Region: us-east-1
```

### Enable versioning

It is highly recommended that versioning is enabled on the S3 bucket.

From the **AWS Console**, select **Services** -> **S3** -> `unique-acs-s3-bucket` -> **Properties** -> **Versioning** -> **Enabled**.

### Enable AWS-KMS encryption

This will encrypt data written by the pods in the S3 bucket using AWS-KMS (for example).

* First, create an AWS-KMS Encryption key (if it is not available).

* From the **AWS Console**, select **Services** -> **IAM** -> **Encryption keys** -> **Create key** -> **Region:** `US East (N.Virginia)`
```
Alias (required): alias/mykms-acs-s3
Description: Some description
```

* Click `Next Step` to access `Add Tags` then tag the encryption key.

`Name`: `mykms-acs-s3`

* Click `Next Step` to access `Key Administrators` and then select `nodes.myacs.mydomain.com` (from `Filter`) IAM role created by kops.  

* Click `Next Step` to access `This Account` and then select `nodes.myacs.mydomain.com` (from `Filter`) IAM role created by kops.

* Click `Next Step` to access `Preview Key Policy` and then click `Finish`

* By default, the KMS key status is `Enabled`. Select the key and note down its ARN from the `Summary`.

* Finally, on the S3 bucket, enable `Default encryption` with `AWS-KMS` -> Custom KMS ARN -> `above kms key arn`.


### Apply S3 custom bucket policies for data integration (recommended)

The ACS S3 content bucket can be guarded to deny against:
- Incorrect encryption header
- Unencrypted object uploads

From the **AWS Console**, select **Services** -> **S3** -> `unique-acs-s3-bucket` -> **Permissions** -> **Bucket Policy** and add below content and save it (remember to replace bucket name with yours).

```bash
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::unique-acs-s3-bucket/*",
            "Condition": {
                "StringNotEquals": {
                    "s3:x-amz-server-side-encryption": "aws:kms"
                }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::unique-acs-s3-bucket/*",
            "Condition": {
                "Null": {
                    "s3:x-amz-server-side-encryption": "true"
                }
            }
        }
    ]
}
```

## Allow Kops created node IAM role to access S3 bucket for uploading content

In order for Kubernetes pods to use the S3 buckets for writing content, the node IAM role needs to attach with a new policy to grant access to the S3 bucket.

* From the **AWS Console**, select **Services** -> **IAM** -> **Roles** -> search & select the Kubernetes Nodes IAM Role -> **Permissions** -> **Add inline Policy** -> **JSON**.

* Add the content below and save it (remember to replace bucket name with yours).

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "s3:DeleteObject",
                "s3:PutObject",
                "s3:GetObject"
            ],
            "Resource": "arn:aws:s3:::unique-acs-s3-bucket/*",
            "Effect": "Allow"
        }
    ]
}
```

## Deploy ACS Helm chart with S3 Connector module

Refer to [Deploying Alfresco Content Services](../helm-deployment-aws_kops.md#deploying-alfresco-content-services) for  the full `helm install` reference.  The example below enables the S3 Connector and passes the S3 bucket configuration.

```bash
export ACS_S3_BUCKET="unique-acs-s3-bucket"
export S3_KMS_ARN="arn:aws:kms:us-east-1:12345678910:key/XXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"

helm install alfresco-incubator/alfresco-content-services \
--version 1.1.3 \
--name my-acs \
--set externalProtocol="https" \
--set externalHost="$CLUSTER_NAME" \
--set externalPort="443" \
...
...
--set global.alfrescoRegistryPullSecrets=quay-registry-secret \
--set s3connector.enabled=true \
--set s3connector.config.bucketName="$ACS_S3_BUCKET" \
--set s3connector.config.bucketLocation="$AWS_DEFAULT_REGION" \
--set s3connector.secrets.encryption=kms \
--set s3connector.secrets.awsKmsKeyId="$S3_KMS_ARN" \
--namespace=$DESIREDNAMESPACE
```
