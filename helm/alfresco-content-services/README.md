# Alfresco Content Services (ACS) Helm Chart

Alfresco Content Services is an Enterprise Content Management (ECM) system that is used for document and case management, project collaboration, web content publishing, and compliant records management.  The flexible compute, storage, and database services that Kubernetes offers make it an ideal platform for Alfresco Content Services. This helm chart presents an enterprise-grade Alfresco Content Services configuration that you can adapt to virtually any scenario, and scale up, down, or out, depending on your use case.

To use, add the `incubator` or `stable` repository to your local Helm.
```console
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
helm repo add alfresco-stable http://kubernetes-charts.alfresco.com/stable
```
## Versioning

The versioning of the Helm Chart is based on [SemVer](https://semver.org/) as it is [supported by Helm](https://docs.helm.sh/developing_charts/#charts-and-versioning). There are a few ACS specific extensions to the rules. Please refer to [Helm versioning guide](../../docs/helm-versioning.md).

Stable charts are published in [stable repository](http://kubernetes-charts.alfresco.com/stable). Once a stable chart is published, an entry will be added to [releases table](../../docs/helm-chart-releases.md).

## To install the ACS cluster

```console
$ helm install alfresco-incubator/alfresco-content-services
```

## Introduction

This chart bootstraps an ACS deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
  - [30-day trial license](https://www.alfresco.com/platform/content-services-ecm/trial/download) for Enterprise
  - Kubernetes 1.4+ with Beta APIs enabled
  - Minimum of 16GB Memory to distribute among ACS Cluster nodes

## Structure

![Helm Deployment Components](../../docs/diagrams/helm-chart/helm-components.png)

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

## Configuration

The following table lists the configurable parameters of the ACS chart and their default values.

Parameter | Description | Default
--- | --- | ---
`repository.adminPassword` | Administrator password for ACS in md5 hash format | md5: `209c6174da490caeb422f3fa5a7ae634` (of string `admin`)
`postgresql.enabled` | Enable the use of the postgres chart in the deployment | `true`
`postgresql.postgresUser` | Postgresql database user | `alfresco`
`postgresql.postgresPassword` | Postgresql database password | `alfresco`
`postgresql.postgresDatabase` | Postgresql database name | `alfresco`
`database.external` | Enable the use of an externally provisioned database | `false`
`database.driver` | External database driver | ``
`database.user` | External database user | ``
`database.password` | External database password | ``
`database.url` | External database jdbc url | ``
`alfresco-search.resources.requests.memory` | Alfresco Search Services requests memory | `250Mi`
`alfresco-search.ingress.enabled` | Enable external access for Alfresco Search Services | `false`
`alfresco-search.ingress.basicAuth` | If `alfresco-search.ingress.enabled` is `true`, user needs to provide a `base64` encoded `htpasswd` format user name & password (ex: `echo -n "$(htpasswd -nbm solradmin somepassword)"` where `solradmin` is username and `somepassword` is the password) | None
`alfresco-search.ingress.whitelist_ips` | If `alfresco-search.ingress.enabled` is `true`, user can restrict `/solr` to a list of IP addresses of CIDR notation | `0.0.0.0/0`
`persistence.repository.enabled` | Enable Volume Persistence on repository. | `true`
`s3connector.enabled` | Switch this to `true` if you have access to the S3 Connector AMP | `false`
`s3connector.config` | S3 configuration - see [S3 Connector properties reference](https://docs.alfresco.com/s3connector/references/s3-contentstore-ref-config-props.html). Example: `s3connector.config.bucketName: myS3Bucket` | `{}`
`s3connector.secrets` | S3 secrets configuration - see [S3 Connector properties reference](https://docs.alfresco.com/s3connector/references/s3-contentstore-ref-config-props.html). Example: `s3connector.secrets.accessKey: AJJJJJJJJ` | `{}`










