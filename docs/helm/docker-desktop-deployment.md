# Alfresco Content Services Helm Deployment with Docker For Desktop

This page describes how to deploy Alfresco Content Services (ACS) Enterprise or Community using [Helm](https://helm.sh) onto [Docker for Desktop](https://docs.docker.com/desktop/).

## Prerequisites

* You've read the projects [main README](/README.md#prerequisites) prerequisites section
* You've read the [main Helm README](./README.md) page
* You are proficient in Kubernetes
* Latest version of [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl) is installed
* Latest version of [Helm](https://helm.sh/docs/intro/install) is installed
* Docker for Desktop installed with Kubernetes installed

    ![k8s Enabled](./diagrams/dfd-k8s-enabled.png)

## Prepare The Cluster For ACS

TODO

## Deploy

Now the EKS cluster is setup we can deploy ACS.

### Namespace

Namespaces in Kubernetes isolate workloads from each other, create a namespace to host ACS inside the cluster using the following command (we'll then use the `alfresco` throughout the rest of the tutorial):

```bash
kubectl create namespace alfresco
```

### Ingress

```bash
helm install acs-ingress ingress-nginx/ingress-nginx /
--set controller.scope.enabled=true /
--set controller.scope.namespace=alfresco /
--set rbac.create=true /
--namespace alfresco
```

### Docker Registry Secret

Create a docker registry secret to allow the protected images to be pulled from Quay.io by running the following commmand (replacing `YOUR-USERNAME` and `YOUR-PASSWORD` with your credentials):

```bash
kubectl create secret docker-registry quay-registry-secret --docker-server=quay.io --docker-username=YOUR-USERNAME --docker-password=YOUR-PASSWORD -n alfresco
```

### ACS



#### Enterprise

Deploy the latest version of ACS Enterprise using the following command:



#### Community

