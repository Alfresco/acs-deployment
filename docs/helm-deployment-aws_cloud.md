# Alfresco Content Services Deployment with Helm on AWS


## Prerequisites

To run the Alfresco Content Services (ACS) deployment on AWS with Kubernetes requires:

| Component   | Getting Started Guide |
| ------------| --------------------- |
| Docker      | https://docs.docker.com/ |
| Kubernetes  | https://kubernetes.io/docs/tutorials/kubernetes-basics/ |
| Kubectl     | https://kubernetes.io/docs/tasks/tools/install-kubectl/ |
| Helm        | https://docs.helm.sh/using_helm/#quickstart-guide |
| Kops        | https://github.com/kubernetes/kops/blob/master/docs/aws.md |
| AWS Cli     | https://github.com/aws/aws-cli#installation |

**Note:** You don't need to clone this repository to deploy Alfresco Content Services.


### Setting up Kubernetes cluster on AWS with Kops

* Export the AWS user credentials:
```bash
# Access Key & Secret
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXX
(or)
# AWS Profile
export AWS_PROFILE="<profile-name>"

export AWS_DEFAULT_REGION="<region-name>"
```

* Name the Alfresco Content Services environment:
```bash
export KOPS_NAME="myacs.example.com"
```

* Provide an S3 bucket name to store the cluster configuration used by `kops`.  This bucket needs to be created first:
```bash
# If s3 bucket is not already created
$ aws s3 mb s3://my-bucket-kops-store

export KOPS_STATE_STORE="s3://my-bucket-kops-store"
```

* Create a Kubernetes cluster using the `kops` utility:
```bash
kops create cluster \
  --ssh-public-key <SSH-PUBLIC-KEY> \
  --name $KOPS_NAME \
  --state $KOPS_STATE_STORE \
  --node-count 2 \
  --zones <AWS-REGION_AVAILABILITY-ZONE(s)> \
  --master-zones <AWS-REGION_AVAILABILITY-ZONE(s)> \
  --cloud aws \
  --node-size m4.xlarge \
  --master-size t2.medium \
  -v 10 \
  --kubernetes-version "1.10.1" \
  --bastion \
  --topology private \
  --networking calico \
  --yes
```
Adjust the above values accordingly (ex: `--node-size`, `--kubernetes-version` etc.).
**Note:** The default bastion user name is `admin` accessible via the Bastion ELB (and not the EC2 host where the bastion is running).

### Upgrading a cluster (optional)

* Edit the worker nodes configuration to include spot price:
```
kops edit ig nodes
```

Include the following in the configuration:
```
spec:
  maxPrice: "0.07"
```

