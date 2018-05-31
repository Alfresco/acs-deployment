# Alfresco Content Services Deployment on AWS with Kubernetes

## Prerequisites

The Alfresco Content Services (ACS) Deployment on AWS with Kubernetes requires:

| Component   | Recommended version | Getting Started Guide |
| ------------|:-----------: | ---------------------- |
| Docker      | 17.0.9.1     | https://docs.docker.com/ |
| Kubernetes  | 1.8.4        | https://kubernetes.io/docs/tutorials/kubernetes-basics/ |
| Kubectl     | 1.8.4        | https://kubernetes.io/docs/tasks/tools/install-kubectl/ |
| Helm        | 2.8.2        | https://docs.helm.sh/using_helm/#quickstart-guide |
| Kops        | 1.8.1        | https://github.com/kubernetes/kops/blob/master/docs/aws.md |
| AWS Cli     | 1.11.190      | https://github.com/aws/aws-cli#installation |

Any variation from these technologies and versions may affect the end result.

*Note:* You do not need to clone this repo to deploy the ACS.


### Setup Kubernetes Cluster on AWS

* Add Alfresco Helm charts repository.
```bash
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
```

* Export AWS Credentials of the user.
```bash
# Access Key & Secret
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXX
(or)
# AWS Profile
export AWS_PROFILE="<profile-name>"

export AWS_DEFAULT_REGION="<region-name>"
```

* Name the ACS environment.
```bash
export KOPS_NAME="myacs.example.com"
```

* Provide an S3 bucket name to store cluster configuration used by `kops`.  This bucket need to be created before hand.
```bash
# If s3 bucket is not already created
$ aws s3 mb s3://my-bucket-kops-store

export KOPS_STATE_STORE="s3://my-bucket-kops-store"
```

* Create kubernetes cluster using `kops` utility.
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
  --networking weave \
  --yes
```
Please adjust above values accordingly (ex: `--node-size`, `--kubernetes-version` etc.)
NB: The default bastion user name is `admin` accessible via Bastion ELB (and not the ec2 host where bastion is running)

### Add-ons to manage Kubernetes cluster via Kubernetes Dashboard
* Install [Kubernetes dashboard](https://github.com/kubernetes/dashboard).  This Kubernetes UI helps in veiwing and managing above created cluster from localhost (Ex: Work laptop).
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
```

* Enable access control to manage AWS Kubernetes Cluster
<details><summary>click here to see dashboard-admin.yaml</summary>
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

```bash
kubectl create -f dashboard-admin.yaml
```

* Redirect above AWS Kubernetes cluster to manage via localhost with `kubectl` (on default port `8001`).
```bash
kubectl proxy &
# To use a custom port: `kubectl proxy --port=8002 &` 
```

* To access cluster locally go to: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/ and then press 'skip' in auth page


### ACS Cluster setup on Kubernetes Cluster
Once the platform for Kubernetes is setup on AWS, ACS can now be installed on it.

* Create a namespace to host ACS application inside it.  A kubernetes cluster can have many namespaces to separate and isolate multiple application environments (Ex: dev, staging, prod).
```bash
export DESIREDNAMESPACE=dev-myacs-namespace
kubectl create namespace $DESIREDNAMESPACE
```

