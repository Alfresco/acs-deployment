# ACS Storage persistence in kubernetes

ACS platform in order to serve users, needs to persist several type of data so
it survives pods restart, cordons of worker nodes or even crashes.
This documents aims at providing guidance in setting up different kinds of
data persistence.

## PostgreSQL

The relational database is key to ACS platform. This type of workload requires
good performances in terms of IO, excellent durability, excellent reliability
(what the system think is committed to disk needs to be) and allow for full
control in order to proceed with regular or exceptional maintenance operations.
For this reasons (and others) we recommend to set up the database workload
outside of the kubernetes cluster. That can be a Managed service like AWS Aurora
or an external RDBMS system of yours where your DBA team has full access and
feel comfortable doing their day to day job.
However if you want to deploy the db in-cluster that is possible for
convenience.

### Default values

If no specific configuration is passed to helm when deploying, the chart will
try to rely on the default `storageClass` configured on the cluster if any.
On a vanilla EKS cluster, that means the postgresql workload will persist data
on an EBS volume using the default `gp2` `storageClass`.

:important:
Before chart versions 5.3.0, the default for postgresql workload was to
leverage the `alfresco-volume-claim` so if you're upgrading from pre-5.3.0
and you used the default config for `postgresql.persistence` you need to take
extra actions to ensure a new database pod won't be recreate wit ha new blank
volume.

If your kubernetes cluster doesn't have a default `storageClass`with a provider
then you can either:

* explicitly set the `storageClass` to use (see [Static Provisioning](#static-provisioning))
* explicitly set the `PersistentVolumeClaim` to use (see [Dynamic Provisioning](#dynamic-provisioning))

### Static Provisioning

Static provisioning consist of manual operation a kubernetes administrator
needs to do prior to release deployment.
The steps are as follow:

1. Create and prepare (format and/or set appropriate permissions) the actual storage volume at the storage level.
2. Create the [PersistentVolume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistent-volumes)
   and its corresponding [PersistentVolumeClaim](https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims)

Once done, you need to give the chart the name of the `PersistentVolumeClaim`as shown bellow:

```yaml
postgresql:
  persistence:
    existingClaim: acsDbClaim
```

### Dynamic Provisioning

With Dynamic provisioning you don't have to prepare individual volumes for each
deployment. Instead a kubernetes storage provisioner will take care of sending
volume creation requests to the storage backend. Most provisioner however will
create "blank" volume or at least deal with a restricted number of
"initialization" tasks. So dynamic provisioning is mostly useful for initial
deployment.

### Migrating from pre-5.3.0 chart versions

First thing you need to check is the `Retention Policy` of your existing volume
where database data are persisted.  You can do that by running the command
bellow:

```sh
kubectl get pv -o jsonpath='{@.items[?(.spec.claimRef.name=="alfresco-volume-claim")].spec.persistentVolumeReclaimPolicy}'
```

This should be set to `Retain` before you start so we're sure we would not
delete any data by mistake.

If you've been using the default persistence configuration for postgresql in
older versions you cannot simply re-use the values from previous deployment
with 5.3.0. Instead you will need to either:

1. force the claim to point to the old `alfresco-volume-claim` (not recommended)
   
   ```yaml
   postgresql:
     persistence:
       existingClaim: acsDbClaim
   ```

2. create a new volume and copy data to it from the old volume bound to the old
   `alfresco-volume-claim`.
   Details of this process depends on the type of storage and provisioner that
   was used during deployment.

If you choose the second - and preferred - method, you'll then need to use
[static provisioning method](#static-provisioning) to create a new volume and
then instruct helm to search for a specific volume by claim name or
`storageClass`.
Using `storageClass` requires creating a new PVC too, which should reference the
PV name to make sure a new volume is not dynamically created. Also applying 
`labels` to the PV and corresponding `selector` to the PVC helps ensure the 
`storageClass`will only pickup the right volume that's been prepared.
