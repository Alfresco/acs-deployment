
# Alfresco Content Services Deployment

## Contributing guide
Please use [this guide](CONTRIBUTING.md) to make a contribution to the project.

This project contains the code for starting the entire Alfresco Content Services (Enterprise) product with **Docker** or **Kubernetes**.

For the Community edition, go to the [acs-community-deployment](https://github.com/Alfresco/acs-community-deployment).
The only two differences between these projects are:
* In the enterprise chart, the transformers images are used, instead of the included binaries.
* In the enterprise chart, a cluster of two `alfresco-content-repositories` are started by default.

## Contents of the deployment
Alfresco Content Services deployed via docker-compose or Kubernetes contains the following:
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
* [Running with Helm charts on AWS](docs/helm-deployment-aws_cloud.md)
* [Running with Helm charts using Minikube](docs/helm-deployment-localhost.md)
* [Running Docker Compose](docs/docker-compose-deployment.md)
* [Customizing your deployment](docs/customising-deployment.md)

## Other information
* See alternative commands and start up [tutorial with AWS support](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/running-a-cluster.md)
* [Tips and tricks](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/tips-and-tricks.md) for working with Kubernetes and ACS.
