# Alfresco Content Services Helm Deployment with Rancher Desktop

This page describes how to deploy Alfresco Content Services (ACS) Enterprise or Community using [Helm](https://helm.sh) onto [Rancher Desktop](https://rancherdesktop.io/).

## Prerequisites

- You've read the projects [main README](/README.md#prerequisites) prerequisites section
- You've read the [main Helm README](./README.md) page
- You are proficient in Kubernetes
- A machine with at least 16GB memory
- [Rancher for Desktop](https://rancherdesktop.io/). Rancher Desktop includes kubectl and Helm as pre-installed tools, ready to use right after installation.

### Rancher Desktop specific configuration

Uncheck `Enable Traefik` from the `Kubernetes Settings` page to disable Traefik. You may need to exit and restart Rancher Desktop for the change to take effect. Ref: [Setup NGINX Ingress Controller](https://docs.rancherdesktop.io/how-to-guides/setup-NGINX-Ingress-Controller)

## Deploy

Once Rancher Desktop is running follow the steps in the following sections to deploy ACS (Enterprise or Community) to your local machine.

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
helm install acs-ingress ingress-nginx/ingress-nginx --version=4.4.0 \
--set controller.scope.enabled=true \
--set controller.scope.namespace=alfresco \
--set rbac.create=true \
--atomic \
--namespace alfresco
```

> NOTE: The command will wait until the deployment is ready so please be patient.

```bash
# Verify NGINX is up and running
kubectl get pods --namespace alfresco

NAME                                                   READY   STATUS    RESTARTS   AGE
acs-ingress-ingress-nginx-controller-5647c976f-f7b6q   1/1     Running   0          98m

# Verify expose localhost:80
kubectl get svc --namespace alfresco

NAME                                             TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                      AGE
acs-ingress-ingress-nginx-controller-admission   ClusterIP      10.43.42.230   <none>          443/TCP                      98m
acs-ingress-ingress-nginx-controller             LoadBalancer   10.43.90.117   192.168.29.69   80:31363/TCP,443:30980/TCP   98m
```

### ACS

This repository allows you to either deploy a system using released stable artifact or the latest in-progress development artifacts.

To use a released version of the Helm chart add the stable chart repository using the following command:

```bash
helm repo add alfresco https://kubernetes-charts.alfresco.com/stable
helm repo update
```

#### Community

To install the latest version of Community we need to use the [community_values.yaml file](../../helm/alfresco-content-services). Once downloaded execute the command below to deploy.

```bash
helm install acs alfresco/alfresco-content-services \
  --values=community_values.yaml \
  --set global.tracking.sharedsecret=$(openssl rand -hex 24) \
  --atomic \
  --timeout 10m0s \
  --namespace=alfresco
```

> NOTE: The command will wait until the deployment is ready so please be patient.

#### Enterprise localhost deployment

See the [registry authentication](registry-authentication.md) page to configure
credentials to access the Alfresco Enterprise registry.

The Enterprise Helm deployment is intended for a Cloud based Kubernetes cluster
and therefore requires a large amount of resources out-of-the-box. To reduce the
size of the deployment so it can run on a single machine we'll need to reduce
the number of pods deployed and the memory requirements for several others.

To install the Enterprise on localhost we need to use the local-dev-values.yaml

```bash
curl -fO https://raw.githubusercontent.com/Alfresco/acs-deployment/master/docs/helm/values/local-dev-values.yaml
```

Once downloaded execute the command below to deploy.

```bash
helm install acs alfresco/alfresco-content-services \
  --values local-dev-values.yaml \
  --set global.tracking.sharedsecret=$(openssl rand -hex 24) \
  --atomic \
  --timeout 10m0s \
  --namespace alfresco
```
> NOTE: The command will wait until the deployment is ready so please be patient. See below for [troubleshooting](./rancher-desktop-deployment.md#troubleshooting) tips.

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

If your deployment fails it's most likely to be caused by resource limitations, please refer to the sections below for more information. Please also consult the [Helm Troubleshooting section](./README.md#Troubleshooting) for more generic troubleshooting tips and tricks.


To save the deployment of two more pods you can also try disabling the Sync Service, to do that provide the additional `--set` option below with your helm install command:

```bash
--set alfresco-sync-service.enabled=false
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
