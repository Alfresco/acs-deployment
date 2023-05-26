# Alfresco Content Services Containerized Deployment

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

| Chart Version/Tag | Default   | 7.3.N   | 7.2.N   | 7.1.N   | 7.0.N    | Community |
|-------------------|-----------|---------|---------|---------|----------|-----------|
| 5.0.0-M1          | 7.0.0-M2  |         |         |         |          | 6.2.1-A8  |
| 5.0.0-M2          | 7.0.0-M3  |         |         |         |          | 7.0.0     |
| 5.0.0             | 7.0.0     |         |         |         |          | 7.0.0     |
| 5.0.1             | 7.0.0     |         |         |         |          | 7.0.0     |
| 5.1.0-M1          | 7.1.0-M1  |         |         |         |          | 7.1.0-M1  |
| 5.1.0-M2          | 7.1.0-M2  |         |         |         | 7.0.1    | 7.1.0-M2  |
| 5.1.0             | 7.1.0.1   |         |         |         | 7.0.1    | 7.1.0     |
| 5.1.1             | 7.1.0.1   |         |         |         | 7.0.1    | 7.1.0     |
| 5.2.0-M1          | 7.2.0-M1  |         |         | 7.1.0.1 | 7.0.1    | 7.2.0-M1  |
| 5.2.0-M2          | 7.2.0-M2  |         |         | 7.1.1   | 7.0.1    | 7.2.0-M2  |
| 5.2.0             | 7.2.0     |         |         | 7.1.1   | 7.0.1    | 7.2.0     |
| 5.3.0-M1          | 23.1.0-M1 |         | 7.2.1   | 7.1.1.5 | 7.0.1.3  | 23.1.0-M1 |
| 5.3.0-M2          | 7.3.0-M1  |         | 7.2.1   | 7.1.1.5 | 7.0.1.3  | 7.3.0-M2  |
| 5.3.0-M3          | 7.3.0-M2  |         | 7.2.1   | 7.1.1.5 | 7.0.1.3  | 7.3.0-M2  |
| 5.3.0             | 7.3.0     |         | 7.2.1   | 7.1.1.5 | 7.0.1.3  | 7.3.0     |
| 5.4.0-M1          | 7.4.0-M1  | 7.3.0.1 | 7.2.1.5 | 7.1.1.7 | 7.0.1.9  | 7.4.0-M1  |
| 5.4.0-M2          | 7.4.0-M2  | 7.3.1   | 7.2.1.7 | 7.1.1.8 | 7.0.1.10 | 7.4.0-M2  |
| 5.4.0-M3          | 7.4.0-M3  | 7.3.1   | 7.2.1.7 | 7.1.1.8 | 7.0.1.10 | 7.4.0-M3  |
| 6.0.0             | 7.4.0     | 7.3.1   | 7.2.1.7 | 7.1.1.8 | 7.0.1.10 | 7.4.0     |

### Why is there no 5.4.0?

During the development of 5.4.0 we've started turning subcharts (search, sync,
activemq, ...) into individual charts hosted on a new repository. That decision
introduces some breaking changes like resource renaming and values structure
modifications. For that reason we chose to bump to a new major version to
capture the fact upgrades can be problematic and one sould prefer deploying new
versuion to a new namespace rather than attempting upgrades.

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

Open a PR that will:

* Update the [versioning table](#versioning)
* If any updates to the updatecli pipelines is required then make the changes
  and raise the PR.
* Once the PR merge switch the `updatecli.d/supported-matrix.yaml` `latest`
  section to "release mode" by changing all `development_pattern` by `ga_hotfixes_pattern`
* Run locally the updatecli pipeline and commit the resulting files (except the
  `updatecli.d/supported-matrix.yaml`) to a new branch.

  ```bash
  export QUAY_USERNAME="<VALUE>"
  export QUAY_PASSWORD="<VALUE>"
  export UPDATECLI_GITHUB_TOKEN="<VALUE>"
  export GIT_AUTHOR_EMAIL='build@alfresco.com'
  export GIT_AUTHOR_USERNAME='alfresco-build'
  export GIT_BRANCH="$(git branch --show-current)"
  updatecli apply --commit=true --push=false -c updatecli.d/uber-manifest.tpl -v updatecli.d/supported-matrix.yaml
  ```

* Restore formatting of files edited by updatecli (See [updatecli
  issue](https://github.com/updatecli/updatecli/issues/1028)
* In [alfresco-content-services](helm/alfresco-content-services/Chart.yaml),
  bump chart version to the next stable release (usually by removing the
  `-SNAPSHOT` suffix and adding `-Mx` suffix if it's a prerelease)
* For every chart using `alfresco-common`
  ([alfresco-content-services](helm/alfresco-content-services/Chart.yaml) and
  every [subchart](/helm/alfresco-content-services/charts/)) which has it as a dependency:
  * Bump version to the new `alfresco-common` stable version
  * Switch `repository` to `https://kubernetes-charts.alfresco.com/stable`
* Bump each subchart version to the next stable release (usually by removing the
  `-SNAPSHOT` suffix)
* Run `pre-commit run --all-files helm-docs` to update docs

Once the PR has been merged, create and push the signed tag with:

```sh
git tag -f -s vx.x.x -m vx.x.x
git push origin vx.x.x
```

where `vx.x.x` is the `alfresco-content-services` version.

Once the tagged workflow is successful, publish the [new release on
GitHub](https://github.com/Alfresco/acs-deployment/releases/new).

Now proceed and open a PR to move back to development version:

* In [alfresco-common](helm/alfresco-common/Chart.yaml), bump chart version to
  the next development release (usually by increasing the minor version and adding
  the `-SNAPSHOT` suffix)
* In [alfresco-content-services](helm/alfresco-content-services/Chart.yaml),
  bump chart version to the next development release (usually by increasing the
  minor version and adding the `-SNAPSHOT` suffix)
* For every chart using `alfresco-common`
  ([alfresco-content-services](helm/alfresco-content-services/Chart.yaml) and
  every [subchart](/helm/alfresco-content-services/charts/)) which has it as a dependency:
  * Bump version to the new `alfresco-common` development version
  * Switch `repository` back to `https://kubernetes-charts.alfresco.com/incubator`
* Bump each subchart version to the next development release (usually by
  increasing the minor version and adding the `-SNAPSHOT` suffix)
* Run `pre-commit run --all-files helm-docs` to update docs

Once the PR has been merged, overwrite and push the signed mutable tag with:

```sh
git tag -d vx.x.x-SNAPSHOT
git tag -f -s vx.x.x-SNAPSHOT -m vx.x.x-SNAPSHOT
git push origin vx.x.x-SNAPSHOT --force
```

Once the tagged workflow is successful, the release process has completed.

## How to update workflow diagrams of Alfresco latest version

* Go to the `docs/docker-compose/diagrams` and/or `docs/helm/diagrams` folders of the repository and there you will find 2 plantuml source files and their PNG diagram files.
* Update the plantuml(.puml) files for enterprise/community edition with latest changes as required.
* Once you are done with the changes, you can generate the diagrams with 2 ways.

1. You can update the diagrams with cli method by running the below command. You need to have Java and Plantuml installed on your machine.
 `java -jar plantuml.jar filename`
2. The other way to generate the diagrams is via official plantuml website. Go to the below url and paste your puml code and click on submit.
 `http://www.plantuml.com/plantuml/uml/SyfFKj2rKt3CoKnELR1Io4ZDoSa70000`
