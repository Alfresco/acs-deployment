# Alfresco Content Services Helm Deployment with AWS EKS

This page describes how to deploy Alfresco Content Services (ACS) using [Helm](https://helm.sh) onto [EKS](https://aws.amazon.com/eks).

Amazon's EKS (Elastic Container Service for Kubernetes) makes it easy to deploy, manage, and scale containerized applications using Kubernetes on AWS. EKS runs the Kubernetes management infrastructure for you across multiple AWS availability zones to eliminate a single point of failure.

**Note:** You don't need to clone this repository to deploy Alfresco Content Services.

## Prerequisites

As well as the prerequisites mentioned on the [main README](/README.md#prerequisites) we also recommend that you are proficient in AWS and Kubernetes.

## Setup An EKS Cluster

Follow the [AWS EKS Getting Started Guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html) to create a cluster and prepare your local machine to connect to the cluster. Use the "Managed nodes - Linux" option and specify a `--node-type` of at least m5.xlarge.

As we'll be using Helm to deploy the ACS chart follow the [Using Helm with EKS](https://docs.aws.amazon.com/eks/latest/userguide/helm.html) instructions to setup helm on your local machine.

Optionally, follow the tutorial to [deploy the Kubernetes Dashboard](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html) to your cluster, this can be really useful for troubleshooting issues that may occur.

## Prepare The Cluster For ACS

Now we have an EKS cluster up and running there are a few one time steps we need to perform to prepare the cluster for ACS to be installed.

### DNS

1. Create a hosted zone in Route53 using [these steps](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html) if you don't already have one available

2. Create a public certificate for the hosted zone created in step 1 in Certificate Manager using [these steps](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html) if you don't have one already available

3. Create a file called `external-dns.yaml` with the text below. This manifest defines a service account and a cluster role for managing DNS.
    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: external-dns
    ...
    ```
4. Use the kubectl command to deploy the external-dns service.
   ```bash
   kubectl apply -f external-dns.yaml -n kube-system
   ```

### File System

1. Create an Elastic File System in the VPC created by EKS using [these steps](https://docs.aws.amazon.com/efs/latest/ug/gs-step-two-create-efs-resources.html)
2. Create mount points and take a note of the EFS DNS name
3. Deploy an NFS Client Provisioner with Helm using the following command (replacing `efs-dns-name` with the value obtained in the previous step):
    ```bash
    helm install alfresco-nfs-provisioner stable/nfs-client-provisioner --set nfs.server="<efs-dns-name>" --set nfs.path="/" --set storageClass.name="nfs-client" --set storageClass.archiveOnDelete=false -n kube-system
    ```
3. Update security groups for EFS access

## Deploy

### Namespace

### Nginx Ingress

### ACS 

* Helm Repos
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