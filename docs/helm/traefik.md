---
title: Traefik guide
parent: Guides
grand_parent: Helm
---

# Install Traefik

We recommend using Traefik as a modern, feature-rich ingress controller for
Kubernetes deployments. This short guide shows a minimal install and how our
charts integrate with Traefik.

## Install on KinD cluster

If you are using a KinD cluster, you can follow the instructions in the
[KinD deployment](kind-deployment.md#step-3-install-an-ingress-controller)

## Install on a generic Kubernetes cluster

Add the Traefik Helm repository and install the chart into the `traefik`
namespace:

```bash
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm upgrade --install traefik traefik/traefik \
  --namespace traefik --create-namespace
```

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
