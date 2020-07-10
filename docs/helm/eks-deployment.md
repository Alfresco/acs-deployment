# Alfresco Content Services Helm Deployment with AWS EKS

This page describes how to deploy Alfresco Content Services (ACS) using [Helm](https://helm.sh) onto [EKS](https://aws.amazon.com/eks).

Amazon's EKS (Elastic Container Service for Kubernetes) makes it easy to deploy, manage, and scale containerized applications using Kubernetes on AWS. EKS runs the Kubernetes management infrastructure for you across multiple AWS availability zones to eliminate a single point of failure.

**Note:** You don't need to clone this repository to deploy Alfresco Content Services.

## Prerequisites

As well as the prerequisites mentioned on the [main README](/README.md#prerequisites) please also follow the steps below.

TODO: Hosted zone and ACM Certificate

Follow the [AWS EKS Getting Started Guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html) to create a cluster and prepare your local machine to connect to the cluster. Use the "Cluster with Linux-only workloads" option and specify a `--node-type` of at least m4.xlarge.

As we'll be using Helm to deploy the ACS chart follow the [Using Helm with EKS](https://docs.aws.amazon.com/eks/latest/userguide/helm.html) instructions to setup helm on your local machine.

Optionally, follow the tutorial to [deploy the Kubernetes Dashboard](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html) to your cluster, this can be really useful for troubleshooting issues that may occur.

## Prepare The Cluster For ACS

Do these one time steps...

* External DNS
* EFS File System
* Deploy NFS Client Provisioner
* Update security groups for EFS access & Route53

## Deploy

### Nginx Ingress

### ACS 

* Helm Repos
* Namespace
* ACS helm chart install

## Access

* Check status


## Configure

Installs an out-of-the-box setup by default but there are many options.
Config table or refer to examples.

## Cleanup

To uninstall/delete the `my-acs` deployment:

```bash
helm delete my-acs --purge
kubectl delete namespace $DESIREDNAMESPACE
```

This will remove all the Kubernetes components associated with the chart and deletes the helm release.


----

## Appendix

To use, add the `incubator` or `stable` repository to your local Helm.
```console
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
helm repo add alfresco-stable http://kubernetes-charts.alfresco.com/stable
```

## To install the ACS cluster

```
$ helm install alfresco-incubator/alfresco-content-services
```

To install the chart with the release name `my-acs`:

```console
# Alfresco Admin password should be encoded in MD5 Hash
export ALF_ADMIN_PWD=$(printf %s 'MyAdminPwd' | iconv -t UTF-16LE | openssl md4 | awk '{ print $1}')

# Alfresco Database (Postgresql) password
export ALF_DB_PWD='MyDbPwd'

$ helm install --name my-acs alfresco-incubator/alfresco-content-services \
               --set repository.adminPassword="$ALF_ADMIN_PWD" \
               --set postgresql.postgresPassword="$ALF_DB_PWD"
```

The command deploys ACS Cluster on the Kubernetes cluster in the default configuration (but with your chosen Alfresco administrator & database passwords). The [configuration](#configuration) section lists the parameters that can be configured during installation.


## Checking the status of your deployment

* Use `helm status` to get the status of the Helm stacks created:
```bash
helm status $INGRESSRELEASE
helm status $ACSRELEASE
```

* You can access all components of Alfresco Content Services using the same root address, but different paths:
```bash
  Share: https://$EXTERNALHOST/share
  Content: https://$EXTERNALHOST/alfresco
```

To see the full list of values that were applied to the deployment, run:
```bash
helm get values -a $ACSRELEASE
```

## Delete EFS Volume.  First mount point then filesystem
aws efs delete-mount-target --mount-target-id $EFS_MOUNT_ID
aws efs delete-file-system --file-system-id $EFS_FS_ID
eksctl delete