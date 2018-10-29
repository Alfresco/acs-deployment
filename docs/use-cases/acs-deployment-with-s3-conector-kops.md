# Alfresco Content Services Deployment with S3 Connector module for content storage with encryption

This documentation demonstrates on use of an AWS S3 bucket for content storage along with encryption using AWS KMS (Key Management Service) with Alfresco S3 Connector module.

Below is an example of setting up in US-East-1 (N.Virginia) region.

## Export Kops setup environment variables

```bash
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_DEFAULT_REGION="us-east-1"
export KOPS_NAME="myacs"
export KOPS_STATE_STORE=s3://<somes3bucket>
export CLUSTER_NAME="myacs.mydomain.com"
```

## Create Kubernetes Cluster with Kops

[Kubernetes cluster on aws with kops](../helm-deployment-aws_kops.md#setting-up-kubernetes-cluster-on-aws-with-kops)

Once the kubernetes cluster is up and running with nginx-ingress controller an S3 bucket is required for ACS Deployment with S3 connector module.

## Create an S3 bucket for ACS contents storage

From the AWS Console -> Services -> S3 -> Create bucket -> 
```
`Bucket Name`: `unique-acs-s3-bucket`
`Region`: `us-east-1`
```

### Enable Versioning

It is highly recommended to enable versioning on the s3 bucket

From the AWS Console -> Services -> S3 -> `unique-acs-s3-bucket` -> Properties -> Versioning -> Enabled

### Enable AWS-KMS encryption

This will encrypt data written by the pods in the s3 bucket using AWS-KMS (for example).

First, create an AWS-KMS Encryption key (if it is not available)

From the AWS Console -> Services -> IAM -> Encryption keys -> Create key -> Region: `US East (N.Virginia)`
```
`Alias (required)`: `alias/mykms-acs-s3`
`Description`: `Some description`
```
click `Next Step` for `Add Tags` to tag the encryption key.

`Name`: `mykms-acs-s3`
click `Next Step` to select `Key Administrators` -> select `nodes.myacs.mydomain.com` (from `Filter`) IAM role created by kops.  

click `Next Step` to select `This Account` -> select `nodes.myacs.mydomain.com` (from `Filter`) IAM role created by kops.

click `Next Step` to `Preview Key Policy` and then click `Finish`

By default, the kms key status is `Enabled`, select the key and note down from `Summary` it's ARN.

Finally, on the s3 bucket enable `Default encryption` with `AWS-KMS` -> Custom KMS Arn -> `above kms key arn`


### Apply S3 custom bucket policies for data integration (Recommended)

The ACS S3 contents bucket can be guarded to deny against:
- Incorrect encryption header
- Unencrypted object uploads

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

## Allow Kops created node IAM role to access S3 bucket for uploading contents

In order for kubernetes pods to use the s3 buckets for writing contents, the node IAM role need to attach with a new policy to grant access to the s3 bucket.

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

## Deploy ACS Helm Chart with S3 connector module

Refer [helm deployment aws with kops](../helm-deployment-aws_kops.md#deploying-alfresco-content-services) for full `helm install` reference.  Below example is to enable s3 connector and pass s3 bucket configuration.

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
--set registryPullSecrets=quay-registry-secret \
--set s3connector.enabled=true \
--set s3connector.config.bucketName="$ACS_S3_BUCKET" \
--set s3connector.config.bucketLocation="$AWS_DEFAULT_REGION" \
--set s3connector.secrets.encryption=kms \
--set s3connector.secrets.awsKmsKeyId="$S3_KMS_ARN" \
--namespace=$DESIREDNAMESPACE
```
