---
title: Storage
parent: Guides
grand_parent: Helm
---

# ACS Storage persistence in kubernetes

ACS platform in order to serve users' requests, needs to persist several type
of data so it survives pods restart, cordons of worker nodes or even crashes.
This documents aims at providing guidance in setting up different kinds of
data persistence.

## Available storage options

There mainly 2 different options when setting up persistence in kubernetes:

* Static provisioning
* Dynamic provisioning

The charts Alfresco provides leverage a common mechanism to configure both options.
This mechanism can be reused by different charts or sub-charts in the same way.

> Note: direct usage of kubernetes volumes (without PVC) is not supported)

The logic used in the template is depicted in the diagram below:

```mermaid
flowchart TD
persistence(.Values.$componentName.persistence) --> enabled{{.enabled?}}
enabled --true--> existingClaim{{.existingClaim?}}
enabled --false--> emptyDir[Render Deployment with\nEphemeral Volume]

existingClaim --true--> renderExistingClaim[Render deployment\nreferencing the existing PVC]
existingClaim --false--> storageClass

storageClass{{.storageClass?}}
providedStorageClass[Render PVC with the\n provided storageClass]
defaultStorageClass[Render PVC with the\n default storageClass]
render[Render Deployment referencing the previously created PVC]

storageClass --true--> providedStorageClass --> render
storageClass --false--> defaultStorageClass --> render
```

Whatever the option you choose, start by enabling persistence under the
component which needs it:

```yaml
component:
  persistence:
    enabled: true
```

### Configuring static provisioning

This method requires the cluster administrator to provision in advance a
[physical volume claim (PVC)](https://kubernetes.io/docs/concepts/storage/volumes/#persistentvolumeclaim).
That PVC needs to fulfil requirements driven by  the cluster architecture. That
usually means:

* offering `ReadWriteMany`
  [accessModes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#access-modes)
  for components which have a `Deployment.replicas` > 1 and more than one
  schedule-able worker node.
* Providing sufficient speed and space for the workload
* Being given a [Reclaim
  Policy](https://kubernetes.io/docs/tasks/administer-cluster/change-pv-reclaim-policy/)
  that DO match environment type (you probably want to avoid using `Delete` in
  your production environment).

Plus all your other site-specific requirements.

To use static provisioning:

```yaml
component:
  persistence:
    enabled: true
    existingClaim: ecmVolume
```

That method can be convenient in production environment where the data pre-exists
the infrastructure. In that case a cluster admin might also want to [pre-bind PV and
PVC](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reserving-a-persistentvolume).

### Configuring dynamic provisioning

This method offers a dynamic provisioning approach so cluster admins do not need to
manually create PV and its corresponding PVC. Instead what they need to have is
a [storageClass](https://kubernetes.io/docs/concepts/storage/storage-classes/) which
has a [provisioner](https://kubernetes.io/docs/concepts/storage/storage-classes/#provisioner).

With that configuration ,if no volume exists when a deployments needs to spin up pods,
Kubernetes will use the `provisioner`to create one on-the-fly:

```yaml
component:
  persistence:
    enabled: true
    storageClass: dc1-nfs-exports
```

## Migrating from previous chart versions

See [upgrade guide](upgrades.md#persistence).
