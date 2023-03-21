# Upgrading the helm charts

Our helm charts are continuously improved and sometimes arise the need to introduce a breaking change.

To get an overview of the changes in each release, first take a look at the
release notes that are available via [GitHub Releases](https://github.com/Alfresco/acs-deployment/releases).

Here follows a more detailed explanation of any breaking change grouped by version in which they have been released.

## 5.4.0-M3

### Search Enterprise chart rename

The previous `alfresco-elasticsearch-connector` subchart has been renamed to
`alfresco-search-enterprise` to better reflect the product name during the
migration to the new
[alfresco-helm-charts](https://github.com/Alfresco/alfresco-helm-charts)
repository.

Accordingly to this chart rename, also the related values has been moved from
`.Values.alfresco-elasticsearch-connector` to
`.Values.alfresco-search-enterprise`.

The elasticsearch dependency (from elastic.co) has been moved from the main
chart to the new alfresco-search-enterprise, thus the Values has been moved
from `.Values.elasticsearch` to
`.Values.alfresco-search-enterprise.elasticsearch`

## 5.4.0-M2

### CPU resources

A default CPU resources requests and limits has been introduced to make sure
that Kubernetes scheduler has some more hints on how properly place pods on the
available nodes in a cluster.

That could be a breaking change for helm installations on cluster that has **less than 10 cpu**.

You can fine tune CPU resources for each pod by updating the `resources` section
that is available for each component in their respective **values** file,
according to the standard [kubernetes resources
management](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#resource-units-in-kubernetes).

For example, in the [alfresco-content-services values file](../../helm/alfresco-content-services/values.yaml) you can find:

```yaml
repository:
  replicaCount: 2
  resources:
    requests:
      cpu: "1"
      memory: "1500Mi"
    limits:
      cpu: "4"
      memory: "3000Mi"
```

That means that each `repository` pod will have a reservation of 1 full cpu core
and enables bursting up to 4 cpu cores. You can also reduce the number of
replicas for the components that allows it.

## 5.4.0-M1

### Persistence

Previous versions of the chart did not use that per-component approach to storage.
Instead, the default behavior was to create a PVC and rely by default on it for
any kind of data to persist). That approach has proven to cause problems and
that's why we're moving away from it.
However if you have already deployed using this approach and want to keep it
(which we don't recommend), you can do so by using the static provisioning approach
and set the `existingClaim` to the previously created PVC `alfresco-volume-claim`:

```yaml
postgresql:
  persistence:
    existingClaim: alfresco-volume-claim
```

Another option is to create a new volume and copy data to it from the old
volume bound to the old `alfresco-volume-claim`.
Details of this process depends on the type of storage and provisioner that
was used during deployment.

If you choose the second - and preferred - method, you'll then need to use
[static provisioning method](storage.md#configuring-static-provisioning) to create a new volume and
then instruct helm to search for a specific volume by claim name or
`storageClass`. Using `storageClass` requires creating a new PVC too, which
should reference the PV name to make sure a new volume is not dynamically
created.
Also,  applying `labels` to the PV and corresponding `selector` to the PVC
helps ensure the `storageClass` will only pick the intended volume.

## 5.2.0

### Solr tracking shared secret

As of chart version 5.2.0 (ACS 7.2.0) it is now required to set a shared secret for solr and repo to authenticate to each other.

```yaml
global:
  tracking:
    auth: secret
    sharedsecret: 50m3S3cretTh4t!s5tr0n6
```

If you are deploying ACS version pre 7.2.0 with charts version 5.2.0+, make sure to set the value below to your `values.yml` file:

```yaml
global:
  tracking:
    auth: none
```

If you try to install ACS 7.2.0 and following versions, the configuration below
is **not supported** anymore and you are **required to set a shared secret**.

> :information_source: Due to protocol and ingress restrictions FTP is not exposed via the Helm chart.
