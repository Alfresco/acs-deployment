# Alfresco Content Services Deployment with an external Database

This documentation demonstrates on use of an external Database service with ACS deployment using helm.

Below is an example of setting up in US-East-1 (N.Virginia) region with an AWS Aurora Database cluster with 2 instances.

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

Once the kubernetes cluster is up and running with nginx-ingress controller, an AWS Aurora RDS Database cluster is required for ACS Deployment.

## Create an AWS Aurora RDS Cluster with 2 instances

From the AWS Console -> Services -> RDS -> Clusters -> Create database -> Amazon Aurora (`Edition`: `MySQL 5.6-compatible`)

In the `Network & Security` -> Virtual Private Cloud (VPC) select the VPC Id for the database server.  For example, VPC Id created by Kops create cluster.  Proceed with rest of the options as needed to create the cluster.

The cluster creation may take some minutes before the status of cluster and it's instances status becomes available.

## Allow Kubernetes Nodes Security Group to communicate with Database cluster

From the AWS Console -> Services -> RDS -> Clusters -> Select Cluster -> DB Cluster Members
Select the db instance with role `writer`.

In the `Security group rules` edit and add a new rule for as:

```
Type: MYSQL/Aurora
Protocol: TCP
Port Range: 3306
Source: sg-<k8s-nodes-sg-id>
```

This will allow the pods running on Kubernetes nodes to access the external database service.

## Deploy ACS Helm Chart with External Database service

Refer [helm deployment aws with kops](../helm-deployment-aws_kops.md#deploying-alfresco-content-services) for full `helm install` reference.  Below is an example is to use the external database service.

```bash
export RDS_ENDPOINT="my-acs-database.cluster-chc1vvifzyjv.us-east-1.rds.amazonaws.com"
export DATABASE_USER="alfresco"
export DATABASE_PASSWORD="someRdsPwd"
helm install alfresco-incubator/alfresco-content-services \
--version 1.1.3 \
--name my-acs \
--set externalProtocol="https" \
--set externalHost="$CLUSTER_NAME" \
--set externalPort="443" \
...
...
--set registryPullSecrets=quay-registry-secret \
--set repository.image.repository="alfresco/alfresco-content-repository-aws" \
--set repository.image.tag="0.1.3-repo-6.0.0.3" \
--set postgresql.enabled=false \
--set database.external=true \
--set database.driver="org.mariadb.jdbc.Driver" \
--set database.url="'jdbc:mariadb:aurora//$RDS_ENDPOINT:3306/alfresco?useUnicode=yes&characterEncoding=UTF-8'" \
--set database.user="$DATABASE_USER" \
--set database.password="$DATABASE_PASSWORD" \
--namespace=$DESIREDNAMESPACE
```

**Note**: There are specific alfresco repository docker images that support particular database driver. In the above snippet a specific `repository.image.tag="0.1.3-repo-6.0.0.3"` is set for `database.driver="org.mariadb.jdbc.Driver"`.
