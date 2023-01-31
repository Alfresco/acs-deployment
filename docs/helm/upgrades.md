# Upgrading the helm charts

Our helm charts are continuously improved and sometimes arise the need to introduce a breaking change.

To get an overview of the changes in each release, first take a look at the
release notes that are available via [GitHub Releases](https://github.com/Alfresco/acs-deployment/releases).

Here follows a more detailed explaination of any breaking change grouped by version in which they have been released.

## To be released

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
