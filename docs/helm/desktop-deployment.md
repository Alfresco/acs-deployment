---
title: Desktop
parent: Deployment
grand_parent: Helm
---

# Alfresco Content Services Helm Deployment on local machines

This page describes how to deploy Alfresco Content Services (ACS) Enterprise or
Community using [Helm](https://helm.sh) onto [Rancher
Desktop](https://rancherdesktop.io/) and  [Docker for
Desktop](https://docs.docker.com/desktop/).

## Prerequisites

- You've read the projects [main README](../index.md#prerequisites)
prerequisites section
- You've read the [main Helm README](./README.md) page
- You are proficient in Kubernetes
- A machine with at least 16GB memory
- Having installed either of:
  - [Rancher for Desktop](https://rancherdesktop.io/). Includes kubectl and Helm, ready to use right after installation.
  - [Docker for Desktop](https://docs.docker.com/desktop/). Requires separate install of kubectl and Helm.

### Rancher Desktop specific configuration

Uncheck `Enable Traefik` from the `Kubernetes Settings` page to disable the
default ingress controller. You may need to exit and restart Rancher Desktop
for the change to take effect. Ref: [Setup NGINX Ingress
Controller](https://docs.rancherdesktop.io/how-to-guides/setup-NGINX-Ingress-Controller)

Then proceed to the [deployment](#deployment) section to install ingress-nginx.

### Docker Desktop specific configuration

On top of the Docker desktop
[Prerequisites](./desktop-deployment.md#prerequisites), it is essential to
install the latest version of
[Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl) &
[Helm](https://helm.sh/docs/intro/install).

After the installation of Docker Desktop, the following configurations should
be adjusted within Docker Desktop settings.

- `Settings > Resources > Advanced > CPUs:8, Memory: 16GB, Swap: 1GB`
- `Settings > kubernetes > Enable Kubernetes`

After changing the necessary settings `Apply and restart` the docker desktop.

## Deployment

Please proceed to execute the instructions detailed in the following sections
for the installation of ACS (Enterprise or Community edition) on your local
system.

### Namespace

To establish an isolated environment for ACS within the Kubernetes cluster,
initiate the creation of a Kubernetes namespace using the provided command.
Throughout the subsequent sections of this tutorial, we will consistently
refer to this namespace as 'alfresco'

```bash
kubectl create namespace alfresco
```

### Ingress

See [ingress-nginx](ingress-nginx.md) section.

### ACS

This repository offers you the option to either deploy a system using stable
released artifacts or the latest in-progress development artifacts.

To use a released version of the Helm chart add the stable chart repository:

```bash
helm repo add alfresco https://kubernetes-charts.alfresco.com/stable
helm repo update
```

#### Community localhost deployment

To install the latest version of Community we need to download the
[community_values.yaml file](https://github.com/Alfresco/acs-deployment/blob/master/helm/alfresco-content-services/community_values.yaml). Once
downloaded, execute the following to initiate the deployment.

```bash
helm install acs alfresco/alfresco-content-services \
  --values=community_values.yaml \
  --set global.search.sharedSecret=$(openssl rand -hex 24) \
  --atomic \
  --timeout 10m0s \
  --namespace=alfresco
```

> NOTE: The command will wait until the deployment is ready so please be patient.

#### Enterprise localhost deployment

ACS enterprise version needs to pull container images from private image
repositories. To configure credentials for accessing the Alfresco Enterprise
registry, please review the information provided in the
[registry-authentication](./registry-authentication.md)

The Enterprise Helm deployment is intended for a Cloud based Kubernetes cluster
and therefore requires a large amount of resources out-of-the-box. To reduce the
size of the deployment so it can run on a single machine we'll need to reduce
the number of pods deployed and the memory requirements for several others.

To install the Enterprise on localhost we need to use the local-dev_values.yaml

```bash
curl -fO https://raw.githubusercontent.com/Alfresco/acs-deployment/master/docs/helm/values/local-dev_values.yaml
```

Once downloaded, execute the following to initiate the deployment.

```bash
helm install acs alfresco/alfresco-content-services \
  --values local-dev_values.yaml \
  --atomic \
  --timeout 10m0s \
  --namespace alfresco
```

> NOTE: The command will wait until the deployment is ready so please be
> patient. See below for [troubleshooting](#troubleshooting) tips.

The `helm` command above installs the most current released version of ACS Enterprise.

#### Enterprise with solr6

Use the above helm command with additional arguments that enable solr6 search engine on enterprise.

```bash
helm install acs alfresco/alfresco-content-services \
  --values local-dev_values.yaml \
  --set alfresco-repository.configuration.search.flavor=solr6 \
  --set global.search.sharedSecret=$(openssl rand -hex 24) \
  --set alfresco-search-enterprise.enabled=false \
  --set alfresco-search.enabled=true \
  --set elasticsearch.enabled=false \
  --set alfresco-audit-storage.enabled=false \
  --atomic \
  --timeout 10m0s \
  --namespace alfresco
```

#### Enterprise deployment for previous versions

Use the above helm commands and pass an additional argument as described in this [section](./README.md#previous-versions).

#### Development versions deployment

To deploy ACS platform with the latest development version follow the steps below.

1. Download the
   [pre-release_values.yaml
   file](https://raw.githubusercontent.com/Alfresco/acs-deployment/master/helm/alfresco-content-services/pre-release_values.yaml)
2. Deploy ACS by executing the following command:

   ```bash
   helm install acs alfresco/alfresco-content-services \
     --values pre-release_values.yaml \
     --values local-dev_values.yaml \
     --atomic \
     --timeout 10m0s \
     --namespace alfresco
   ```

> NOTE: The command will wait until the deployment is ready so please be
patient. See below for
[troubleshooting](#troubleshooting) tips.

## Access

When the deployment has completed the following URLs will be available:

- Repository: `http://localhost/alfresco`
- Share: `http://localhost/share`
- API Explorer: `http://localhost/api-explorer`

If you deployed Enterprise you'll also have access to:

- ADW: `http://localhost/workspace/`
- Sync Service: `http://localhost/syncservice/healthcheck`

## Cleanup

1. Remove the `acs` and `acs-ingress` deployments by running the following command:

   ```bash
   helm uninstall -n alfresco acs acs-ingress
   ```

2. Delete the Kubernetes namespace using the command below:

   ```bash
   kubectl delete namespace alfresco
   ```

## Troubleshooting

In the event of a deployment failure, it is important to recognize that
resource constraints are a common underlying cause. For further insights and
guidance. Additionally, you can find more comprehensive troubleshooting advice
in the [Helm Troubleshooting section](./README.md#troubleshooting)

### Lack Of Resources

One of the most prevalent causes of deployment failures is insufficient memory
or CPU resources. It is imperative to ensure that an adequate amount of
resources is allocated to prevent deployment failures.

To save the deployment of two more pods you can also try disabling the Sync
Service, to do that provide the additional `--set` option below with your helm
install command:

```bash
--set alfresco-sync-service.enabled=false
```

If you need to reduce the memory footprint further the JVM memory settings in
most pods use the `MaxRAMPercentage` option so lowering the various
`limits.memory` and `requests.memory` values will also reduce the JVM memory
allocation.

### Timeout

If the deployment fails and rolls back with following error:

```bash
Error: release acs failed, and has been uninstalled due to atomic being set: timed out waiting for the condition
```

You may should check resources above and then re-run the deployment with either
an increased timeout, eg. --timeout 15m0s. Alteratively run without following:

```bash
--atomic --timeout 10m0s
```

and then monitor the logs for any failing pods. Please also consult the
[Helm Troubleshooting section](./README.md#troubleshooting) for deploying Kubernetes
Dashboard and more generic troubleshooting tips and tricks.
