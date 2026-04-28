---
title: Traefik install
parent: Guides
grand_parent: Helm
---

# Install Traefik

We recommend using Traefik as a modern, feature-rich ingress controller for
Kubernetes deployments. This short guide shows a minimal install and how our
charts integrate with Traefik.

However, our charts provide flexibility through values such as
`.ingress.className` and `.ingress.annotations`, allowing you to customize the
Ingress configuration. If you prefer to manage Ingress resources yourself, you
can set `.ingress.enabled` to `false` to disable the bundled Ingress resource
and provide your own.

## Install on KinD cluster

If you are using a KinD cluster, you can follow the instructions in the
[KinD deployment](kind-deployment.md).

## Install on a generic Kubernetes cluster

Add the Traefik Helm repository and install the chart into the `traefik`
namespace:

```sh
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm upgrade --install traefik traefik/traefik \
  --set providers.kubernetesIngressNginx.enabled=true \
  --set logs.access.enabled=true \
  --namespace traefik --create-namespace
```

The `providers.kubernetesIngressNginx.enabled=true` option is required to tell
Traefik to watch for `Ingress` resources with `ingressClassName` set to `nginx`,
which is still the default in our charts for backwards compatibility reasons.

It's critical to have an `nginx` `IngressClass` resource in the cluster, even
after uninstalling ingress-nginx, otherwise Traefik won't pick up any `Ingress`
resources with `ingressClassName: nginx` (currently the default in our charts).

Ensure that the `nginx` `IngressClass` resource is present in the cluster:

```sh
kubectl get ingressclass nginx
```

If the `nginx` `IngressClass` resource is missing, you can create it with the
following command:

```sh
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: nginx
spec:
  controller: k8s.io/ingress-nginx
EOF
```

While the access logs are not strictly required (enabled via
`logs.access.enabled=true`), they can be very useful for debugging and
monitoring purposes, especially during the initial setup and configuration of
Traefik.

Wait for the Traefik pods to become ready:

```sh
kubectl wait --namespace traefik \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=traefik \
  --timeout=90s
```

Verify the controller is running:

```sh
kubectl get pods --namespace traefik
```

Traefik supports both standard Kubernetes `Ingress` resources and its own CRDs
(`IngressRoute`, `Middleware`, etc.). Our charts are currently using the
standard `Ingress` resources to ensure broad compatibility.

More information about installing and configuring Traefik can be found in the
[Traefik documentation](https://doc.traefik.io/traefik/setup/kubernetes/).
