
# Alfresco Content Services Deployment

### Contributing guide
Please use [this guide](CONTRIBUTING.md) to make a contribution to the project.

This project contains the code for starting the entire Alfresco Content Services product **with docker or kubernetes**.

For the Community edition go to the [acs-community-deployment](https://github.com/Alfresco/acs-community-deployment).
The only two differences:
* in the enterprise (this project) chart the transformers images are used, instead of the included binaries.
* in the enterprise (this project) chart a cluster of two alfresco-content-repositories are started by default

## Docker-compose & Kubernetes
Start Alfresco Content Services  using docker-compose or Kubernetes, containing:
1. Alfresco Repository, with:  
1.1. Alfresco Share Services amp  
1.2. Alfresco AOS amp  
1.3. Alfresco vti-bin war - that helps with AOS integration  
1.4. Alfresco Google Docs Repo amp  
2. Alfresco Share, with:  
2.1 Alfresco Google Docks Share amp  
3. A Postgres DB  
4. Alfresco Solr6  

### Docker Compose Instructions:
#### Prerequisite: 
* Docker installed locally 

#### Steps
1. Go to **docker-compose** folder
2. Run ```docker-compose up``` 
3. Check that everything starts up with the browser: http://localhost:8082/alfresco and http://localhost:8080/share and http://localhost:8083/solr/

#### Notes:
* Make sure the local machine has the ports (5432, 8080, 8082, 8083) set up in the docker-compose.yml file free.

### How to get started with Kubernetes and Alfresco Content Services.

#### Assumptions

We will be using minikube to demonstrate how you can deploy the Alfresco Content Services helm charts. We will assume that you are familiar with the Kubernetes technology - at least basic knowledge, and there is also the assumption that you have a working minikube setup that you can use. Running some kind of [hello-world application](https://github.com/kubernetes/helm/blob/master/docs/chart_template_guide/getting_started.md) in your minikube cluster usually proves that it is set up correctly.

If you are not familiar with [Kubernetes](https://kubernetes.io/) (also written as k8s), there are a lot of tutorials and guides online to get you started. Here are some starting points:
* https://github.com/kubernetes/kubernetes -> this has a section [To start using kubernetes](https://github.com/kubernetes/kubernetes#to-start-using-kubernetes) with some hands on tutorials.
* https://github.com/kubernetes/minikube -> this explains what minikube and kubectl is.
* https://helm.sh/ -> information about helm package manager.

For these examples, we assume that we will use the default namespace. The professional thing to do is to use proper namespaces to separate your deployments so, do use namespace if you want. Proper examples in the **tutorial with AWS support** linked in the _Other information_ section at the end.

#### Step 1: Make sure your minikube is setup, started and running fine

Setting up and starting up minikube may be a little bit different depending on the environment you are working with. Setting up, usually, involves just downloading the **minikube**, **kubectl** and **helm** binaries and adding them to the PATH system variable. 

**Resource requirement for testing**: allocate at least 8GB or RAM, 4 CPU cores and 20GB disk space to your minikube VM.

##### minikube

Example of start up command on windows (you need to have the "My_Virtual_Switch" set up before this first command - see [blog](https://blogs.msdn.microsoft.com/wasimbloch/2017/01/23/setting-up-kubernetes-on-windows10-laptop-with-minikube/)):
```bash
minikube start --vm-driver="hyperv" --cpus=4 --memory=8000 --hyperv-virtual-switch="My_Virtual_Switch" --v=7 --alsologtostderr
```
This will download a linux iso and install it in your Hyper V Manager - you should see a **minikube** VM, after it is installed. It also installs all the needed software in that VM, to simulate a kubernetes cluster.  
**Note:** you may need to add ```--extra-config=kubelet.ImagePullProgressDeadline=30m0s``` parameter to your start command, as the docker images are rather big.  

##### helm
Run this command to initialize helm:
```bash
helm init
```

##### commands to check the minikube kubernetes cluster is running:
```bash
minikube version
minikube ip
# the following command opens a web UI of the minikube cluster
minikube dashboard

helm version
helm repo list

kubectl version
kubectl get pods
kubectl get secrets
```

#### Step 2: Install the ingress service:
```bash
helm repo update
helm install stable/nginx-ingress --version 0.8.11 
# After running this command look for the name of the ingress deployment. 
# It is usually an animal name preceded by an adjective like: "singed-chipmunk"

# Next get the ip and port of the ingress controller
minikube ip
# It will print something like: 172.31.147.123

# To get the port, replace "singed-chipmunk" with the name of 
# your nginx-ingress-controller deployment
kubectl get service singed-chipmunk-nginx-ingress-controller -o jsonpath={.spec.ports[0].nodePort}
# This will print a port like: 30917

# Combine the ip from the prev command and port to get the 
# dnsaddress value: http://172.31.147.123:30917 that we will use later
```

#### Step 3 Add the alfresco incubator helm repository

We need this to add the persistent volume claim defined in the infrastructure. Everything else in the infrastructure is disabled for the moment, but the idea is that in the future we could easily enable components based on the new features that we will enable/implement.

### Add the incubator helm repo:
```bash
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
helm repo list
```

#### Step 4: Deploy Alfresco Content Services from the alfresco incubator helm repository

When you install Alfresco Content Services from the alfresco helm repository, you don't need to download any code locally. All the charts will be picked up from the helm repository.

##### Install ACS:

**Note:** Use the correct dnsaddress for your deployment of ingress from the prev Step 2.

```bash
helm install alfresco-incubator/alfresco-content-services --set dnsaddress="http://172.31.147.123:30917" 
```

#### Alternative Step 4: Deploy Alfresco Content Services from the source code 

If you want to modify the deployment, and test it, you probably want to use the deployment method from code.

**Note:** You still need to do Step 3 to add the alfresco helm repo for this step to work.

##### Take the code (and modify it if you want)

From https://github.com/Alfresco/acs-deployment
```bash
git clone git@github.com:Alfresco/acs-deployment.git
cd acs-deployment
```
##### Update the dependencies required

The current directory is important. Pay attention!
```bash
cd helm/alfresco-content-services
helm dependency update
cd ..
```
##### Install ACS

```bash
# make sure you are in the /helm folder
helm install alfresco-content-services --set dnsaddress="http://172.31.147.123:30917" 
```

#### Step 5: Check that ACS is running

After running the ```helm install alfresco-content-services``` command you should see something like:
```
.....
  Content: http://172.31.147.123:30917/alfresco
  Share: http://172.31.147.123:30917/share
  Solr: http://172.31.147.123:30917/solr
```
And after enough time has passed for the minikube to download all the docker images needed and to start them up, you should be able to open your browser to those addresses and check that alfresco, share and solr work fine.  

You can also use kubectl/helm commands to check the status and logs of the pods in the deployment.

#### Other information

You can find the helm chart [here](https://github.com/Alfresco/acs-deployment/tree/master/helm/alfresco-content-services).

The system should handle pod recreation without any problem - persistent storage is implemented.

Alternative commands and start up [tutorial with AWS support](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/running-a-cluster.md) 

[Tips and tricks](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/tips-and-tricks.md) for working with kubernetes and ACS.


#### Notes:
* You can also change those values when deploying the helm chart by running ```helm install alfresco-incubator/alfresco-content-services --set repository.image.tag="yourTag" --set share.image.tag="yourTag"```.
* Hint: Run  ```eval $(minikube docker-env)``` to switch to your minikube docker environment on osx.


