---
title: ACS Deployment
layout: home
nav_order: 1
permalink: /index.html
---
# Alfresco Content Services Containerized Deployment

[![release](https://img.shields.io/github/v/release/Alfresco/acs-deployment?display_name=release)](https://github.com/Alfresco/acs-deployment/releases/latest)
![kubernetes tested version](https://img.shields.io/badge/k8s%20version-v1.31-blue)

This project contains the code for running Alfresco Content Services (ACS) with
[Docker](https://docs.docker.com/get-started) using [Docker
Compose](https://docs.docker.com/compose) or on
[Kubernetes](https://kubernetes.io) using [Helm Charts](https://helm.sh).

> Automated tests for helm charts are running on KinD cluster v1.31 and EKS v1.31.

## Prerequisites

The ACS Enterprise version is installed by default, using Docker images from
Quay.io. If you're an Alfresco customer, you can request Quay.io credentials by
logging a ticket with [Hyland Community](https://community.hyland.com).

The repository Docker image provides a limited trial of the Enterprise version
of Alfresco Content Services, which switches to read-only mode after 2 days. For
a longer trial, you can request the 30-day [Download
Trial](https://www.alfresco.com/platform/content-services-ecm/trial/download).

The Community Edition can be installed without the need of a license or quay.io
account.

## Versioning

As of version 8.0.0 of the chart we have changed the release policy.
Previously, the chart was released together with the ACS product and we were
delivering additional values files for each major release of ACS (e.g. 7.3,
7.4, ...) and chart version were bumped with a similar increment as ACS.
With version 6.0.0, we started applying major versions bumps to reflect
breaking changes in the chart, despite only minor ACS release happened.

With 8.0.0 onward, the release pace of the chart is completely independent from
the product versions. We will also stick to Semver principles when choosing
next version number, meaning that:

* patch version will be used for bug fixes (last digit)
* minor version will be used for new features and modifications which do not
  introduce breaking changes in the configuration interface.
* major version will be used for changes which involve breaking changes in the
  configuration interface.

The `alfresco-content-services` chart has always provided the ability to deploy
any currently supported version of ACS and its components and will continue to
do so. You are encoraged to always use the latest version of the chart to
deploy your ACS version, using the appropriate values file. For that reason we
stop providing the table mapping chart versions with the ACS version they
deploy (by default). Instead we'll just maintain the list of deprecated versions
versions mapped with the latest versions of the charts we tested deployment
with, so you can use that version to deploy older ACS version on Kubernetes.
Check the [ACS End of Life'd versions](#acs-end-of-lifed-versions) paragraph.

You are encouraged to always use the latest version of the chart to deploy your
currently supported ACS version, using the appropriate values file.

Finally, the master branch of this repository used to contain the latest
versions, including non-released versions!
We're also moving away from this pattern and the chart will now only ever
deploy released versions of our products.

Should you want to try our latest dev versions, we now provide an additional
values file called `pre-release_values.yaml` which will be bumped on a regular
basis.

This also means we will not produce `-M*` versions of the chart anymore.

Check the [Release page](https://github.com/Alfresco/acs-deployment/releases) for the list of existing versions.

### ACS End of Life'd versions

While our latest version of the charts should be able to deployment any version
of ACS (theoretically), we only ever test deployment of _currently_ supported
versions. Also we do not provide values files for older unsupported version. If
you need to deploy old version we provide a reference table below to allow you
find the older values files and charts. You can either try using the values
file for a version with the latest charts or using the old charts.

| unsupported ACS version | Last chart version providing it |
|-------------------------|---------------------------------|
| 7.2                     | 9.1.1                           |
| 7.1                     | 8.5.2                           |
| 7.0                     | 8.0.1                           |
| 6.2                     | 5.3.0                           |
| 6.1                     | 5.1.1                           |

> These charts should not be used for any new deployment but just for reference.

## Getting Started

To get started please refer to the [Docker Compose](compose.md) and [Helm Chart](helm.md) documentation.
