# Alfresco Content Services Deployment with Helm on a local host


## Prerequisites

To run the Alfresco Content Services (ACS) deployment on a local host with Kubernetes requires:

| Component   | Recommended version | Getting Started Guide |
| ------------|:-----------: | ---------------------- |
| Minikube    | 0.25.0       | https://docs.docker.com/ |
| Kubectl     | 1.8.4        | https://kubernetes.io/docs/tasks/tools/install-kubectl/ |
| Helm        | 2.8.2        | https://docs.helm.sh/using_helm/#quickstart-guide |

### Starting minikube VM

* Allocate at least 16GB RAM (to distribute among the Alfresco Content Services cluster nodes), 2 CPU cores, and 20GB disk space to the minikube VM:
```bash
minikube start --cpus=4 --memory=16000
```
* Check that minikube is running:
```bash
minikube version
minikube ip
```
* Start the Dashboard to see a web-based user interface of the minikube cluster:
```bash
minikube dashboard
```

**Note:**
Here's the start up command for Windows 10 (you need to have the "My_Virtual_Switch" set up before this first command - see [blog](https://blogs.msdn.microsoft.com/wasimbloch/2017/01/23/setting-up-kubernetes-on-windows10-laptop-with-minikube/)):
```bash
minikube start --vm-driver="hyperv" --cpus=4 --memory=8000 --hyperv-virtual-switch="My_Virtual_Switch" --v=7 --alsologtostderr
```
This will download a Linux ISO and install it in your Hyper V Manager. You should see a _minikube_ VM, after it is installed. It also installs all the required software in that VM, to simulate a Kubernetes cluster.  
You may need to add the ```--extra-config=kubelet.ImagePullProgressDeadline=30m0s``` parameter to your start command, as the docker images are rather big.  

#### Initializing Helm

```bash
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```

## Adding Alfresco incubator Helm repository

* Add `http://kubernetes-charts.alfresco.com/incubator` to your helm repository.
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


## Deploying Alfresco Content Services using a Helm chart

When you install Alfresco Content Services from the Alfresco Helm repository, you don't need to download any code locally. All the charts will be picked up from the helm repository.  You also have the option to install from the source code, which you'll need to download and modify.  Before starting the deployment, gather the required configuration.

* Get the IP and port of the ingress controller
```bash
minikube ip
# It will print something like: 172.31.147.123
kubectl get service singed-chipmunk-nginx-ingress-controller -o jsonpath={.spec.ports[0].nodePort}
# This will print a port like: 30917
```

### Option 1: Deploying Alfresco Content Services from the incubator Helm chart

* Run the following command to install ACS using the `alfresco-incubator` chart:
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
You'll need to wait for some time for the deployment to start up. Use the minikube dashboard to track the state of the deployment.
