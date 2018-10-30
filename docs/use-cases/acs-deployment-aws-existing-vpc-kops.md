# Alfresco Content Services Deployment with Helm on AWS using Kops in an existing VPC

It is possible to deploy an ACS Helm chart on AWS with Kops utility in an existing VPC.  Below is an example of setting up in US-East-1 (N.Virginia) region.

## Export Kops setup environment variables

```bash
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_DEFAULT_REGION="us-east-1"
export KOPS_NAME="sharedvpc"
export KOPS_STATE_STORE=s3://<somes3bucket>
export CLUSTER_NAME="sharedvpc.mydomain.com"
```

## Export VPC Id and Network CIDR

```bash
export VPC_ID=vpc-12345678 # replace with your VPC id
export NETWORK_CIDR=172.30.0.0/16 # replace with the cidr for the VPC ${VPC_ID}
``` 

## Create new Utility and Private subnets inside the VPC

By default, if an existing VPC_ID and its NETWORK_CIDR are provided with the kops create cluster command, it will try to create a Utility and Private subnets. However, if any of the subnets that are about to be created by kops exist, then the cluster creation will fail.  To avoid this problem, it is recommended that you create subnets beforehand.

Depending on the number of Availability Zones (AZ) configured, utility and private subnets should be created in each of the AZs.

For example, if the Kubernetes cluster is intended to run in US-East-1 with 3 AZs (us-east-1a, us-east-1b and us-east-1c) then 3 Utility and 3 Private subnets need to be created in that existing VPC.

From the **AWS Console**, select **Services** -> **VPC Dashboard** -> **Subnet**s -> **Create Subnet** ->

Utility subnet in AZ-1:
```
Name tag: utility-us-east-1a.sharedvpc.mydomain.com
VPC: vpc-12345678
Availability Zone: us-east-1a
IPv4 CIDR block: 172.30.3.0/24
```

Utility subnet in AZ-2:
```
Name tag: utility-us-east-1b.sharedvpc.mydomain.com
VPC: vpc-12345678
Availability Zone: us-east-1b
IPv4 CIDR block: 172.30.4.0/24
```

Utility subnet in AZ-3:
```
Name tag: utility-us-east-1c.sharedvpc.mydomain.com
VPC: vpc-12345678
Availability Zone: us-east-1c
IPv4 CIDR block: 172.30.5.0/24
```

Private subnet in AZ-1:
```
Name tag: us-east-1a.sharedvpc.mydomain.com
VPC: vpc-12345678
Availability Zone: us-east-1a
IPv4 CIDR block: 172.30.6.0/24
```

Private subnet in AZ-2:
```
Name tag: us-east-1b.sharedvpc.mydomain.com
VPC: vpc-12345678
Availability Zone: us-east-1b
IPv4 CIDR block: 172.30.7.0/24
```

Private subnet in AZ-3:
```
Name tag: us-east-1c.sharedvpc.mydomain.com
VPC: vpc-12345678
Availability Zone: us-east-1c
IPv4 CIDR block: 172.30.8.0/24
```

## Tagging the subnets

It is important to tag the above subnets to enable Kops to setup a cluster in a shared VPC with the above subnets.

Select each of the above subnets and add the tags below:

For Utility Subnets:
```
KubernetesCluster: sharedvpc.mydomain.com
SubnetType: Utility
kubernetes.io/cluster/sharedvpc.mydomain.com: shared
kubernetes.io/role/elb: 1
```

For Private Subnets:
```
KubernetesCluster: sharedvpc.mydomain.com
SubnetType: Private
kubernetes.io/cluster/sharedvpc.mydomain.com: shared
kubernetes.io/role/internal-elb: 1
```

## Export the subnets as environment variables

```bash
export SUBNET_IDS_UTILITY="subnet-xxutility1a,subnet-xxutility1b,subnet-xxutility1c"
export SUBNET_IDS_PRIVATE="subnet-xxprivate1a,subnet-xxprivate1b,subnet-xxprivate1c"
```

## Create kops cluster in the existing VPC with new subnets

```bash
kops create cluster \
--name $KOPS_NAME \
--state $KOPS_STATE_STORE \
--ssh-public-key <some-public-key.pub> \
--node-count <2> \
--zones us-east-1a,useast-1b,us-east-1c \
--master-zones us-east-1a,useast-1b,us-east-1c \
--cloud aws \
--node-size m4.xlarge \
--master-size t2.medium \
-v 10 \
--kubernetes-version "1.10.1" \
--bastion \
--topology private \
--vpc=${VPC_ID} \
--subnets=${SUBNET_IDS_PRIVATE} \
--utility-subnets=${SUBNET_IDS_UTILITY} \
--networking calico --yes
```

## Validate the cluster creation

```bash
kops validate cluster
Using cluster from kubectl context: sharedvpc.mydomain.com

Validating cluster sharedvpc.mydomain.com


unexpected error during validation: error listing nodes: Get https://api.sharedvpc.mydomain.com/api/v1/nodes: EOF
```

