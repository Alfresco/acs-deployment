---
emoji: 📦
description: Prepare an ACS Helm charts release PR — bump Chart.yaml versions, refresh helm-docs, and update the upgrades guide.
on:
  workflow_dispatch:
    inputs:
      release-name:
        description: 'Release codename (e.g. "nitrogen")'
        type: string
        required: true
      jira-id:
        description: 'Jira ticket ID to prefix PR titles (e.g. "OPSEXP-1234")'
        type: string
        required: false
  stop-after: +24h
permissions:
  contents: read
  issues: read
  pull-requests: read
checkout:
  fetch-depth: 0
  fetch:
    - "updatecli-bump-acs"
    - "updatecli-bump-helm"
tools:
  github:
    mode: gh-proxy
    toolsets: [default]
network:
  allowed:
    - defaults
    - github
    - alfresco.github.io
steps:
  - name: Install helm-docs
    uses: Alfresco/alfresco-build-tools/.github/actions/setup-helm-docs@v18.1.0
safe-outputs:
  create-pull-request:
    branch-prefix: "release-prep/"
    labels: [release, automation]
    draft: true
    allowed-base-branches:
      - "master"
    patch-format: "bundle"
    allowed-files:
      - "helm/**"
      - "docker-compose/**"
      - "docs/helm/upgrades.md"
---

# Release Orchestrator

## Context

You are preparing the release PR described in the [Helm charts release](../../README.md#helm-charts-release) section of the repository README. The release codename is `${{ inputs.release-name }}`. The PR targets the branch this workflow was dispatched from.

You do NOT run the `Bump versions` workflow, you do NOT tag the release, and you do NOT touch the `supported-matrix` or `alfresco-helm-charts` repos. A maintainer handles those steps before triggering your execution.

## Determine the next version

Read the current `version:` from `helm/alfresco-content-services/Chart.yaml`. Compute the next release version by bumping the **minor** component and resetting patch to `0` (e.g. `10.5.0` → `10.6.0`). Use this value (referenced below as `<next-version>`) for both charts.

If the current version contains a pre-release suffix (`-alpha.`, `-M.`, etc.), call `noop` and explain — a maintainer must clean up dependencies first.

## Task

Perform exactly these four steps and open one pull request:

1. **Merge the updatecli bump branches** into the working tree, in order:

   ```bash
   git fetch origin updatecli-bump-acs updatecli-bump-helm
   git merge --no-ff --no-edit origin/updatecli-bump-acs
   git merge --no-ff --no-edit origin/updatecli-bump-helm
   ```

   If either branch does not exist on `origin`, or if either merge produces conflicts, call `noop` with a one-line explanation — a maintainer must resolve manually. Do not attempt to resolve conflicts yourself.

2. **Bump chart versions** to `<next-version>` in:
   - `helm/alfresco-content-services/Chart.yaml` — update `version:` only (leave `appVersion:` untouched).
   - `helm/acs-sso-example/Chart.yaml` — update `version:` only (leave `appVersion:` untouched).

3. **Refresh helm docs** by running:

   ```bash
   helm-docs
   ```

   The `helm-docs` binary is pre-installed by the `setup-helm-docs` step. It scans for `Chart.yaml` files and regenerates the matching `README.md`. Only `helm/**/README.md` files should be modified; if any other path was rewritten, call `noop` and explain.

4. **Update `docs/helm/upgrades.md`**:
   - If a `## To be released` section exists, rename it to `## <next-version>` and insert a new empty `## To be released` section immediately above it.
   - If no `## To be released` section exists, insert a new `## <next-version>` section directly under the introductory paragraphs (above the highest existing version heading) with a single placeholder bullet: `* No breaking changes.` and also insert a new empty `## To be released` section above it.
   - Preserve all existing section content verbatim.

## Output

Open a single draft pull request via the configured `create-pull-request` safe output.

- **Title**: build it as `<jira-prefix>release: prepare <next-version> (${{ inputs.release-name }})`, where `<jira-prefix>` is `"${{ inputs.jira-id }} "` (with a trailing space) when `jira-id` is non-empty, and an empty string otherwise. Example with both inputs: `OPSEXP-1234 release: prepare 10.6.0 (nitrogen)`.
- **Body**: a checklist that mirrors the README's release steps, with the four items above marked done (note that the updatecli merges replace the manual `Bump versions` runs) and the remaining maintainer steps (tag and create the GitHub release; review release notes; publish) left unchecked.
- **Commit message**: same as the title.

If any step above produces no diff (e.g. helm-docs has nothing to update and the chart versions already match `<next-version>`), call `noop` with a one-line explanation instead of opening an empty PR.

## Constraints

- Do not edit any file outside `allowed-files`.
- Do not bump `appVersion` in either Chart.yaml — the merged updatecli branches handle component version updates.
- Do not hand-edit `values.yaml` or docker-compose files — any changes there must come from the merged updatecli branches.
- Do not invoke `gh workflow run bumpVersions.yml`.
- Do not push to or modify the `updatecli-bump-acs` / `updatecli-bump-helm` branches.
