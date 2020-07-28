# Alfresco Content Services Helm Deployment with AWS EKS

This page describes how to deploy Alfresco Content Services (ACS) using [Helm](https://helm.sh) onto [EKS](https://aws.amazon.com/eks).

Amazon's EKS (Elastic Container Service for Kubernetes) makes it easy to deploy, manage, and scale containerized applications using Kubernetes on AWS. EKS runs the Kubernetes management infrastructure for you across multiple AWS availability zones to eliminate a single point of failure.

**Note:** You don't need to clone this repository to deploy Alfresco Content Services.

## Prerequisites

As well as the prerequisites mentioned on the [main README](/README.md#prerequisites) we also recommend that you are proficient in AWS and Kubernetes.

## Setup An EKS Cluster

Follow the [AWS EKS Getting Started Guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html) to create a cluster and prepare your local machine to connect to the cluster. Use the "Managed nodes - Linux" option and specify a `--node-type` of at least m5.xlarge.

As we'll be using Helm to deploy the ACS chart follow the [Using Helm with EKS](https://docs.aws.amazon.com/eks/latest/userguide/helm.html) instructions to setup helm on your local machine.

Helm also needs to know where to find charts, run the following commands to add the standard Helm repository and the Alfresco incubator and stable repositories to your machine:

```bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
helm repo add alfresco-stable https://kubernetes-charts.alfresco.com/stable
helm repo add alfresco-incubator https://kubernetes-charts.alfresco.com/incubator
```

Optionally, follow the tutorial to [deploy the Kubernetes Dashboard](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html) to your cluster, this can be really useful for troubleshooting issues that may occur.

## Prepare The Cluster For ACS

Now we have an EKS cluster up and running there are a few one time steps we need to perform to prepare the cluster for ACS to be installed.

### DNS

1. Create a hosted zone in Route53 using [these steps](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingHostedZone.html) if you don't already have one available.

2. Create a public certificate for the hosted zone created in step 1 in Certificate Manager using [these steps](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request-public.html) if you don't have one already available and make a note of the certificate ARN.

3. Create a file called `external-dns.yaml` with the text below (replacing `your-domain-name` with the domain name you created in step 1). This manifest defines a service account and a cluster role for managing DNS.
    ```yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
      name: external-dns
    ---
    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRole
    metadata:
      name: external-dns
    rules:
    - apiGroups: [""]
      resources: ["services","endpoints","pods"]
      verbs: ["get","watch","list"]
    - apiGroups: ["extensions"]
      resources: ["ingresses"]
      verbs: ["get","watch","list"]
    - apiGroups: [""]
      resources: ["nodes"]
      verbs: ["list","watch"]
    ---
    apiVersion: rbac.authorization.k8s.io/v1beta1
    kind: ClusterRoleBinding
    metadata:
      name: external-dns-viewer
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: ClusterRole
      name: external-dns
    subjects:
    - kind: ServiceAccount
      name: external-dns
      namespace: kube-system
    ---
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: external-dns
    spec:
      strategy:
        type: Recreate
      selector:
        matchLabels:
          app: external-dns
      template:
        metadata:
          labels:
            app: external-dns
        spec:
          serviceAccountName: external-dns
          containers:
          - name: external-dns
            image: registry.opensource.zalan.do/teapot/external-dns:latest
            args:
            - --source=service
            - --domain-filter=your-domain-name
            - --provider=aws
            - --policy=sync
            - --aws-zone-type=public
            - --registry=txt
            - --txt-owner-id=acs-deployment
            - --log-level=debug
    ```
4. Use the kubectl command to deploy the external-dns service.
   ```bash
   kubectl apply -f external-dns.yaml -n kube-system
   ```
5. Find the name of the role used by the nodes by running the following command (replacing `your-cluster-name` with the name you gave your cluster):
    ```bash
    aws eks describe-nodegroup --cluster-name your-cluster-name --nodegroup-name linux-nodes --query "nodegroup.nodeRole" --output text
    ```
6. In the [IAM console](https://console.aws.amazon.com/iam/home) find the role discovered in the previous step and attach the "AmazonRoute53FullAccess" managed policy.

### File System

1. Create an Elastic File System in the VPC created by EKS using [these steps](https://docs.aws.amazon.com/efs/latest/ug/creating-using-create-fs.html) ensuring a mount target is created in each subnet. Make a note of the File System ID.
2. Find The CIDR range of VPC created by eksctl.
3. Locate the default security group for the VPC and add an inbound rule for NFS traffic from the VPC CIDR range.
4. Deploy an NFS Client Provisioner with Helm using the following command (replacing `efs-dns-name` with the string "file-system-id.efs.aws-region.amazonaws.com" where file-system-id is the ID retrieved in step 1 and aws-region is the region you're using e.g. "fs-72f5e4f1.efs.us-east-1.amazonaws.com"):
    ```bash
    helm install alfresco-nfs-provisioner stable/nfs-client-provisioner --set nfs.server="efs-dns-name" --set nfs.path="/" --set storageClass.name="nfs-client" --set storageClass.archiveOnDelete=false -n kube-system
    ```

## Deploy

Now the EKS cluster is setup we can deploy ACS.

### Namespace

Create a namespace to host ACS inside the cluster using the following command:

```bash
kubectl create namespace acs
```

### Ingress

1. Create a file called `ingress-rbac.yaml` with the text below:
    ```yaml
    apiVersion: rbac.authorization.k8s.io/v1
    kind: Role
    metadata:
      name: acs:psp
      namespace: acs
    rules:
    - apiGroups:
      - policy
      resourceNames:
      - kube-system
      resources:
      - podsecuritypolicies
      verbs:
      - use
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: my-acs:psp:default
      namespace: acs
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: acs:psp
    subjects:
    - kind: ServiceAccount
      name: default
      namespace: acs
    ---
    apiVersion: rbac.authorization.k8s.io/v1
    kind: RoleBinding
    metadata:
      name: acs:psp:acs-ingress
      namespace: acs
    roleRef:
      apiGroup: rbac.authorization.k8s.io
      kind: Role
      name: acs:psp
    subjects:
    - kind: ServiceAccount
      name: acs-ingress
      namespace: acs
    ```

2. Use the kubectl command to create the cluster roles required by the ingress service.
    ```bash
    kubectl apply -f ingress-rbac.yaml -n acs
    ```
3. Locate the ID of the security
4. Deploy the ingress using the following command (replacing ACM_CERTIFICATE_ARN with the ARN of the certificate created in the DNS section):
    ```bash
    helm install acs-ingress stable/nginx-ingress \
    --set controller.scope.enabled=true \
    --set controller.scope.namespace=acs \
    --set rbac.create=true \
    --set controller.config."proxy-body-size"="100m" \
    --set controller.service.targetPorts.https=80 \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-backend-protocol"="http" \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-ports"="https" \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-cert"="ACM_CERTIFICATE_ARN" \
    --set controller.service.annotations."external-dns\.alpha\.kubernetes\.io/hostname"="acs.opsexp.alfresco.me" \
    --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-negotiation-policy"="ELBSecurityPolicy-TLS-1-2-2017-01" \
    --set controller.publishService.enabled=true \
    --atomic \
    --namespace acs
    ```
    NOTE: The command will wait until the deployment is ready so please be patient.

### Docker Registry Secret

1. Create a docker registry secret to allow the protected images to be pulled from Quay.io by running the following commmand (replacing your-username and your-password with your credentials):
    ```bash
    kubectl create secret docker-registry quay-registry-secret --docker-server=quay.io --docker-username=your-username --docker-password=your-password -n acs
    ```

### ACS 

1. Deploy ACS by running the following command:
    ```bash
    helm install acs alfresco-incubator/alfresco-content-services \
    --set externalPort="443" \
    --set externalProtocol="https" \
    --set externalHost="acs.opsexp.alfresco.me" \
    --set persistence.enabled=true \
    --set persistence.storageClass.enabled=true \
    --set persistence.storageClass.name="nfs-client" \
    --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
    --atomic \
    --timeout 9m0s \
    --namespace=acs
    ```
    NOTE: The command will wait until the deployment is ready so please be patient.

## Access

If the deployment was successful the following URLs will be available:

* Repository: https://acs.opsexp.alfresco.me:443/alfresco
* ADW: https://acs.opsexp.alfresco.me:443/workspace/
* Share: https://acs.opsexp.alfresco.me:443/share
* Api-Explorer: https://acs.opsexp.alfresco.me:443/api-explorer
* Sync service: https://acs.opsexp.alfresco.me:443/syncservice/healthcheck

## Configure

Installs an out-of-the-box setup by default but there are many options.
Config table or refer to examples.

## Cleanup

1. Remove the `acs` deployment by running the following command:
     ```bash
     helm uninstall acs
     ```

kubectl delete namespace $DESIREDNAMESPACE
aws efs delete-mount-target --mount-target-id $EFS_MOUNT_ID
aws efs delete-file-system --file-system-id $EFS_FS_ID
eksctl delete