# Setting up Kind for Helm Chart Installation

## Prerequisites

- Docker installed on your machine
- Kubernetes CLI (kubectl) installed on your machine
- Helm CLI installed on your machine

## Step 1: Install Kind

## Step 2: Create a Kind Cluster

1. Open a terminal window.
2. Run the following command to create a Kind cluster:

    ```shell
    cat <<EOF | kind create cluster -n acs-testing --config=-
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

3. Wait for the Kind cluster to be created. This may take a few minutes.

## Install ingress-nginx

[install kind](https://kind.sigs.k8s.io/docs/user/ingress/#ingress-nginx)

```sh
kubectl -n ingress-nginx patch cm ingress-nginx-controller \
  -p '{"data": {"allow-snippet-annotations":"true"}}'
```

```sh
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
```

## Install metrics server

[install metrics server](https://github.com/kubernetes-sigs/metrics-server#installation)

```sh
kubectl patch -n kube-system deployment metrics-server --type=json \
  -p '[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
```

## Conclusion

You have successfully set up Kind and Helm for installing Helm charts. You can now proceed with installing your desired Helm charts on the Kind cluster.
