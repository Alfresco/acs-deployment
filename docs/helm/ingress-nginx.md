---
title: ingress-nginx install
parent: Guides
grand_parent: Helm
---

# Install ingress-nginx

> Starting from March 2026, the ingress-nginx controller will be officially
> discontinued and users needs to move away.
>
> The present guide is kept for reference but we recommend to move to a more
> modern ingress controller such as [Traefik](https://doc.traefik.io/traefik/).
>
> More information about the deprecation of ingress-nginx can be found in the
> [ingress-nginx deprecation
> notice](https://kubernetes.io/blog/2025/11/11/ingress-nginx-retirement/)

We currently support and test only
[ingress-nginx](https://github.com/kubernetes/ingress-nginx). However, our
charts provide flexibility through values such as `.ingress.className` and
`.ingress.annotations`, allowing you to customize the Ingress configuration. If
you prefer to manage Ingress resources yourself, you can set `.ingress.enabled`
to `false` to disable the bundled Ingress resource and provide your own.

## Install on a generic Kubernetes cluster

Install the ingress-nginx controller namespace:

```bash
helm upgrade --install ingress-nginx ingress-nginx \
--repo https://kubernetes.github.io/ingress-nginx \
--namespace ingress-nginx --create-namespace \
--version 4.12.0 \
--set controller.config.allow-snippet-annotations=true \
--set controller.config.annotations-risk-level=Critical
```

Wait for the ingress-nginx controller:

```sh
kubectl wait --namespace ingress-nginx \
--for=condition=ready pod \
--selector=app.kubernetes.io/component=controller \
--timeout=90s
```

Verify the newly created pod under the ingress-nginx namespace:

```sh
kubectl get pods --namespace=ingress-nginx
```

More information can be found in the
[ingress-nginx deploy docs](https://kubernetes.github.io/ingress-nginx/deploy/).

## Install on KinD cluster

Create a KinD cluster with the necessary port mappings and node labels for
reaching the ingress-nginx controller from your local machine:

```shell
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
EOF
```

Install the specific flavor of the ingress-nginx controller for KinD
(`controller-v1.12.0` is the specific version we were using for testing, you can
check any newer version on the official ingress-nginx repository):

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/kind/deploy.yaml
```

Allow using snippet annotations in the ingress-nginx controller configuration,
which is required for older versions of the Alfresco charts to work properly (in
the newer versions of the charts, this is not required anymore as we moved to
avoid  using controller-specific annotations):

```sh
kubectl -n ingress-nginx patch cm ingress-nginx-controller \
  -p '{"data": {"annotations-risk-level":"Critical","allow-snippet-annotations":"true"}}'
```

> Warning: Enable this option only if you TRUST users with permission to create
> Ingress objects, as this may allow a user to add restricted configurations to
> the final nginx.conf file.

## Configure file uploads limitations

The alfresco-repository & alfresco-share Helm charts this chart depends on, come
with settings to limit the maximum size of file uploads and the maximum duration
of a request. These settings are configured using default ingress annotations.
They can be overriden from the umbrella chart (alfresco-content-services) by
setting the following values:

```yaml
alfresco-repository::
  ingress:
    annotations:
      nginx.ingress.kubernetes.io/proxy-body-size: 100m
      nginx.ingress.kubernetes.io/proxy-read-timeout: 600
share:
  ingress:
    annotations:
      nginx.ingress.kubernetes.io/proxy-body-size: 100m
      nginx.ingress.kubernetes.io/proxy-read-timeout: 600
```

> Above values would limit the uploads to 100 MB files or 10 minutes long
uploads in bith Alfresco repository API & Share UI.
