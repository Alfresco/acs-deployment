# Alfresco Content Services Containerized Deployment

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

* Update the [EOL table](docs/index.md#acs-end-of-lifed-versions) in case a version is deprecated
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