* Create tiller (cluster wide) & add cluster admin role to tiller.  It should not be isolated in a namespace as ingress needs to set up cluster roles [https://github.com/kubernetes/helm/blob/master/docs/rbac.md].
<details><summary>click here to see tiller-rbac-config.yaml</summary>
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

```bash
kubectl create -f tiller-rbac-config.yaml
```

* Initialise tiller
```bash
helm init --service-account tiller
```
The above step may not even be needed as by default `kubectl` will create and initialise the service.

* Install `nginx-ingress` service to create web service, virtual LBs and AWS ELB inside `$DESIREDNAMESPACE` to serve ACS application
<details><summary>click here to see ingressvalues.yaml</summary>
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
or
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
Please adjust above values accordingly (ex: `--version` (of `nginx-ingress`), `controller.service.annotations` etc.)

* To view AWS ELB DNS name, please note down the `nginx-ingress` release from the output of above command.  It should be something like (Ex: `NAME:  knobby-wolf`)
```bash
export INGRESSRELEASE=knobby-wolf
export ELBADDRESS=$(kubectl get services $INGRESSRELEASE-nginx-ingress-controller --namespace=$DESIREDNAMESPACE -o jsonpath={.status.loadBalancer.ingress[0].hostname})
echo $ELBADDRESS
```

* Create an EFS storage on AWS and make sure it is in the same VPC as your cluster by following this [guide](https://github.com/Alfresco/alfresco-dbp-deployment#6-efs-storage-note-only-for-aws).  Make sure you open inbound traffic in the security group to allow NFS traffic.  Below is an example to create it with AWS Cli.
<details><summary>click here to see an example</summary>
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

# Before we could create any EFS Mount point, it is important to know cluster's VPC, Subnet (tagged with 'Utility') & Security Group in which it needs to go
export VPC_ID=$(aws ec2 describe-vpcs --filters "Name=tag:KubernetesCluster,Values=$KOPS_NAME" --output text --query '[Vpcs[].VpcId]')
export SUBNET_ID=$(aws ec2 describe-subnets --filters "Name=tag:KubernetesCluster,Values=$KOPS_NAME" "Name=tag:SubnetType,Values=Utility"  --output text --query 'Subnets[].[SubnetId]')
export DEFAULT_SG=$(aws ec2 describe-security-groups --filters "Name=vpc-id,Values=$VPC_ID" "Name=group-name,Values=default" --output text --query "SecurityGroups[].GroupId")

# Create EFS Mount Point & may take some time to complete creation
aws efs create-mount-target --file-system-id $EFS_FS_ID --subnet-id $SUBNET_ID

# Query if the the EFS Mount point is available. After few minutes it should print a string 'available'.
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

* Deploy ACS
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
For more parameter options please see [acs-deployment](https://github.com/Alfresco/acs-deployment/tree/master/helm/alfresco-content-services#configuration)

You can set ACS stack configuration attributes above accordingly.  By default the ACS chart will deploy using default values (Ex: `postgresPassword = "alfresco"`).
```bash
#example: For a hardened DB password:
 --set postgresql.postgresPassword="bLah!"
```


### Create a Route53 Record Set in your HostedZone

Go to AWS Console -> Route53 -> Hosted zones -> Select the zone -> Create Record Set -> Name: "$EXTERNALHOST", Alias: 'Yes' [Alias Target: "select your ELB ($ELBADDRESS)"] -> Create

You may need to wait couple of minutes before the record set propagates around the world.


### Checkout the status of your ACS deployment:

From command line, `helm status` will give status of helm stacks created
```bash
helm status $INGRESSRELEASE
helm status $ACSRELEASE
```

You can access all components of Alfresco Content Services using the same root address, but different paths as follows:
```bash
  Content: https://$EXTERNALHOST/alfresco
  Share: https://$EXTERNALHOST/share
  Solr: https://$EXTERNALHOST/solr
```

If you want to see the full list of values that have been applied to the deployment you can run:

```bash
helm get values -a $ACSRELEASE
```


### Teardown:

```bash
# Delete helm charts: Nginx-ingress & ACS
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

Depending on your cluster type you should be able to also delete it if you want.
For minikube you can just run to delete the whole minikube vm.
```bash
minikube delete
```

For more information on running and tearing down k8s environments, follow this [guide](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/running-a-cluster.md).


### Upgrading cluster:

* (Optional) Edit worker nodes configuration to include spot price:
```
kops edit ig nodes
```

Include the following into the config:
```
spec:
  maxPrice: "0.07"
```

* (Optional) Enable required admission controllers, for example Pod Security Policy, see [these instructions](Apply-PSP).

* Update the cluster
```
kops update cluster --yes
kops rolling-update cluster --yes
```