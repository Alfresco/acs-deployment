# Alfresco Content Services Containerized Deployment

[![release](https://img.shields.io/github/v/release/Alfresco/acs-deployment?display_name=release)](https://github.com/Alfresco/acs-deployment/releases/latest)
[![helm charts (enterprise)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-enterprise.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-enterprise.yml)
[![helm charts (community)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-community.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-community.yml)
[![docker-compose (enterprise)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-enterprise.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-enterprise.yml)
[![docker-compose (community)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-community.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-community.yml)

This project contains the code for starting the entire Alfresco Content
Services (ACS) product with [Docker](https://docs.docker.com/get-started) using
[Docker Compose](https://docs.docker.com/compose) or
[Kubernetes](https://kubernetes.io) using [Helm Charts](https://helm.sh).

Our tests are executed using Helm, kubectl versions provided by github action
runners [Ubuntu-22.04](https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2204-Readme.md#ubuntu-2204)
and against EKS clusters running Kubernetes 1.21 & 1.22.

## Prerequisites

By default the Enterprise version of ACS is installed. To accomplish this
private Docker images stored in Quay.io are downloaded. Alfresco customers can
request Quay.io credentials by logging a ticket with
[Alfresco Support](https://support.alfresco.com/).

The images downloaded directly from Docker Hub, or Quay.io are for a limited
trial of the Enterprise version of Alfresco Content Services that goes into
read-only mode after 2 days. If you'd like to try Alfresco Content Services for
a longer period, request the 30-day
[Download Trial](https://www.alfresco.com/platform/content-services-ecm/trial/download).

To avoid license restrictions and private Docker images follow the instructions
to deploy the Community Edition.

## Versioning

**NOTE:** **The versioning strategy used in this project has changed, if you
have previously used this project please read this section carefully!**

The master branch of this repository now contains the artifacts required to
deploy both the the latest work-in-progress development version and previous
stable versions of ACS.

The default behaviour is to use the latest work-in-progress development version
however, individual files are now provided to deploy the latest hot fix version
of each major.minor version of ACS. The `support/*` branches will remain in
place but will no longer be maintained.

A new version numbering scheme is also being introduced. During the development
phase one or more milestone releases will be produced indicated by an `M`
suffix, for example "5.0.0-M1". Once feature complete one or more RC releases
will be produced followed by the final GA release. Upon release the repository
will be tagged with the release number.

The table below shows the exact version of ACS deployed with each chart version/tag.

| Chart Version/Tag      | Default    | 7.4.N   | 7.3.N   | 7.2.N    | 7.1.N   | 7.0.N    | Community |
|------------------------|------------|---------|---------|----------|---------|----------|-----------|
| 5.0.0-M1               | 7.0.0-M2   |         |         |          |         |          | 6.2.1-A8  |
| 5.0.0-M2               | 7.0.0-M3   |         |         |          |         |          | 7.0.0     |
| 5.0.0                  | 7.0.0      |         |         |          |         |          | 7.0.0     |
| [5.0.1][5.0.1]         | 7.0.0      |         |         |          |         |          | 7.0.0     |
| 5.1.0-M1               | 7.1.0-M1   |         |         |          |         |          | 7.1.0-M1  |
| 5.1.0-M2               | 7.1.0-M2   |         |         |          |         | 7.0.1    | 7.1.0-M2  |
| 5.1.0                  | 7.1.0.1    |         |         |          |         | 7.0.1    | 7.1.0     |
| [5.1.1][5.1.1]         | 7.1.0.1    |         |         |          |         | 7.0.1    | 7.1.0     |
| 5.2.0-M1               | 7.2.0-M1   |         |         |          | 7.1.0.1 | 7.0.1    | 7.2.0-M1  |
| 5.2.0-M2               | 7.2.0-M2   |         |         |          | 7.1.1   | 7.0.1    | 7.2.0-M2  |
| [5.2.0][5.2.0]         | 7.2.0      |         |         |          | 7.1.1   | 7.0.1    | 7.2.0     |
| 5.3.0-M1               | 23.1.0-M1  |         |         | 7.2.1    | 7.1.1.5 | 7.0.1.3  | 23.1.0-M1 |
| 5.3.0-M2               | 7.3.0-M1   |         |         | 7.2.1    | 7.1.1.5 | 7.0.1.3  | 7.3.0-M2  |
| 5.3.0-M3               | 7.3.0-M2   |         |         | 7.2.1    | 7.1.1.5 | 7.0.1.3  | 7.3.0-M2  |
| [5.3.0][5.3.0]         | 7.3.0      |         |         | 7.2.1    | 7.1.1.5 | 7.0.1.3  | 7.3.0     |
| 5.4.0-M1               | 7.4.0-M1   |         | 7.3.0.1 | 7.2.1.5  | 7.1.1.7 | 7.0.1.9  | 7.4.0-M1  |
| 5.4.0-M2               | 7.4.0-M2   |         | 7.3.1   | 7.2.1.7  | 7.1.1.8 | 7.0.1.10 | 7.4.0-M2  |
| 5.4.0-M3               | 7.4.0-M3   |         | 7.3.1   | 7.2.1.7  | 7.1.1.8 | 7.0.1.10 | 7.4.0-M3  |
| [6.0.0][6.0.0]         | 7.4.0.1    |         | 7.3.1   | 7.2.1.11 | 7.1.1.8 | 7.0.1.10 | 7.4.0.1   |
| [6.0.1][6.0.1]         | 7.4.0.1    |         | 7.3.1   | 7.2.1.11 | 7.1.1.8 | 7.0.1.10 | 7.4.0.1   |
| [6.0.2][6.0.2]         | 7.4.0.1    |         | 7.3.1   | 7.2.1.11 | 7.1.1.8 | 7.0.1.10 | 7.4.0.1   |
| [6.1.0-M.1][6.1.0-M.1] | 23.1.0-A19 | 7.4.0.1 | 7.3.1   | 7.2.1.11 | 7.1.1.8 | 7.0.1.10 | 7.4.0.1   |
| [7.0.0-M.1][7.0.0-M.1] | 23.1.0-A27 | 7.4.1   | 7.3.1   | 7.2.1.12 | 7.1.1.8 | 7.0.1.10 | 7.4.1     |
| [7.0.0-M.2][7.0.0-M.2] | 23.1.0-M4  | 7.4.1.1 | 7.3.1   | 7.2.1.12 | 7.1.1.8 | 7.0.1.10 | 7.4.1.1   |

[5.0.1]: https://github.com/Alfresco/acs-deployment/releases/tag/v5.0.1
[5.1.1]: https://github.com/Alfresco/acs-deployment/releases/tag/v5.1.1
[5.2.0]: https://github.com/Alfresco/acs-deployment/releases/tag/v5.2.0
[5.3.0]: https://github.com/Alfresco/acs-deployment/releases/tag/v5.3.0
[6.0.0]: https://github.com/Alfresco/acs-deployment/releases/tag/v6.0.0
[6.0.1]: https://github.com/Alfresco/acs-deployment/releases/tag/v6.0.1
[6.0.2]: https://github.com/Alfresco/acs-deployment/releases/tag/v6.0.2
[6.1.0-M.1]: https://github.com/Alfresco/acs-deployment/releases/tag/v6.1.0-M.1
[7.0.0-M.1]: https://github.com/Alfresco/acs-deployment/releases/tag/v7.0.0-M.1
[7.0.0-M.2]: https://github.com/Alfresco/acs-deployment/releases/tag/v7.0.0-M.2

### Why there is no 5.4.0?

During the development of 5.4.0 we've started turning subcharts (search, sync,
activemq, ...) into individual charts hosted on a new repository. That decision
introduces some breaking changes like resource renaming and values structure
modifications. For that reason we chose to bump to a new major version to
capture the fact upgrades can be problematic and one should prefer deploying new
version to a new namespace rather than attempting upgrades.

> Deploying to new namespace is always the preferred way of upgrading ACS as we
> do not test charts for upgrade scenarios (even with previous versions)
> neither do we provide roll-back facilities.

### End of Life'd versions

While our latest version of the charts should be able to deployment any version
of ACS (theoretically), we only ever test deployment of _currently_ supported
versions. Also we do not provide values files for older unsupported version. If
you need to deploy old version we provide a reference table below to allow you
find the older values files and charts. You can either try using the values
file for a version with the latest charts or using the old charts.

| unsupported ACS version | Last chart version providing it |
|-------------------------|---------------------------------|
| 6.2                     | 5.3.0                           |
| 6.1                     | 5.1.1                           |

> These charts are mentioned for reference but are not supported.

## Getting Started

To get started please refer to the [Docker Compose](./docs/docker-compose) and [Helm Chart](./docs/helm) documentation.

## License

The code in this repository is released under the Apache License, see the [LICENSE](./LICENSE) file for details.

## Contribution Guide

Please use [this guide](CONTRIBUTING.md) to make a contribution to the project and information to report any issues.

## Release

### Helm charts release

New releases are usually made from the default branch. When a bugfix release is
necessary and master branch already received updates that are meant to be
released at a later time, then the release must be made from a branch which
follows the release branch pattern: `release/v$Major.Minor`.

First ensure that:

* the
  [supported-matrix](https://github.com/Alfresco/alfresco-updatecli/blob/master/deployments/values/supported-matrix.yaml)
  reflects the status of the currently released Alfresco products and update if
  necessary before proceeding.
* the [components charts](https://github.com/Alfresco/alfresco-helm-charts) used
  in [alfresco-content-services](helm/alfresco-content-services/Chart.yaml) have
  been released in stable version (no pre-release version should be present in
  Chart.yaml), with up-to-date components versions by running the [Bump versions
  workflow](https://github.com/Alfresco/alfresco-helm-charts/actions/workflows/updatecli.yaml)
* the [Bump versions](https://github.com/Alfresco/acs-deployment/actions/workflows/bumpVersions.yml)
  workflow has been run to reflect the changes of the current `supported-matrix`
  in the helm charts values files and to grab the latest helm charts dependencies.

Start the release by opening a PR against the appropriate branch that will:

* Update the [versioning table](#versioning)
* In [alfresco-content-services](helm/alfresco-content-services/Chart.yaml),
  bump chart version to the version you want to release (use `-M.x` suffix if
  it's a prerelease)
* Run `pre-commit run --all-files helm-docs` to update helm docs
* Edit [upgrades docs](docs/helm/upgrades.md) renaming the `To be released`
  section to the current version and create a new `To be released` section for
  the future.

Once the PR has been merged, create the release with:

```sh
git tag -s vx.x.x -m vx.x.x
git push origin vx.x.x
gh release create vx.x.x --generate-notes -t vx.x.x -d
```

where `vx.x.x` is the same `alfresco-content-services` Chart version.

Once the workflow triggered by this new tag is successful, review the GitHub release notes, usually
removing dependabot entries and other not-really useful changelog entries.

Publish the release (remove draft status).

Once the tagged workflow is successful, the release process is completed.

## How to update workflow diagrams of Alfresco latest version

* Go to the `docs/docker-compose/diagrams` and/or `docs/helm/diagrams` folders of the repository and there you will find 2 plantuml source files and their PNG diagram files.
* Update the plantuml(.puml) files for enterprise/community edition with latest changes as required.
* Once you are done with the changes, you can generate the diagrams with 2 ways.

1. You can update the diagrams with cli method by running the below command. You need to have Java and Plantuml installed on your machine.
 `java -jar plantuml.jar filename`
2. The other way to generate the diagrams is via official plantuml website. Go to the below url and paste your puml code and click on submit.
 `http://www.plantuml.com/plantuml/uml/SyfFKj2rKt3CoKnELR1Io4ZDoSa70000`
