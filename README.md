
# Alfresco Content Services Deployment

## Contributing guide
Please use [this guide](CONTRIBUTING.md) to make a contribution to the project and information to report any issues.

This project contains the code for starting the entire Alfresco Content Services (Enterprise) product with **Docker** or **Kubernetes**.

The **master** branch of this repository will endeavour to support the following deployments:
- [Docker Compose](docs/docker-compose-deployment.md) (latest): For development and trials
- [MiniKube](docs/helm-deployment-minikube.md) (latest): For development and POCs
- [Helm - AWS Cloud with Kubernetes using Kops](docs/helm-deployment-aws_kops.md) (latest): As a deployment template which can be used as the basis for your specific deployment needs

For the Community Edition, go to the [acs-community-deployment](https://github.com/Alfresco/acs-community-deployment).
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
5. Alfresco Transform Service
6. Alfresco Digital Workspace

## Deployment options
* [Deploying with Helm charts on AWS using Kops](docs/helm-deployment-aws_kops.md)
* [Deploying with Helm charts on AWS using EKS](docs/helm-deployment-aws_eks.md)
* [Deploying with Helm charts using Minikube](docs/helm-deployment-minikube.md)
* [Deploying using Docker Compose](docs/docker-compose-deployment.md)
* [Customizing your deployment](docs/customising-deployment.md)

## Production environments
Alfresco provides tested Helm charts as a "deployment template" for customers who want to take advantage of the container orchestration benefits of Kubernetes. These Helm charts are undergoing continual development and improvement, and should not be used "as is" for your production environments, but should help you save time and effort deploying Alfresco Content Services for your organisation.

The Helm charts in this repository provide a PostgreSQL database in a Docker container and do not configure
any logging. This design has been chosen so that they can be installed in a Kubernetes cluster without
changes and are still flexible to be adopted to your actual environment.

For your environment, you should use these charts as a starting point and modify them so that ACS integrates
into your infrastructure. You typically want to remove the PostgreSQL container and connect the cs-repository
directly to your database (might require custom images to get the required JDBC driver in the container).
Another typical change would be the integration of your company-wide monitoring and logging tools.

## Other information
* See alternative commands and start up [tutorial with AWS support](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/running-a-cluster.md)
* [Tips and tricks](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/tips-and-tricks.md) for working with Kubernetes and Alfresco Content Services.
* The images downloaded directly from Docker Hub, or Quay.io are for a limited trial of the Enterprise version of Alfresco Content Services that goes into read-only mode after 2 days. If you'd like to try Alfresco Content Services for a longer period, request the 30-day [Download Trial](https://www.alfresco.com/platform/content-services-ecm/trial/download).
* Alfresco customers can request Quay.io credentials by logging a ticket with [Alfresco Support](https://support.alfresco.com/). These credentials are required to pull private (Enterprise-only) Docker images from Quay.io.

## On Cloud Supported/unsupported endpoints/features/amps

### Repository team

Supported:
* V1 REST API
* WebDAV
* CMIS (all three bindings)
* AOS
* S3
* Renditions
* Authentication with alfrescoNTLM
* Authentication with AIS (JWT)
* Email
* IMAP
* Activity Feeds / Subscriptions
* Build in ACS Workflows

Not Supported:
* FTP
* SAML
* LDAP
* Centera
* V0 APIs

Not supported OnPrem and OnCloud:
* Multi Tenancy
* SMB/CIFS
* Authentication with passthru
* The old Cloud Sync
* Transformations (we only support renditions)
