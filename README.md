
# Alfresco Content Services Deployment

## Contributing guide
Please use [this guide](CONTRIBUTING.md) to make a contribution to the project and information to report any issues.

This project contains the code for starting the entire Alfresco Content Services (Enterprise) product with **Docker** or **Kubernetes**.

The **master** branch of this repository will endeavour to support the following deployments:
- [Docker Compose](docs/docker-compose-deployment.md) (latest): For development and trials
- [MiniKube](docs/helm-deployment-minikube.md) (latest): For development and POCs
- [Helm - AWS Cloud with Kubernetes](docs/helm-deployment-aws_cloud.md) (latest): For production or as a basis of production deployments

For the Community edition, go to the [acs-community-deployment](https://github.com/Alfresco/acs-community-deployment).
The only differences between these projects are:
* In the Enterprise chart, the images for the transformers are used, instead of the included binaries.
* In the Enterprise chart, a cluster of two `alfresco-content-repository` nodes are started by default.

## Contents of the deployment
Alfresco Content Services deployed via `docker-compose` or Kubernetes contains the following:
1. Alfresco Repository, with:  
1.1. Alfresco Share Services   
1.2. Alfresco Office Service (AOS) AMP  
1.3. Alfresco vti-bin war - helps with AOS integration  
1.4. Alfresco Google Docs Repo AMP  
2. Alfresco Share, with:  
2.1 Alfresco Google Docs Share AMP  
3. A Postgres DB  
4. Alfresco Search Services (Solr6)

## Deployment options
* [Deploying with Helm charts on AWS using Kops](docs/helm-deployment-aws_cloud.md)
* [Deploying with Helm charts on AWS using EKS](docs/helm-deployment-aws_eks.md)
* [Deploying with Helm charts using Minikube](docs/helm-deployment-minikube.md)
* [Deploying using Docker Compose](docs/docker-compose-deployment.md)
* [Customizing your deployment](docs/customising-deployment.md)

## Other information
* See alternative commands and start up [tutorial with AWS support](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/running-a-cluster.md)
* [Tips and tricks](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/tips-and-tricks.md) for working with Kubernetes and Alfresco Content Services.
