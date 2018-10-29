# Alfresco Content Services Deployment with Helm on AWS using Kops

**Hint:** Consider [deploying ACS into EKS](./helm-deployment-aws_eks.md) instead of setting
up a cluster with Kops.

## Prerequisites

To run the Alfresco Content Services (ACS) deployment on AWS in a Kops provided Kubernetes cluster requires:

| Component   | Getting Started Guide |
| ------------| --------------------- |
| Docker      | https://docs.docker.com/ |
| Kubernetes  | https://kubernetes.io/docs/tutorials/kubernetes-basics/ |
| Kubectl     | https://kubernetes.io/docs/tasks/tools/install-kubectl/ |
| Helm        | https://docs.helm.sh/using_helm/#quickstart-guide |
| Kops        | https://github.com/kubernetes/kops/blob/master/docs/aws.md |
| AWS Cli     | https://github.com/aws/aws-cli#installation |

**Note:** You don't need to clone this repository to deploy Alfresco Content Services.

### Prepare and configure Kops

Kops requires certain configurations on your AWS account. Please follow the Kops guide to
[set up your environment](https://github.com/kubernetes/kops/blob/master/docs/aws.md#setup-your-environment)
through to "Creating your first cluster". The cluster for ACS will be created in the next step.

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

* (Optional) Enable the required admission controllers, for example, by applying a [Pod Security Policy](k8s-pod-security-policies.md).

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
# Helm install nginx-ingress along with args
export AWS_CERT_ARN="arn:aws:acm:<AWS-REGION>:<AWS-AccountID>:certificate/<CertificateId>"
export AWS_CERT_POLICY="ELBSecurityPolicy-TLS-1-2-2017-01"

helm install stable/nginx-ingress \
--version 0.14.0 \
--set controller.scope.enabled=true \
--set controller.scope.namespace=$DESIREDNAMESPACE \
--set rbac.create=true \
--set controller.config."force-ssl-redirect"=\"true\" \
--set controller.service.targetPorts.https=80 \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-backend-protocol"="http" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-ports"="https" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-cert"=$AWS_CERT_ARN \
--set controller.service.annotations."external-dns\.alpha\.kubernetes\.io/hostname"="$DESIREDNAMESPACE.dev.alfresco.me" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-negotiation-policy"=$AWS_CERT_POLICY \
--set controller.publishService.enabled=true \
--namespace $DESIREDNAMESPACE
```


Option 2:

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


Adjust the above values accordingly (ex: `--version` of `nginx-ingress`, `controller.service.annotations` etc.)

**Note:** The ACS Docker image is running Tomcat in secure mode (see the [Dockerfile](https://github.com/Alfresco/alfresco-docker-base-tomcat/blob/master/Dockerfile)). This implies that Tomcat will only send cookies via an HTTPS connection. Deploying the ingress without HTTPS (Option 2) is not recommended, as some of the functionality will not work.

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
### Creating a Docker registry pull secret

Since we need to use protected Docker images from Quay.io, you need access to a secret with credentials to be able to pull those images.

* Log in to Quay.io with your credentials:
```bash
docker login quay.io
```

* Generate a base64 value for your dockercfg using one of the following methods. This will allow Kubernetes to access Quay.io:

```bash
# Linux
cat ~/.docker/config.json | base64
```

```bash
# Windows
base64 -w 0 ~/.docker/config.json
```

* Create a file `secrets.yaml` file and insert the following content:
```bash
apiVersion: v1
kind: Secret
metadata:
  name: quay-registry-secret
type: kubernetes.io/dockerconfigjson
data:
# Docker registries config json in base64 - to do this, run:
# cat ~/.docker/config.json | base64
  .dockerconfigjson: add-your-base64-string
```

* Add the base64 string generated in the previous step to ``.dockerconfigjson``.

* Deploy the secret into the Kubernetes cluster:
```bash
kubectl create -f secrets.yaml --namespace $DESIREDNAMESPACE
```
**Note:** Make sure that the `$DESIREDNAMESPACE` variable has been set (see [Setting up Alfresco Content Services](#setting-up-alfresco-content-services)), so that the secret is created in the same namespace.

* You should see the following output:
```bash
secret "quay-registry-secret" created
```

**Note:** When installing the ACS Helm chart, we'll add the variable ```--set registryPullSecrets=quay-registry-secret```.

### Deploying Alfresco Content Services

* Add the Alfresco Helm charts repository:
```bash
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
helm repo add alfresco-stable http://kubernetes-charts.alfresco.com/stable
```

* Deploy Alfresco Content Services using the following set of commands:
```bash
# DNS name of the ACS cluster or the AWS ELB DNS name if you do not intend to create one.
#export EXTERNALHOST="$ELBADDRESS"
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
--set alfresco-infrastructure.persistence.efs.enabled=true \
--set alfresco-infrastructure.persistence.efs.dns="$EFS_SERVER" \
--set alfresco-search.resources.requests.memory="2500Mi",alfresco-search.resources.limits.memory="2500Mi" \
--set alfresco-search.environment.SOLR_JAVA_MEM="-Xms2000M -Xmx2000M" \
--set persistence.repository.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/repository-data" \
--set persistence.solr.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/solr-data" \
--set postgresql.postgresPassword="$ALF_DB_PWD" \
--set postgresql.persistence.subPath="$DESIREDNAMESPACE/alfresco-content-services/database-data" \
--set registryPullSecrets=quay-registry-secret \
--namespace=$DESIREDNAMESPACE
```

**Note:** By default the Alfresco Search Services `/solr` endpoint is disabled for external access.  To enable it, see example [search-external-access](examples/search-external-access.md).

You can set the Alfresco Content Services stack configuration attributes above accordingly.  Note that the `alfresco-incubator/alfresco-content-services` chart will deploy using default values (Ex: `postgresPassword = "alfresco"`).

```bash
# Example: For a hardened DB password:
 --set postgresql.postgresPassword="bLah!"
```

For more parameter options, see the [acs-deployment configuration table](https://github.com/Alfresco/acs-deployment/tree/master/helm/alfresco-content-services#configuration).

### Using an external database instance

* Deploy the helm repository using the following values:

```
# Install ACS
helm install alfresco-incubator/alfresco-content-services \
--set externalProtocol="https" \
--set externalHost="$EXTERNALHOST" \
--set externalPort="443" \
--set repository.adminPassword="$ALF_ADMIN_PWD" \
--set alfresco-infrastructure.persistence.efs.enabled=true \
--set alfresco-infrastructure.persistence.efs.dns="$EFS_SERVER" \
--set alfresco-search.resources.requests.memory="2500Mi",alfresco-search.resources.limits.memory="2500Mi" \
--set alfresco-search.environment.SOLR_JAVA_MEM="-Xms2000M -Xmx2000M" \
--set persistence.repository.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/repository-data" \
--set persistence.solr.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/solr-data" \
--set postgresql.enabled=false \
--set database.external=true \
--set database.driver="org.postgresql.Driver" \
--set database.user="myuser" \
--set database.password="mypass" \
--set database.url="jdbc:postgresql://mydb.eu-west-1.rds.amazonaws.com:5432/mydb" \
--set registryPullSecrets=quay-registry-secret \
--namespace=$DESIREDNAMESPACE
```

**Note:** If you want to connect to a different database type, you'll first need to rebuild the docker image with the additional driver in `/usr/local/tomcat/libs`.

**Note:** When using an external database, make sure that the database is reachable by the K8S nodes and is up and ready.

### Using an external messaging broker

By default, Alfresco Content Services deployment uses the ActiveMQ from alfresco-infrastructure-deployment.

If you want to use an external messaging broker (such as Amazon MQ), you can disable the default option by passing the following argument to the `helm install` command:

```bash
--set activemq.enabled=false
```

Also, you will need to specify the URL for this broker, an user and a password, as shown below:

```bash
# Publish messaging broker details (example for Amazon MQ)
export MESSAGE_BROKER_URL="nio+ssl://<BROKER_ID>.mq.<AWS-REGION>.amazonaws.com:61617"
export MESSAGE_BROKER_USER="user_for_this_broker"
export MESSAGE_BROKER_PASSWORD="password_for_this_broker"

# Install ACS
helm install alfresco-incubator/alfresco-content-services \
--set externalProtocol="https" \
--set externalHost="$EXTERNALHOST" \
--set externalPort="443" \
--set repository.adminPassword="$ALF_ADMIN_PWD" \
--set alfresco-infrastructure.persistence.efs.enabled=true \
--set alfresco-infrastructure.persistence.efs.dns="$EFS_SERVER" \
--set alfresco-search.resources.requests.memory="2500Mi",alfresco-search.resources.limits.memory="2500Mi" \
--set alfresco-search.environment.SOLR_JAVA_MEM="-Xms2000M -Xmx2000M" \
--set persistence.repository.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/repository-data" \
--set persistence.solr.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/solr-data" \
--set postgresql.postgresPassword="$ALF_DB_PWD" \
--set postgresql.persistence.subPath="$DESIREDNAMESPACE/alfresco-content-services/database-data" \
--set messageBroker.url="$MESSAGE_BROKER_URL" \
--set messageBroker.user="$MESSAGE_BROKER_USER" \
--set messageBroker.password="$MESSAGE_BROKER_PASSWORD" \
--set registryPullSecrets=quay-registry-secret \
--namespace=$DESIREDNAMESPACE
```

### Using the Alfresco S3 Connector

If you have the S3 Connector AMP applied to your docker image, then you can enable it in Kubernetes by setting the following values:

```
helm install alfresco-incubator/alfresco-content-services \
--set externalProtocol="https" \
--set externalHost="$EXTERNALHOST" \
--set externalPort="443" \
--set repository.adminPassword="$ALF_ADMIN_PWD" \
--set alfresco-infrastructure.persistence.efs.enabled=true \
--set alfresco-infrastructure.persistence.efs.dns="$EFS_SERVER" \
--set alfresco-search.resources.requests.memory="2500Mi",alfresco-search.resources.limits.memory="2500Mi" \
--set alfresco-search.environment.SOLR_JAVA_MEM="-Xms2000M -Xmx2000M" \
--set persistence.solr.data.subPath="$DESIREDNAMESPACE/alfresco-content-services/solr-data" \
--set persistence.repository.enabled=false \
--set s3connector.enabled=true \
--set s3connector.config.bucketName=myBucket \
--set s3connector.secrets.encryption=kms \
--set s3connector.secrets.awsKmsKeyId=Your KMS Key ID \
--set registryPullSecrets=quay-registry-secret \
--namespace=$DESIREDNAMESPACE
```

**Note:** For additional information on the S3 Connector benefits, installation and configuration, see the [Alfresco Content Connector for AWS S3 documentation](https://docs.alfresco.com/s3connector/concepts/s3-contentstore-overview.html).

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
  Share: https://$EXTERNALHOST/share
  Content: https://$EXTERNALHOST/alfresco
```

To see the full list of values that were applied to the deployment, run:
```bash
helm get values -a $ACSRELEASE
```

### Network Hardening

The `kops` utility sets up a platform for the ACS cluster, but with some extra steps you can harden the networking on your AWS infrastructure.  

See AWS documentation: https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html

Below are some recommended modifications to Security Groups (SG) that manage Inbound and Outbound traffic.


#### Lockdown Bastion

By default, SSH access to the bastion host is open from everywhere for Inbound and Outbound traffic.  You may want to lock it down to a specific IP address(es).

<details><summary>
Below is an example of how to modify the Bastion traffic with the AWS Cli.</summary>
<p>

```bash
# Get Bastion Host Security Group
export BASTION_HOST_SG=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=bastion.$KOPS_NAME" --output text --query "SecurityGroups[].GroupId")

# Get Bastion ELB Security Group
export BASTION_ELB_SG=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=bastion-elb.$KOPS_NAME" --output text --query "SecurityGroups[].GroupId")

# Get Masters Host Security Group
export MASTERS_HOST_SG=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=masters.$KOPS_NAME" --output text --query "SecurityGroups[].GroupId")

# Get Nodes Host Security Group
export NODES_HOST_SG=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=nodes.$KOPS_NAME" --output text --query "SecurityGroups[].GroupId")

# Get API ELB Security Group
export API_ELB_SG=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=api-elb.$KOPS_NAME" --output text --query "SecurityGroups[].GroupId")

# Get Kubernetes ELB Security Group
export K8S_ELB_SG=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=['k8s-elb-*']" --output text --query "SecurityGroups[].GroupId")

# Revoke default Bastion Host Egress which is open for everything
aws ec2 revoke-security-group-egress --group-id $BASTION_HOST_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'

# Revoke default Bastion ELB Egress which is open for everything
aws ec2 revoke-security-group-egress --group-id $BASTION_ELB_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'

# Limit Bastion Host Egress to only Port 22 of Bastion ELB SG
aws ec2 authorize-security-group-egress --group-id $BASTION_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "UserIdGroupPairs": [{"GroupId": '\"$BASTION_ELB_SG\"', "Description": "Bastion host outbound traffic limited to Bastion ELB"}]}]'

# Limit Bastion ELB Egress to only Port 22 of Bastion Host SG (please replace "0.0.0.0/0" with your CIDR block)
aws ec2 authorize-security-group-ingress --group-id $BASTION_ELB_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "Allow SSH inbound communication to ACS Bastion"}]}]'

# Allow Bastion to grant SSH access to Master(s) Host
aws ec2 authorize-security-group-egress --group-id $BASTION_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "UserIdGroupPairs": [{"GroupId": '\"$MASTERS_HOST_SG\"', "Description": "Allow Bastion host to make SSH connection with Kubernetes Master nodes"}]}]'

# Allow Bastion to grant SSH access to Node(s) Host
aws ec2 authorize-security-group-egress --group-id $BASTION_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "UserIdGroupPairs": [{"GroupId": '\"$NODES_HOST_SG\"', "Description": "Allow Bastion host to make SSH connection with Kubernetes worker Nodes"}]}]'
```

</p>
</details>


#### Restrict k8s Master(s) Outbound traffic

By default, Outbound traffic is allowed from Master Security Group to everywhere.  This can be restricted by allowing explicit Outbound to be same as Inbound.

<details><summary>
Below is an example of how to modify Master SG Outbound traffic with the AWS Cli.</summary>
<p>

```bash
# Allow Outbound traffic among Master(s) nodes
aws ec2 authorize-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "UserIdGroupPairs": [{"GroupId": '\"$MASTERS_HOST_SG\"', "Description": "Outbound traffic among Master(s) nodes"}]}]'

# Allow Outbound traffic between Master(s) and Node(s) Host
aws ec2 authorize-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 1, "ToPort": 2379, "UserIdGroupPairs": [{"GroupId": '\"$NODES_HOST_SG\"', "Description": "TCP Outbound traffic between Master(s) & Node(s)"}]}]'

aws ec2 authorize-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 2382, "ToPort": 4001, "UserIdGroupPairs": [{"GroupId": '\"$NODES_HOST_SG\"', "Description": "TCP Outbound traffic between Master(s) & Node(s)"}]}]'

aws ec2 authorize-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 4003, "ToPort": 65535, "UserIdGroupPairs": [{"GroupId": '\"$NODES_HOST_SG\"', "Description": "TCP Outbound traffic between Master(s) & Node(s)"}]}]'

aws ec2 authorize-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "udp", "FromPort": 1, "ToPort": 65535, "UserIdGroupPairs": [{"GroupId": '\"$NODES_HOST_SG\"', "Description": "UDP Outbound traffic between Master(s) & Node(s)"}]}]'

aws ec2 authorize-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "4", "FromPort": -1, "ToPort": -1, "UserIdGroupPairs": [{"GroupId": '\"$NODES_HOST_SG\"', "Description": "IPv4 Outbound traffic between Master(s) & Node(s)"}]}]'

# Allow Outbound traffic between Master(s) and Bastion Host
aws ec2 authorize-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "UserIdGroupPairs": [{"GroupId": '\"$BASTION_HOST_SG\"', "Description": "Outbound traffic between Master(s) & Bastion Host"}]}]'

# Allow Outbound traffic between Master(s) and API ELB
aws ec2 authorize-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 443, "ToPort": 443, "UserIdGroupPairs": [{"GroupId": '\"$API_ELB_SG\"', "Description": "Outbound traffic between Master(s) & API ELB"}]}]'

# Once Outbound rules are in place, revoke default Outbound rule which is open for everything
aws ec2 revoke-security-group-egress --group-id $MASTERS_HOST_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'
```

</p>
</details>


#### Restrict k8s Node(s) Outbound traffic

By default, Outbound traffic is allowed from Node Security Group to everywhere.  This can be restricted by allowing explicit Outbound to be same as Inbound.

<details><summary>
Below is an example of how to modify Node SG Outbound traffic with the AWS Cli.</summary>
<p>

```bash
# Allow Outbound traffic among Node(s) nodes
aws ec2 authorize-security-group-egress --group-id $NODES_HOST_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "UserIdGroupPairs": [{"GroupId": '\"$MASTERS_HOST_SG\"', "Description": "Outbound traffic among Node(s)"}]}]'

# Allow Outbound traffic between Node(s) and Master(s) Host
aws ec2 authorize-security-group-egress --group-id $NODES_HOST_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "UserIdGroupPairs": [{"GroupId": '\"$NODES_HOST_SG\"', "Description": "Outbound traffic between Master(s) & Node(s)"}]}]'

# Allow Outbound traffic between Node(s) and K8S ELB
aws ec2 authorize-security-group-egress --group-id $NODES_HOST_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "UserIdGroupPairs": [{"GroupId": '\"$K8S_ELB_SG\"', "Description": "Outbound traffic between Node(s) & K8S ELB"}]}]'

# Allow Outbound traffic between Node(s) and Bastion Host
aws ec2 authorize-security-group-egress --group-id $NODES_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 22, "ToPort": 22, "UserIdGroupPairs": [{"GroupId": '\"$BASTION_HOST_SG\"', "Description": "Outbound traffic between Node(s) & Bastion Host"}]}]'

# Allow Outbound traffic between Node(s) and DockerHub to pull images
aws ec2 authorize-security-group-egress --group-id $NODES_HOST_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 443, "ToPort": 443, "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "Allow Nodes to pull images from DockerHub"}]}]'

# Once Outbound rules are in place, revoke default Outbound rule which is open for everything
aws ec2 revoke-security-group-egress --group-id $NODES_HOST_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'
```

</p>
</details>


#### Restrict API ELB Outbound traffic

By default, Outbound traffic is allowed from API ELB Security Group to everywhere.  This can be restricted by allowing explicit Outbound to the ELB Instances.

<details><summary>
Below is an example of how to modify API ELB SG Outbound traffic with the AWS Cli.</summary>
<p>

```bash
# Allow Outbound traffic between API ELB and Instances that it is listening to
aws ec2 authorize-security-group-egress --group-id $API_ELB_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 443, "ToPort": 443, "UserIdGroupPairs": [{"GroupId": '\"$MASTERS_HOST_SG\"', "Description": "Outbound traffic between API ELB and instances it is listening to"}]}]'

# Once Outbound rules are in place, revoke default Outbound rule which is open for everything
aws ec2 revoke-security-group-egress --group-id $API_ELB_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'
```

</p>
</details>


#### Restrict K8S ELB Outbound traffic

By default, Outbound traffic is allowed from K8S ELB Security Group to everywhere.  This can be restricted by allowing explicit Outbound to the ELB Instances.

<details><summary>
Below is an example of how to modify K8S ELB SG Outbound traffic with the AWS Cli.</summary>
<p>

```bash
# Allow Outbound traffic between K8S ELB and Instances that it is listening to
aws ec2 authorize-security-group-egress --group-id $K8S_ELB_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "UserIdGroupPairs": [{"GroupId": '\"$NODES_HOST_SG\"', "Description": "HTTP Outbound traffic between K8S ELB and instances it is listening to"}]}]'

# Once Outbound rules are in place, revoke default Outbound rule which is open for everything
aws ec2 revoke-security-group-egress --group-id $K8S_ELB_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'
```

</p>
</details>


#### Restrict Default SG Outbound traffic

By default, Outbound traffic is allowed from default Security Group to everywhere.  This can be restricted by allowing explicit Outbound to be same as Inbound.

<details><summary>
Below is an example of how to modify default SG Outbound traffic with the AWS Cli.</summary>
<p>

```bash
# Allow Outbound traffic between default SG
aws ec2 authorize-security-group-egress --group-id $DEFAULT_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "UserIdGroupPairs": [{"GroupId": '\"$DEFAULT_SG\"', "Description": "Outbound traffic among default SG"}]}]'

# Allow Outbound traffic for EFS for IPv4 & IPv6
aws ec2 authorize-security-group-egress --group-id $DEFAULT_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 2049, "ToPort": 2049, "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "IPv4 Outbound traffic for EFS Mount point"}]}]'
aws ec2 authorize-security-group-egress --group-id $DEFAULT_SG --ip-permissions '[{"IpProtocol": "tcp", "FromPort": 2049, "ToPort": 2049, "Ipv6Ranges": [{"CidrIpv6": "::/0", "Description": "IPv6 Outbound traffic for EFS Mount point"}]}]'

# Once Outbound rules are in place, revoke default Outbound rule which is open for everything
aws ec2 revoke-security-group-egress --group-id $DEFAULT_SG --ip-permissions '[{"IpProtocol": "-1", "FromPort": -1, "ToPort": -1, "IpRanges": [{"CidrIp": "0.0.0.0/0"}]}]'
```

</p>
</details>


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
