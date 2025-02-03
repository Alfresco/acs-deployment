---
title: Ingress guide
parent: Guides
grand_parent: Helm
---

# Install ingress-nginx

We currently support and test only
[ingress-nginx](https://github.com/kubernetes/ingress-nginx), but all of our
charts supports overriding via values the `ingressSourceClass` and `annotations`
which allows to use your preferred ingress controller.

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
