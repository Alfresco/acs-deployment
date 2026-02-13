---
title: Kind
parent: Deployment
grand_parent: Helm
---

# Alfresco Content Services Helm Deployment on KinD cluster

This page describe how to get ACS up and running on a [Kubernetes In
Docker](https://kind.sigs.k8s.io/) (KinD) cluster.

KinD is better suited to run helm workloads inside CI environments but works
well also for local development because it just requires a working Docker
server.

## Prerequisites

- Docker installed on your machine (Docker Desktop, Rancher Desktop, Podman and similar)
- Kubernetes CLI (kubectl) installed on your machine
- Helm CLI installed on your machine

## Step 1: Install Kind

Take a look to the [KinD
quickstart](https://kind.sigs.k8s.io/docs/user/quick-start/) to learn how to
install the binary cli on your machine and to learn briefly the main commands
that you can run.

## Step 2: Create a Kind Cluster

Run the following command to create the default Kind cluster:

```shell
kind create cluster
```

You can also create a cluster targeting a specific Kubernetes version, for example:

```shell
kind create cluster --image kindest/node:v1.34.3@sha256:08497ee19eace7b4b5348db5c6a1591d7752b164530a36f855cb0f2bdcbadd48
```

The node image ref needs to be retrieved from the [KinD releases
page](https://github.com/kubernetes-sigs/kind/releases), by looking at the
release notes of your current kind version (run `kind version` to check your
version).

Wait for the Kind cluster to be created. This usually takes a few minutes.

## Step 3: Install an Ingress Controller

See [Traefik](traefik.md) section.

The [ingress-nginx](ingress-nginx.md) section is kept for reference only, as
ingress-nginx is deprecated and not recommended for new deployments.

## Install metrics server

Optionally, you can [install metrics
server](https://github.com/kubernetes-sigs/metrics-server#installation) to
gather metrics from node and pods.

Make sure to enable insecure tls option otherwise metrics collection would not work under KinD:

```sh
kubectl patch -n kube-system deployment metrics-server --type=json \
  -p '[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
```

Wait for a few minutes and then try to run:

```sh
kubectl top node
```

Upon installing ACS, you can check current cpu and memory usage via:

```sh
kubectl top pods
```

## Conclusion

Now that you have successfully set up a Kind cluster with an Ingress controller
and metrics-server, you can now proceed with installing ACS via helm charts as
per [Desktop deployment](desktop-deployment.md#acs).
