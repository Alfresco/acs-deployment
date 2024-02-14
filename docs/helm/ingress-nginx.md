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
  --namespace ingress-nginx --create-namespace
```

Enable snippet annotations which is disabled by default for security reasons, but
we still requires it for `alfresco-search-services` while still filtering only
the ones we strictly need.

```bash
kubectl -n ingress-nginx patch cm ingress-nginx-controller \
  -p '{"data": {"allow-snippet-annotations":"true"}}'
```

Wait for the ingress-nginx controller to be up again after the configuration change:

```sh
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```
