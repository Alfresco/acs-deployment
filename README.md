# Alfresco Content Services Containerized Deployment

[![release](https://img.shields.io/github/v/release/Alfresco/acs-deployment?display_name=release)](https://github.com/Alfresco/acs-deployment/releases/latest)
![kubernetes tested version](https://img.shields.io/badge/k8s%20version-v1.34-blue)
[![Helm release](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-release.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-release.yml)

[![helm charts (enterprise)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-enterprise.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-enterprise.yml)
[![helm charts (community)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-community.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/helm-community.yml)

[![Docker Compose (enterprise)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-enterprise.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-enterprise.yml)
[![Docker Compose (community)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-community.yml/badge.svg)](https://github.com/Alfresco/acs-deployment/actions/workflows/docker-compose-community.yml)

This project contains the code for running Alfresco Content Services (ACS) with
[Docker](https://docs.docker.com/get-started) using [Docker
Compose](https://docs.docker.com/compose) or on
[Kubernetes](https://kubernetes.io) using [Helm Charts](https://helm.sh).

User docs available at: [https://alfresco.github.io/acs-deployment/](https://alfresco.github.io/acs-deployment/)

## ⚠️ Important changes

Breaking changes and other notable announcements are now tracked by version in
the docs site:

* [Helm charts upgrades](https://alfresco.github.io/acs-deployment/helm/upgrades.html)
* [Docker Compose upgrades](https://alfresco.github.io/acs-deployment/docker-compose/upgrades.html)

## License

The code in this repository is released under the Apache License, see the [LICENSE](./LICENSE) file for details.

## Contribution Guide

Please use [this guide](CONTRIBUTING.md) to make a contribution to the project and information to report any issues.

## Release

### Helm charts release

> **Preferred method:** use the [Release Orchestrator][2] workflow. It automates the steps below (bump versions, version bump, helm-docs refresh, draft PR) in a single run. Trigger it with a release codename and optionally a Jira ticket ID. The manual steps below remain valid for cases where more control is needed.

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
  Chart.yaml at the time of tagging).

Start the release by opening a PR against the appropriate branch that will:

* Update the [EOL table](docs/index.md#acs-end-of-lifed-versions) in case a version is deprecated
* In [alfresco-content-services](helm/alfresco-content-services/Chart.yaml) and
  [acs-sso-example](helm/acs-sso-example/Chart.yaml) charts:bump chart version
  to the version you want to release.
* Run `pre-commit run --all-files helm-docs` to update helm docs
* Edit [upgrades docs](docs/helm/upgrades.md) renaming the `To be released`
  section to the current version and create a new `To be released` section for
  the future.
* Run [Bump versions][1] workflow against the same newly created branch, the
  first time with `charts` option. Inspect the changes pushed on the branch,
  revert unwanted changes if necessary - all charts dependencies should not be
  using any `-alpha.` version.
* Run [Bump versions][1] workflow against the same branch with option `values`.
  This will update both docker compose tags and helm charts values.
  Inspect the changes pushed on the branch, looking for any missing update.

[1]: https://github.com/Alfresco/acs-deployment/actions/workflows/bumpVersions.yml
[2]: https://github.com/Alfresco/acs-deployment/actions/workflows/release-orchestrator.yml

The generated Pull request needs to be approved for the tests to run. Avoid
using auto-merge to make sure all tests pass (not all of them are mandatory
checks).
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

### Download trials (compose files)

* Ensure the master branch has the latest versions of the Alfresco components
  set in the [compose files](docker-compose/) (specifically `compose.yaml` and
  `community-compose.yaml).
* Run the [Release Download
  trials](https://github.com/Alfresco/acs-deployment/actions/workflows/download-trials-release.yml)
  workflow.
* Review the [automatically created
  PR](https://github.com/Alfresco/acs-deployment/pulls) and merge it to
  `download-trial` branch if everything looks good.
