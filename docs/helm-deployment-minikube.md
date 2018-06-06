# Alfresco Content Services Deployment with Helm using Minikube

## Prerequisites

To run the Alfresco Content Services (ACS) deployment using Minikube requires:

| Component   | Getting Started Guide |
| ------------| --------------------- |
| Minikube    | https://github.com/kubernetes/minikube |
| Kubectl     | https://kubernetes.io/docs/tasks/tools/install-kubectl/ |
| Helm        | https://docs.helm.sh/using_helm/#quickstart-guide |

### Starting Minikube VM

* Allocate at least 16GB RAM (to distribute among the Alfresco Content Services cluster nodes), 2 CPU cores, and 20GB disk space to the Minikube VM:
```bash
minikube start --cpus=4 --memory=16000
```
* Check that Minikube is running:
```bash
minikube version
minikube ip
```
* Start the Dashboard to see a web-based user interface of the Minikube cluster:
```bash
minikube dashboard
```

Here's an example start up command for Windows 10. You'll need to have the "My_Virtual_Switch" set up before this first command - see [blog](https://blogs.msdn.microsoft.com/wasimbloch/2017/01/23/setting-up-kubernetes-on-windows10-laptop-with-minikube/):
```bash
minikube start --vm-driver="hyperv" --cpus=4 --memory=12000 --hyperv-virtual-switch="My_Virtual_Switch" --v=7 --alsologtostderr
```
This downloads a Linux ISO and installs it in your Hyper V Manager. You should see a _minikube_ VM, after it's installed. It also installs all the required software in that VM, to simulate a Kubernetes cluster.  
You may need to add the ```--extra-config=kubelet.ImagePullProgressDeadline=30m0s``` parameter to your start command, as the docker images are rather big.

**Note:** Although 16GB is the required minimum memory setting, keep in mind that 12GB is lower than the required minimum, and may need to be adapted for your environment.

#### Initializing Helm

```bash
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```

## Adding Alfresco incubator Helm repository

* Add `http://kubernetes-charts.alfresco.com/incubator` to your Helm repository.
```bash
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
```

* Update the repository indexes:
```bash
helm repo update
```

* Check that the repository was added:
```bash
helm repo list
```

## Installing the ingress service

* Deploy nginx:
```bash
helm install stable/nginx-ingress --set rbac.create=true
```

After running this command remember the name of the ingress deployment, for example: "singed-chipmunk"


## Deploying Alfresco Content Services using Helm charts

When you install Alfresco Content Services from the Alfresco Helm repository, you don't need to download any code locally. All the charts will be picked up from the Helm repository.  You also have the option to install from the source code, which you'll need to download and modify.  Before starting the deployment, gather the required configuration.

* Get the IP and port of the ingress controller
```bash
minikube ip
# It will print something like: 172.31.147.123
kubectl get service singed-chipmunk-nginx-ingress-controller -o jsonpath={.spec.ports[0].nodePort}
# This will print a port like: 30917
```

### Option 1: Deploying Alfresco Content Services from the incubator Helm chart

* Run the following command to deploy Alfresco Content Services using the `alfresco-incubator` chart:
```bash
helm install alfresco-incubator/alfresco-content-services --set externalProtocol="http" --set externalHost="172.31.147.123" --set externalPort="30917"
```

### Option 2: Deploying Alfresco Content Services from the source code

If you want to modify the deployment and test it, the best option is to run the deployment from the source code.

* Clone this repository (https://github.com/Alfresco/acs-deployment) and modify it (if required):
```bash
git clone git@github.com:Alfresco/acs-deployment.git
cd acs-deployment
```
* Update the dependencies required:

```bash
cd helm/alfresco-content-services
helm dependency update
cd ..
```
**Note:** Make sure you run the command from the correct directory.

## Checking your deployment

After installing Alfresco Content Services, the following URLs are displayed in the terminal:
```
  Content: http://172.31.147.123:30917/alfresco
  Share: http://172.31.147.123:30917/share
  Solr: http://172.31.147.123:30917/solr
```
You'll need to wait for some time for the deployment to start up. Use the Minikube dashboard to track the state of the deployment.

## Cleaning up your deployment

See [clean up steps](docs/helm-deployment-aws_cloud.md#cleaning-up-your-deployment) for more details.
