# Alfresco Content Services Helm Deployment with Docker For Desktop

This page describes how to deploy Alfresco Content Services (ACS) Enterprise or Community using [Helm](https://helm.sh) onto [Docker for Desktop](https://docs.docker.com/desktop/).

## Prerequisites

* You've read the projects [main README](/README.md#prerequisites) prerequisites section
* You've read the [main Helm README](./README.md) page
* You are proficient in Kubernetes
* A machine with at least 12GB memory
* Latest version of [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl) is installed
* Latest version of [Helm](https://helm.sh/docs/intro/install) is installed
* [Docker for Desktop](https://docs.docker.com/desktop/) is installed

## Configure Docker for Desktop

In order to deploy onto Docker for Desktop we need to configure it with as much CPU and memory as possible on the "Resources" tab in Docker for Desktop's preferences pane as shown in the screenshot below.

![Resources](./diagrams/dfd-resources.png)

To deploy the Helm charts Kubernetes needs to be enabled, this can be done from the "Kubernetes" tab, as shown in the screenshot below. Press the "Apply & Restart" button to confirm.

![k8s Enabled](./diagrams/dfd-k8s-enabled.png)

## Deploy

Once Docker for Desktop is running follow the steps in the following sections to deploy ACS (Enterprise or Community) to your local machine.

### Namespace

Namespaces in Kubernetes isolate workloads from each other, create a namespace to host ACS inside the cluster using the following command (we'll then use the `alfresco` namepsace throughout the rest of the tutorial):

```bash
kubectl create namespace alfresco
```

### Ingress

Add the chart repository using the following command:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

Deploy an ingress controller into the alfresco namespace using the command below:

```bash
helm install acs-ingress ingress-nginx/ingress-nginx --version=3.7.1 \
--set controller.scope.enabled=true \
--set controller.scope.namespace=alfresco \
--set rbac.create=true \
--atomic \
--namespace alfresco
```

> NOTE: The command will wait until the deployment is ready so please be patient.

### ACS

This repository allows you to either deploy a system using released stable artefacts or the latest in-progress development artefacts.

To use a released version of the Helm chart add the stable chart repository using the following command:

```bash
helm repo add alfresco https://kubernetes-charts.alfresco.com/stable
helm repo update
```

Alternatively, to use the latest in-progress development version of the Helm chart add the incubator chart repository using the following command:

```bash
helm repo add alfresco https://kubernetes-charts.alfresco.com/incubator
helm repo update
```

Now decide whether you want to install the Community or Enterprise edition and follow the steps in the relevant section below.

#### Community

To install the latest version of Community we need to use the [community_values.yaml file](../../helm/alfresco-content-services). Once downloaded execute the command below to deploy.

```bash
helm install acs alfresco/alfresco-content-services \
--values=community_values.yaml \
--set externalPort="80" \
--set externalProtocol="http" \
--set externalHost="localhost" \
--atomic \
--timeout 10m0s \
--namespace=alfresco
```

> NOTE: The command will wait until the deployment is ready so please be patient.

#### Enterprise

Firstly, create a docker registry secret to allow the protected images to be pulled from Quay.io by running the following commmand (replacing `YOUR-USERNAME` and `YOUR-PASSWORD` with your credentials):

```bash
kubectl create secret docker-registry quay-registry-secret --docker-server=quay.io --docker-username=YOUR-USERNAME --docker-password=YOUR-PASSWORD -n alfresco
```

Alternatively, if you require credentials for more than one docker registry you can login and then create a generic secret using the `--from-file` option, as shown below.

```bash
docker login docker.io
docker login quay.io
kubectl create secret generic my-registry-secrets --from-file=.dockerconfigjson=/your-home/.docker/config.json --type=kubernetes.io/dockerconfigjson -n alfresco
```

> If you use this approach remember to replace `quay-registry-secret` with `my-registry-secrets` in the helm install command below!

The Enterprise Helm deployment is intended for a Cloud based Kubernetes cluster and therefore requires a large amount of resources out-of-the-box. To reduce the size of the deployment so it can run on a single machine we'll need to reduce the number of pods deployed and the memory requirements for serveral others.

Fortunately this can all be achieved with one, albeit large, command as shown below:

```bash
helm install acs alfresco/alfresco-content-services \
--set externalPort="80" \
--set externalProtocol="http" \
--set externalHost="localhost" \
--set global.alfrescoRegistryPullSecrets=quay-registry-secret \
--set repository.replicaCount=1 \
--set transformrouter.replicaCount=1 \
--set pdfrenderer.replicaCount=1 \
--set imagemagick.replicaCount=1 \
--set libreoffice.replicaCount=1 \
--set tika.replicaCount=1 \
--set transformmisc.replicaCount=1 \
--set postgresql-syncservice.resources.requests.memory="500Mi" \
--set postgresql-syncservice.resources.limits.memory="500Mi" \
--set postgresql.resources.requests.memory="500Mi" \
--set postgresql.resources.limits.memory="500Mi" \
--set alfresco-search.resources.requests.memory="1000Mi" \
--set alfresco-search.resources.limits.memory="1000Mi" \
--set share.resources.limits.memory="1500Mi" \
--set share.resources.requests.memory="1500Mi" \
--set repository.resources.limits.memory="2500Mi" \
--set repository.resources.requests.memory="2500Mi" \
--atomic \
--timeout 10m0s \
--namespace alfresco
```

> NOTE: The command will wait until the deployment is ready so please be patient. See below for [troubleshooting](./docker-desktop-deployment.md#troubleshooting) tips.

The command above installs the latest version of ACS Enterprise. To deploy a previous version of ACS Enterprise follow the steps below.

1. Download the version specific values file you require from [this folder](../../helm/alfresco-content-services)
2. Deploy the specific version of ACS by running the following command:

    ```bash
    helm install acs alfresco/alfresco-content-services \
    --values=MAJOR.MINOR.N_values.yaml \
    --set externalPort="80" \
    --set externalProtocol="http" \
    --set externalHost="localhost" \
    --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
    --set repository.replicaCount=1 \
    --set transformrouter.replicaCount=1 \
    --set pdfrenderer.replicaCount=1 \
    --set imagemagick.replicaCount=1 \
    --set libreoffice.replicaCount=1 \
    --set tika.replicaCount=1 \
    --set transformmisc.replicaCount=1 \
    --set postgresql-syncservice.resources.requests.memory="500Mi" \
    --set postgresql-syncservice.resources.limits.memory="500Mi" \
    --set postgresql.resources.requests.memory="500Mi" \
    --set postgresql.resources.limits.memory="500Mi" \
    --set alfresco-search.resources.requests.memory="1000Mi" \
    --set alfresco-search.resources.limits.memory="1000Mi" \
    --set share.resources.limits.memory="1500Mi" \
    --set share.resources.requests.memory="1500Mi" \
    --set repository.resources.limits.memory="2500Mi" \
    --set repository.resources.requests.memory="2500Mi" \
    --atomic \
    --timeout 10m0s \
    --namespace alfresco
    ```

> NOTE: The command will wait until the deployment is ready so please be patient. See below for [troubleshooting](./docker-desktop-deployment.md#troubleshooting) tips.

## Access

When the deployment has completed the following URLs will be available:

* Repository: `http://localhost/alfresco`
* Share: `http://localhost/share`
* API Explorer: `http://localhost/api-explorer`

If you deployed Enterprise you'll also have access to:

* ADW: `http://localhost/workspace/`
* Sync Service: `http://localhost/syncservice/healthcheck`

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

If your deployment fails it's most likely to be caused by resource limitations, please refer to the sections below for more information. Please also consult the [Helm Troubleshooting section](./README.md#Troubleshooting) for more generic troubleshooting tips and tricks.

### Lack Of Resources

The most common reason for deployment failures with Docker for Desktop is lack of memory or disk space. Check the "Resources" tab in Docker for Desktop's preferences pane, increase the allocation if you can and re-try.

To save the deployment of two more pods you can also try disabling the Sync Service, to do that provide the additional `--set` option below with your helm install command:

```bash
--set alfresco-sync-service.syncservice.enabled=false
```

If you need to reduce the memory footprint further the JVM memory settings in most pods use the `MaxRAMPercentage` option so lowering the various `limits.memory` and `requests.memory` values will also reduce the JVM memory allocation.

### Timeout

If the deployment fails and rolls back with following error:

```bash
Error: release acs failed, and has been uninstalled due to atomic being set: timed out waiting for the condition
```

You may should check resources above and then re-run the deployment with either an increased timeout, eg. --timeout 15m0s. Alteratively run without following:

```bash
--atomic --timeout 10m0s
```

and then monitor the logs for any failing pods. Please also consult the [Helm Troubleshooting section](./README.md#Troubleshooting) for deploying Kubernetes Dashboard and more generic troubleshooting tips and tricks.
