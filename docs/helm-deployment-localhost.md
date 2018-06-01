# Alfresco Content Services Deployment with Helm on a local host


## Prerequisites

The Alfresco Content Services (ACS) deployment with Kubernetes requires:

  - Kubernetes 1.4+ with Beta APIs enabled
  - Minimum of 16 GB Memory to distribute among the ACS cluster nodes


## Adding Alfresco Helm repository

Add `http://kubernetes-charts.alfresco.com/incubator` to your helm repository.
```console
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
```

## Installing the ACS cluster

```console
$ helm install alfresco-incubator/alfresco-content-services
```

This chart bootstraps an ACS deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Installing the chart

Install the chart with the release name `my-acs`:

```console
# Alfresco Admin password should be encoded in MD5 Hash
export ALF_ADMIN_PWD=$(printf %s 'MyAdminPwd' | iconv -t UTF-16LE | openssl md4 | awk '{ print $1}')

# Alfresco Database (Postgresql) password
export ALF_DB_PWD='MyDbPwd'

$ helm install --name my-acs alfresco-incubator/alfresco-content-services \
               --set repository.adminPassword="$ALF_ADMIN_PWD" \
               --set postgresql.postgresPassword="$ALF_DB_PWD"
```

This deploys the ACS cluster on the Kubernetes cluster using the default configuration (but with your chosen Alfresco administrator & database passwords). See the [configuration](#configuration) section for a list of the parameters you can configure during installation.

> **Tip**: List all releases using `helm list`


## Uninstalling the chart

To uninstall or delete the `my-acs` deployment:

```console
$ helm delete my-acs --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
