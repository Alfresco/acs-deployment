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

Run the following command to create a Kind cluster:

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

Wait for the Kind cluster to be created. This may take a few minutes.

## Step 3: Install ingress-nginx

Install the ingress-nginx controller namespace:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.12.0/deploy/static/provider/kind/deploy.yaml
```

Reconfigure ingress-nginx to allow snippet-annotations:

```sh
kubectl -n ingress-nginx patch cm ingress-nginx-controller \
  -p '{"data": {"annotations-risk-level":"Critical","allow-snippet-annotations":"true"}}'
```

Wait for the ingress-nginx controller:

```sh
kubectl wait --namespace ingress-nginx \
--for=condition=ready pod \
--selector=app.kubernetes.io/component=controller \
--timeout=90s
```

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

Now that you have successfully set up a Kind cluster with ingress-nginx and
metrics-server, you can now proceed with installing ACS via helm charts as per
[Desktop deployment](desktop-deployment.md#acs).
