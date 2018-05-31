# Alfresco Content Services Deployment with Helm on a local host

## Add Alfresco helm repository

To use, add the `http://kubernetes-charts.alfresco.com/incubator` to your helm repository.
```console
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
```

## To install the ACS cluster

```console
$ helm install alfresco-incubator/alfresco-content-services
```

## Introduction

This chart bootstraps an ACS deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
  - Kubernetes 1.4+ with Beta APIs enabled
  - Minimum of 16GB Memory to distribute among ACS Cluster nodes

## Installing the Chart

To install the chart with the release name `my-acs`:

```console
# Alfresco Admin password should be encoded in MD5 Hash
export ALF_ADMIN_PWD=$(printf %s 'MyAdminPwd' | iconv -t UTF-16LE | openssl md4 | awk '{ print $1}')

# Alfresco Database (Postgresql) password
export ALF_DB_PWD='MyDbPwd'

$ helm install --name my-acs alfresco-incubator/alfresco-content-services \
               --set repository.adminPassword="$ALF_ADMIN_PWD" \
               --set postgresql.postgresPassword="$ALF_DB_PWD"
```

The command deploys ACS Cluster on the Kubernetes cluster in the default configuration (but with your chosen Alfresco administrator & database passwords). The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-acs` deployment:

```console
$ helm delete my-acs --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.