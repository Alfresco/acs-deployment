# Alfresco Content Services Deployment with AWS EKS

Amazon's EKS (Elastic Container Service for Kubernetes) makes it easy to deploy, manage, and scale containerized applications using Kubernetes on AWS. EKS runs the Kubernetes management infrastructure for you across multiple AWS availability zones to eliminate a single point of failure.

## Prerequisites

To run the Alfresco Content Services (ACS) deployment on AWS EKS requires:

| Component   | Getting Started Guide |
| ------------| --------------------- |
| Docker      | https://docs.docker.com/ |
| Kubernetes  | https://kubernetes.io/docs/tutorials/kubernetes-basics/ |
| Kubectl     | https://kubernetes.io/docs/tasks/tools/install-kubectl/ |
| Helm        | https://docs.helm.sh/using_helm/#quickstart-guide |
| EKS         | https://aws.amazon.com/eks/ |
| AWS Cli     | https://github.com/aws/aws-cli#installation |

**Note:** You don't need to clone this repository to deploy Alfresco Content Services.


### Setting up Amazon EKS

* Export your AWS user credentials:
```bash
# Access Key & Secret
export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXX
(or)
# AWS Profile
export AWS_PROFILE="<profile-name>"

# AWS Region
export AWS_DEFAULT_REGION="<region-name>"
```

* Follow the steps in the [EKS Getting Started Guide](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html):

These steps will take you through...
- Creating an Amazon EKS Service Role
- Creating an Amazon EKS Cluster VPC
- Setting up kubectl for EKS authentication
- Creating an EKS Cluster
- Configuring kubectl to access the EKS Cluster
- Configuring and launching EKS worker nodes

**Note:** It is recommended to choose an EC2 instance type of at least m4.xlarge to provision enough memory for reasonable pod allocation across the nodes.

* Install the [Kubernetes Dashboard](https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html)

* Allow EKS worker nodes to mount an NFS volume:

**Note** The following is a temporary step until an AMI with built-in NFS support is available, or managed storage such as S3 and RDS are provisioned in the alfresco-content-services Helm chart, or another working approach is found.

On each EKS worker node EC2 instance, [install the Amazon EFS Utils package](https://docs.aws.amazon.com/efs/latest/ug/using-amazon-efs-utils.html#installing-amazon-efs-utils). Note, that if done manually, any new worker nodes provisioned by the EKS scaling group will not be configured correctly. Alternatively, a new AMI could be built from the EKS base AMI with NFS support which is then used when configuring and launching the EKS worker nodes.

### Deploying Helm

* Follow the steps outlined in [Deploying Helm](helm-deployment-aws_cloud.md#deploying-helm)

## Setting up Alfresco Content Services

* Follow the steps outlined in [Setting up Alfresco Content Services](helm-deployment-aws_cloud.md#setting-up-alfresco-content-services)

## Checking the status of your deployment

* Follow the steps outlined in [Checking the status of your deployment](helm-deployment-aws_cloud.md#checking-the-status-of-your-deployment)

## Cleaning up your deployment

* Follow the steps outlined in [Deleting a Cluster](https://docs.aws.amazon.com/eks/latest/userguide/delete-cluster.html)
