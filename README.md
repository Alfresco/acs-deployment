
# Alfresco Content Services Deployment

[![Build Status](https://travis-ci.com/Alfresco/acs-deployment.svg?branch=master)](https://travis-ci.com/Alfresco/acs-deployment)

This project contains the code for starting the entire Alfresco Content Services (ACS) product with [Docker](https://docs.docker.com/get-started) using [Docker Compose](https://docs.docker.com/compose) or [Kubernetes](https://kubernetes.io) using [Helm Charts](https://helm.sh).

## Prerequisites

By default the Enterprise version of ACS is installed. To accomplish this private Docker images stored in Quay.io are downloaded. Alfresco customers can request Quay.io credentials by logging a ticket with [Alfresco Support](https://support.alfresco.com/).

The images downloaded directly from Docker Hub, or Quay.io are for a limited trial of the Enterprise version of Alfresco Content Services that goes into read-only mode after 2 days. If you'd like to try Alfresco Content Services for a longer period, request the 30-day [Download Trial](https://www.alfresco.com/platform/content-services-ecm/trial/download).

To avoid license restrictions and private Docker images try the [Community Edition deployment](https://github.com/Alfresco/acs-community-deployment).

## Versioning

**NOTE:** **The versioning strategy used in this project has changed, if you have previously used this project please read this section carefully!**

The default options in the **master** branch of this repository contains the latest work-in-progress deployment scripts and installs the latest development version of ACS.

Individual files are now provided in the master branch to deploy the latest hot fix version of each major.minor version of ACS.

### Docker

The default docker compose file contains the latest work-in-progress deployment scripts and installs the latest development version of ACS.

To deploy a specific version of ACS several specific major.minor docker compose files are provided.

Our tests are executed using the latest version of Docker and Docker Compose provided by Travis.

### Helm

Version 5.0.0 of the ACS Helm chart has been updated to be version agnostic, meaning the same chart can now be used to deploy different versions of ACS.

By default the latest version of the chart will always deploy the latest development version of ACS. A set of values files are also provided that can be used to deploy a specific major.minor version.

NOTE: As the Helm chart no longer deploys a specific version of ACS the `appVersion` property within the chart is longer be specified.

Our tests are executed using Helm 3.2.4, kubectl 1.18.4 against an EKS clsuter running Kubernetes 1.17.

## Documentation

To get started please refer to the [Docker Compose](./docs/docker-compose) and [Helm Chart](./docs/helm) documentation.

## License

The code in this repository is released under the Apache License, see the [LICENSE](./LICENSE) file for details.

## Contribution Guide

Please use [this guide](CONTRIBUTING.md) to make a contribution to the project and information to report any issues.
