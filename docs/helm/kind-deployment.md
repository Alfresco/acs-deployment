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

## Step 3: Install cloud-provider-kind

Install the cloud-provider-kind plugin to enable cloud provider features on your KinD cluster.

You can find the latest binaries available on the GitHub
[releases page](https://github.com/kubernetes-sigs/cloud-provider-kind/releases) of the project.

If you are using brew, you can install it with:

```shell
brew install cloud-provider-kind
```

## Step 4: Run cloud-provider-kind

`cloud-provider-kind` is a separate binary that you need to keep running in the
background while your cluster is up and running.

It will automatically attach to your KinD cluster and monitor for any `Service`
of type `LoadBalancer` that you create, by assigning them an IP address and
making them reachable from your local machine.

Open a new terminal and run the following command:

```shell
sudo cloud-provider-kind
```

If you are running a Docker server that runs within a dedicated VM (like Podman
Desktop on Mac and Windows), it will automatically detect it and enable the
`--enable-lb-port-mapping` option to make the LoadBalancer endpoint easily
reachable from your local machine, exposed on `localhost`.

This is not strictly required when running on native Linux, but accessing
Alfresco via `localhost` is usually more compatible when using plain http
access.

## Step 5: Install an Ingress Controller

See [Traefik](traefik.md) section.

The [ingress-nginx](ingress-nginx.md) section is kept for reference only, as
ingress-nginx is deprecated and not recommended for new deployments.

Once traefik is installed, verify that the LoadBalancer external IP has been
assigned by running:

```sh
kubectl get svc -n traefik
```

You should see something like:

```sh
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
traefik   LoadBalancer   10.96.209.229   10.89.0.3     80:30539/TCP,443:31996/TCP   4m
```

The `external-ip` is the IP address of the container that `cloud-provider-kind`
plugin has created to route the traffic to the Traefik controller, and that you
can see when looking at the running containers in your Docker server:

```sh
docker ps
```

You will see a container named `kindccm-...` with the ports 80 and 443 exposed,
which is the one routing the traffic to Traefik, making it reachable from your
local machine.

```sh
ee93d7c8c02d  docker.io/envoyproxy/envoy:v1.33.2                                                              bash -c echo -en ...  About a minute ago  Up About a minute  0.0.0.0:36059->80/tcp, 0.0.0.0:36315->443/tcp, 0.0.0.0:39449->10000/tcp  kindccm-7110e8686bde
ee3409fd1845  docker.io/envoyproxy/envoy:v1.33.2                                                              bash -c echo -en ...  About a minute ago  Up About a minute  0.0.0.0:43741->80/tcp, 0.0.0.0:36821->10000/tcp                          kindccm-gw-7b19b33a85f6
```

Try briefly to access `localhost:36059` from your browser and you should see the
default `404 page not found` of Traefik, which means that the traffic is correctly
routed to the Traefik controller.

Verify that also the traefik pod logs show the incoming request:

```sh
kubectl logs -n traefik -l app.kubernetes.io/name=traefik
```

## Step 6: Install metrics server

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