* (Optional) Enable the required admission controllers, for example, by applying a [Pod Security Policy](https://github.com/Alfresco/acs-deployment/wiki/Apply-PSP).

* Update the cluster:
```
kops update cluster --yes
kops rolling-update cluster --yes
```

### Deploying the Kubernetes Dashboard

* Install the [Kubernetes dashboard](https://github.com/kubernetes/dashboard).  This Dashboard helps to view and manage the cluster from your localhost (Ex: Work laptop):

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
```

* Enable access control to manage the AWS Kubernetes cluster:

```bash
kubectl create -f dashboard-admin.yaml
```

<details><summary>
See example file: dashboard-admin.yaml</summary>
<p>

```bash
cat <<EOF > dashboard-admin.yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: kubernetes-dashboard
  labels:
    k8s-app: kubernetes-dashboard
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: kubernetes-dashboard
  namespace: kube-system
EOF
```

</p>
</details>


* Redirect the AWS Kubernetes cluster to manage it via your localhost with `kubectl` (on default port `8001`):

```bash
kubectl proxy &
# To use a custom port: `kubectl proxy --port=8002 &`
```

* To access the cluster locally, go to: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/ and then press 'skip' in auth page.

### Deploying Helm

Helm is used to deploy the Alfresco Content Services into the Kubernetes cluster.

* Create tiller (cluster wide) and add the cluster admin role to tiller.  It should not be isolated in a namespace as the ingress needs to set up cluster roles [https://github.com/kubernetes/helm/blob/master/docs/rbac.md]:

```bash
kubectl create -f tiller-rbac-config.yaml
```

<details><summary>
See example file: tiller-rbac-config.yaml</summary>
<p>

```bash
cat <<EOF > tiller-rbac-config.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system
EOF
```

</p>
</details>

* Initialize tiller:
```bash
helm init --service-account tiller
```
The above step may not even be needed as, by default, `kubectl` will create and initialize the service.

## Setting up Alfresco Content Services

Once the platform for Kubernetes is set up on AWS, you can set up the Alfresco Content Services.

* Create a namespace to host Alfresco Content Services inside the cluster.  A Kubernetes cluster can have many namespaces to separate and isolate multiple application environments (such as development, staging, and production):
```bash
export DESIREDNAMESPACE=dev-myacs-namespace
kubectl create namespace $DESIREDNAMESPACE
```

### Deploying the Ingress for Alfresco Content Services

* Install the `nginx-ingress` service to create a web service, virtual LBs, and AWS ELB inside `$DESIREDNAMESPACE` to serve Alfresco Content Services. You have the option to either create an `ingressvalues.yaml` file, or write the arguments in full:

Option 1:

```bash
# Helm install nginx-ingress with args in ingressvalues.yaml file
helm install stable/nginx-ingress \
--version 0.14.0 \
--set controller.scope.enabled=true \
--set controller.scope.namespace=$DESIREDNAMESPACE \
--set rbac.create=true \
-f ingressvalues.yaml \
--namespace $DESIREDNAMESPACE
```

<details><summary>
See example file: ingressvalues.yaml</summary>
<p>

```bash
cat <<EOF > ingressvalues.yaml
controller:
  config:
    ssl-redirect: "false"
  scope:
    enabled: true
    namespace: $DESIREDNAMESPACE
  publishService:
    enabled: true
  service:
    targetPorts:
      https: 80
    annotations:
      service.beta.kubernetes.io/aws-load-balancer-ssl-cert: ""
      service.beta.kubernetes.io/aws-load-balancer-ssl-ports: https
      external-dns.alpha.kubernetes.io/hostname: $DESIREDNAMESPACE.YourDNSZone
      service.beta.kubernetes.io/aws-load-balancer-ssl-negotiation-policy: "ELBSecurityPolicy-TLS-1-2-2017-01"
EOF
```

</p>
</details>

Option 2:

```bash
# Helm install nginx-ingress along with args
export AWS_CERT_ARN="arn:aws:acm:<AWS-REGION>:<AWS-AccountID>:certificate/<CertificateId>"
export AWS_CERT_POLICY="ELBSecurityPolicy-TLS-1-2-2017-01"

helm install stable/nginx-ingress \
--version 0.14.0 \
--set controller.scope.enabled=true \
--set controller.scope.namespace=$DESIREDNAMESPACE \
--set rbac.create=true \
--set controller.config."force-ssl-redirect"=\"true\" \
--set controller.config."proxy-body-size"="100m" \
--set controller.service.targetPorts.https=80 \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-backend-protocol"="http" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-ports"="https" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-cert"=$AWS_CERT_ARN \
--set controller.service.annotations."external-dns\.alpha\.kubernetes\.io/hostname"="$DESIREDNAMESPACE.dev.alfresco.me" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-negotiation-policy"=$AWS_CERT_POLICY \
--set controller.publishService.enabled=true \
--namespace $DESIREDNAMESPACE
```
Adjust the above values accordingly (ex: `--version` of `nginx-ingress`, `controller.service.annotations` etc.)

* To view the AWS ELB DNS name, note down the `nginx-ingress` release from the output of the above command. (for example, `NAME:  knobby-wolf`):
```bash
export INGRESSRELEASE=knobby-wolf
export ELBADDRESS=$(kubectl get services $INGRESSRELEASE-nginx-ingress-controller --namespace=$DESIREDNAMESPACE -o jsonpath={.status.loadBalancer.ingress[0].hostname})
echo $ELBADDRESS
```

### Creating File Storage for the Alfresco Content Services

* Create an EFS storage on AWS and make sure it's in the same VPC as your cluster by following this [guide](https://github.com/Alfresco/alfresco-dbp-deployment#6-efs-storage-note-only-for-aws).  Make sure you open inbound traffic in the security group to allow NFS traffic.  Below is an example of how to create it with the AWS Cli.

<details><summary>
See EFS storage example</summary>
<p>

```bash
# Give a name to your EFS Volume
export EFS_NAME=<EFS-NAME>

# Create EFS filesystem
aws efs create-file-system --creation-token $EFS_NAME

# Describe EFS filesystem ID
export EFS_FS_ID=$(aws efs describe-file-systems --creation-token $EFS_NAME --output text --query 'FileSystems[*].FileSystemId')

# Tag EFS filesystem
aws efs create-tags --file-system-id $EFS_FS_ID --tags Key=Name,Value=$EFS_NAME

# Before we can create any EFS Mount point, it is important to know the cluster's VPC, Subnet (tagged with 'Utility') & Security Group in which it needs to go
export VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:KubernetesCluster,Values=$KOPS_NAME" --output text --query '[Vpcs[].VpcId]')
export SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=tag:KubernetesCluster,Values=$KOPS_NAME" "Name=tag:SubnetType,Values=Utility"  --output text --query 'Subnets[].[SubnetId]')
export DEFAULT_SG=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=default" --output text --query "SecurityGroups[].GroupId")

# Create EFS Mount Point & may take some time to complete creation
aws efs create-mount-target --file-system-id $EFS_FS_ID --subnet-id $SUBNET_ID

# Query if the EFS Mount point is available. After a few minutes it should print a string 'available'.
aws efs describe-mount-targets --file-system-id $EFS_FS_ID --output text --query 'MountTargets[].[LifeCycleState]'

# Allow VPC's default Security Group to allow traffic from EFS for IPv4 & IPv6
aws ec2 authorize-security-group-ingress --group-id $DEFAULT_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 2049, "ToPort": 2049, "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "EFS Mount point for Cluster $KOPS_NAME"}]}]'
aws ec2 authorize-security-group-ingress --group-id $DEFAULT_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 2049, "ToPort": 2049, "Ipv6Ranges": [{"CidrIpv6": "::/0", "Description": "EFS Mount point for Cluster $KOPS_NAME"}]}]'

