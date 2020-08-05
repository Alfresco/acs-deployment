
# Alfresco Content Services Deployment

[![Build Status](https://travis-ci.com/Alfresco/acs-deployment.svg?branch=master)](https://travis-ci.com/Alfresco/acs-deployment)

This project contains the code for starting the entire Alfresco Content Services (ACS) product with [Docker](https://docs.docker.com/get-started) using [Docker Compose](https://docs.docker.com/compose) or [Kubernetes](https://kubernetes.io) using [Helm Charts](https://helm.sh).

## Prerequisites

By default the Enterprise version of ACS is installed. To accomplish this private Docker images stored in Quay.io are downloaded. Alfresco customers can request Quay.io credentials by logging a ticket with [Alfresco Support](https://support.alfresco.com/).

The images downloaded directly from Docker Hub, or Quay.io are for a limited trial of the Enterprise version of Alfresco Content Services that goes into read-only mode after 2 days. If you'd like to try Alfresco Content Services for a longer period, request the 30-day [Download Trial](https://www.alfresco.com/platform/content-services-ecm/trial/download).

To avoid license restrictions and private Docker images try the [Community Edition deployment](https://github.com/Alfresco/acs-community-deployment).

## Versioning

The **master** branch of this repository contains the latest work-in-progress deployment scripts and installs the latest development version of ACS.

Branches and tags are used for denoting stable releases, to work with a specific release of ACS, please refer to the table below.

|ACS Version|Tag|Branch
|---|---|---|
|6.0.1.5|1.2.5|support/HF/1.0
|6.1.0.9|2.0.3|support/HF/1.1
|6.1.1.3|2.1.6|support/SP/2.N
|6.2.0.2|3.0.9|support/SP/3.N
|6.2.1|4.0.3|support/SP/4.N
|6.2.2|4.1.0|support/SP/4.N
|7.0.0|5.0.0|master

NOTE: The last rows (5.0.0) has not been released yet.

Helm charts also have their own [version scheme]((https://docs.helm.sh/developing_charts/#charts-and-versioning)) based on [Semantic Versioning](https://semver.org). The `appVersion` property within the chart describes the version of ACS being deployed. The chart version corresponds to the tag version described in the table above.

There are a few ACS specific extensions to the rules:

* Once a chart has been released, the contents of that version MUST NOT be modified. Any modifications MUST be released as a new version. Stable chart version starts with 1.0.0
* The chart version must be incremented if ACS version is incremented within a Service Pack or Hot Fix.
* The "appVersion" label must always specify the exact ACS release version, like 6.0.0, 6.1.0, 6.1.1.1, 6.1.1.2. If the "appVersion" was incremented between charts, downgrading to a previous chart is not possible.

## Documentation

To get started please refer to the [Docker Compose](./docs/docker-compose) and [Helm Chart](./docs/helm) documentation.

## License

The code in this repository is released under the Apache License, see the [LICENSE](./LICENSE) file for details.

## Contribution Guide
Please use [this guide](CONTRIBUTING.md) to make a contribution to the project and information to report any issues.