This is an expected error and it just means the kops cluster was created but not successful due to missing dependencies to make the cluster working.

To fix this below steps are required.


## Create a NAT Gateway in the existing VPC

Kops require a NAT gateway to route traffic to enable Kubernetes API ELB to talk to Kubernetes Master node(s).

* From the **AWS Console**, select **Services** -> **VPC Dashboard** -> **NAT Gateways** -> **Create NAT Gateway** ->
```
Subnet: Select one of the Utility subnet (us-east-1a subnet Id)
Elastic IP Allocation ID: Create New EIP
```

* Click `Create a NAT Gateway` and wait for NAT Gateway to become available.

* Tag the above NAT Gateway as:
```
KubernetesCluster: sharedvpc.mydomain.com
Name: us-east-1a.sharedvpc.mydomain.com
kubernetes.io/cluster/sharedvpc.mydomain.com: owned
```

## Create Route Tables in the existing VPC

Kops require creation of new routes for Utility and Private subnets to route traffic

* From the **AWS Console**, select **Services** -> **VPC Dashboard** -> **Route Tables** -> **Create Route Table**.

* Create a Utility subnet route:
```
Name tag: sharedvpc.mydomain.com
VPC: Select the VPC
```

* Click `Yes, Create` to create the route.

* Create a Private subnet route:
```
Name tag: private-us-east-1a-sharedvpc.mydomain.com
VPC: Select the VPC
```

* Click `Yes, Create` to create the route.

### Tag Route Tables

For Utility subnet route
```
KubernetesCluster: sharedvpc.mydomain.com
kubernetes.io/cluster/sharedvpc.mydomain.com: owned
kubernetes.io/kops/role: public
```

For Private subnet route
```
KubernetesCluster: sharedvpc.mydomain.com
kubernetes.io/cluster/sharedvpc.mydomain.com: owned
kubernetes.io/kops/role: private-us-east-1a
```

### Route Tables subnet association

For Utility subnet route add all the `Utility` subnets in `Subnet Associations` of the route table
```
subnet-xxxxx | utility-us-east-1a.sharedvpc.mydomain.com
subnet-xxxxx | utility-us-east-1b.sharedvpc.mydomain.com
subnet-xxxxx | utility-us-east-1c.sharedvpc.mydomain.com
```

For Private subnet route add all the `Private` subnets in `Subnet Associations` of the route table
```
subnet-xxxxx | us-east-1a.sharedvpc.mydomain.com
subnet-xxxxx | us-east-1b.sharedvpc.mydomain.com
subnet-xxxxx | us-east-1c.sharedvpc.mydomain.com
```

### Route Tables Add Routes

For Utility subnet route table, edit and add a new route with internet gateway ID.
```
Destination: 0.0.0.0/0
Target: igw-xxxxxx` (This Internet Gateway is created by kops while creating the cluster) 
```

For Private subnet route table, edit and add a new route with nat gateway ID.
```
Destination: 0.0.0.0/0
Target: nat-xxxxxx (This NAT Gateway was created manually above to fix kops validate cluster error) 
```

## Re-run the kops validate cluster

```bash
kops validate cluster
Using cluster from kubectl context: sharedvpc.mydomain.com

Validating cluster sharedvpc.mydomain.com

INSTANCE GROUPS
NAME			ROLE	MACHINETYPE	MIN	MAX	SUBNETS
bastions		Bastion	t2.micro	1	1	utility-us-east-1a
master-us-east-1a	Master	t2.medium	1	1	us-east-1a,us-east-1b,us-east-1c
nodes			Node	m4.xlarge	2	2	us-east-1a,us-east-1b,us-east-1c

NODE STATUS
NAME						ROLE	READY
ip-172-30-6-113.us-east-1.compute.internal	node	True
ip-172-30-6-196.us-east-1.compute.internal	node	True
ip-172-30-6-50.us-east-1.compute.internal	master	True

Your cluster sharedvpc.mydomain.com is ready
```

## Configure Nginx-Ingress controller

Follow the steps outlined in [Deploying the Ingress for Alfresco Content Services](../helm-deployment-aws_kops.md#deploying-the-ingress-for-alfresco-content-services).


## Allow ALL Traffic of Ingress ELB Security Group in Kubernetes Nodes Security Group

The Kubernetes nodes security group should be added with a TCP rule to allow ALL traffic from the Kubernetes ELB (created by the nginx-ingress controller).

* From the **AWS Console**, select **Services** -> **VPC Dashboard** -> **Security** -> **Security Groups** -> search for your VPC SGs

* There should be a security group starting with `k8s-elb-<ELB-Address>` which is the ingress controller security group.  Note down the security group ID.

* There should be another security group starting with `nodes.*` which is the Kubernetes nodes security group.  Edit the `Inbound Rules` and add a new rule as:

```
Type: ALL Traffic
Protocol: ALL
Port Range: ALL
Source: sg-<k8s-elb-sg-id>
```

Follow the rest of the deployment steps in [ACS deployment with Helm using Kops](../helm-deployment-aws_kops.md#deploying-alfresco-content-services)
