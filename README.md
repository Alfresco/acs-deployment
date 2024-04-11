# Alfresco Content Services Containerized Deployment

[![release](https://img.shields.io/github/v/release/Alfresco/acs-deployment?display_name=release)](https://github.com/Alfresco/acs-deployment/releases/latest)
[![helm charts (enterprise)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-enterprise.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-enterprise.yml)
[![helm charts (community)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-community.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-community.yml)
[![docker-compose (enterprise)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-enterprise.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-enterprise.yml)
[![docker-compose (community)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-community.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-community.yml)

This project contains the code for running Alfresco Content Services (ACS) with
[Docker](https://docs.docker.com/get-started) using [Docker
Compose](https://docs.docker.com/compose) or on
[Kubernetes](https://kubernetes.io) using [Helm Charts](https://helm.sh).

Automated tests for helm charts are running on KinD cluster v1.25 and EKS v1.27.

## Important changes for helm charts

The v7.0.0 release is the first release of the acs helm charts which completely
leverage the new individual subcharts we started releasing since March 2023 in a
dedicated repo:
[alfresco-helm-charts](https://github.com/Alfresco/alfresco-helm-charts).

This change will make life easier to whoever want to customize or extend the
helm deployments and simplify the future maintenance, at the cost of breaking
the compatibility with the values structure which remained almost stable since
the v6 release.

Please review the new [values](helm/alfresco-content-services/values.yaml)
carefully and adapt any custom configuration you may have. You can read the
[upgrades guide](docs/helm/upgrades.md) for more details on the changes.

> Deploying to new namespace is always the preferred way of upgrading ACS as we
> do not test charts for upgrade scenarios (even with previous versions)
> neither do we provide roll-back facilities.

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
| 6.2                     | 5.3.0                           |
| 6.1                     | 5.1.1                           |

> These charts should not be used for any new deployment but just for reference.

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
* the [components charts](https://github.com/Alfresco/alfresco-helm-charts) have
  been released in stable versions (no pre-release version should be present in
  Chart.yaml).

Start the release by opening a PR against the appropriate branch that will:

* Update the [EOL table](#acs-end-of-lifed-versions) in case a version is deprecated
* In [alfresco-content-services](helm/alfresco-content-services/Chart.yaml),
  bump chart version to the version you want to release
* Run `pre-commit run --all-files helm-docs` to update helm docs
* Edit [upgrades docs](docs/helm/upgrades.md) renaming the `To be released`
  section to the current version and create a new `To be released` section for
  the future.
* Run [Bump versions][1] workflow against the same newly created branch, the
  first time with `charts` option. Inspect the changes pushed on the branch,
  revert unwanted changes if necessary.
* Run [Bump versions][1] workflow against the same branch with option `values`.
  This will update both docker compose tags and helm charts values.
  Inspect the changes pushed on the branch, looking for any missing update.

[1]: https://github.com/Alfresco/acs-deployment/actions/workflows/bumpVersions.yml

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

* Go to the `docs/docker-compose/images` and/or `docs/helm/images` folders of the repository and there you will find 2 plantuml source files and their PNG diagram files.
* Update the plantuml(.puml) files for enterprise/community edition with latest changes as required.
* Once you are done with the changes, you can generate the diagrams with 2 ways.

1. You can update the diagrams with cli method by running the below command. You need to have Java and Plantuml installed on your machine.
 `java -jar plantuml.jar filename`
2. The other way to generate the diagrams is via official plantuml website. Go to the below url and paste your puml code and click on submit.
 `http://www.plantuml.com/plantuml/uml/SyfFKj2rKt3CoKnELR1Io4ZDoSa70000`
