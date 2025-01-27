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