# Publish EFS Volume's DNS name
export EFS_SERVER=$EFS_FS_ID.efs.$AWS_DEFAULT_REGION.amazonaws.com
```

</p>
</details>

```
# Publish EFS Volume's DNS name (if not already done)
export EFS_SERVER=<EFS_ID>.efs.<AWS-REGION>.amazonaws.com
```

### Deploying Alfresco Content Services

* Add the Alfresco Helm charts repository:
```bash
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
```

* Deploy Alfresco Content Services using the following set of commands:
```bash
# DNS name of the ACS cluster
export EXTERNALHOST="myacs.example.com"

# Alfresco Admin password should be encoded in MD5 Hash
export ALF_ADMIN_PWD=$(printf %s 'MyAdminPwd!' | iconv -t UTF-16LE | openssl md4 | awk '{ print $1}')

# Alfresco Database (Postgresql) password
export ALF_DB_PWD='MyDbPwd'

# Install ACS
helm install alfresco-incubator/alfresco-content-services \
--set externalProtocol="https" \
--set externalHost="$EXTERNALHOST" \
--set externalPort="443" \
--set repository.adminPassword="$ALF_ADMIN_PWD" \
--set postgresql.postgresPassword="$ALF_DB_PWD" \
--set alfresco-infrastructure.persistence.efs.enabled=true \
--set alfresco-infrastructure.persistence.efs.dns="$EFS_SERVER" \
--set alfresco-search.resources.requests.memory="2500Mi",alfresco-search.resources.limits.memory="2500Mi" \
--set alfresco-search.environment.SOLR_JAVA_MEM="-Xms2000M -Xmx2000M" \
--set postgresql.persistence.subPath="$DESIREDNAMESPACE/alfresco-content-services/database-data" \
--set persistence.repository.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/repository-data" \
--set persistence.solr.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/solr-data" \
--namespace=$DESIREDNAMESPACE
```

For more parameter options, see the [acs-deployment configuration table](https://github.com/Alfresco/acs-deployment/tree/master/helm/alfresco-content-services#configuration).

You can set the Alfresco Content Services stack configuration attributes above accordingly.  Note that the `alfresco-incubator/alfresco-content-services` chart will deploy using default values (Ex: `postgresPassword = "alfresco"`).

```bash
# Example: For a hardened DB password:
 --set postgresql.postgresPassword="bLah!"
```

### Creating a Route 53 Record Set in your Hosted Zone

* Go to **AWS Management Console** and open the **Route 53** console.
* Click **Hosted Zones** in the left navigation panel, then **Create Record Set**.
* In the **Name** field, enter your "`$EXTERNALHOST`".
* In the **Alias Target**, select your ELB address ("`$ELBADDRESS`").
* Click **Create**.

You may need to wait a couple of minutes before the record set propagates around the world.

## Checking the status of your deployment

* Use `helm status` to get the status of the Helm stacks created:
```bash
helm status $INGRESSRELEASE
helm status $ACSRELEASE
```

* You can access all components of Alfresco Content Services using the same root address, but different paths:
```bash
  Content: https://$EXTERNALHOST/alfresco
  Share: https://$EXTERNALHOST/share
  Solr: https://$EXTERNALHOST/solr
```

To see the full list of values that were applied to the deployment, run:
```bash
helm get values -a $ACSRELEASE
```

## Cleaning up your deployment

```bash
# Delete Helm charts: Nginx-ingress & ACS
helm delete --purge $INGRESSRELEASE
helm delete --purge $ACSRELEASE

# Delete Namespace
kubectl delete namespace $DESIREDNAMESPACE

# Delete EFS Volume.  First mount point then filesystem
aws efs delete-mount-target --mount-target-id $EFS_MOUNT_ID
aws efs delete-file-system --file-system-id $EFS_FS_ID

# Delete Kops cluster
kops delete cluster --name=$KOPS_NAME --yes
```

For more information on running and tearing down Kubernetes environments, follow this [guide](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/running-a-cluster.md).
