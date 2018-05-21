
# Alfresco Content Services Deployment

## Contributing guide
Please use [this guide](CONTRIBUTING.md) to make a contribution to the project.

This project contains the code for starting the entire Alfresco Content Services product **with Docker or Kubernetes**.

For the Community edition go to the [acs-community-deployment](https://github.com/Alfresco/acs-community-deployment).
The only two differences:
* in the enterprise (this project) chart the transformers images are used, instead of the included binaries.
* in the enterprise (this project) chart a cluster of two alfresco-content-repositories are started by default

## Contents of the deployment
Alfresco Content Services deployed via docker-compose or Kubernetes contains the following:
1. Alfresco Repository, with:  
1.1. Alfresco Share Services amp  
1.2. Alfresco AOS amp  
1.3. Alfresco vti-bin war - that helps with AOS integration  
1.4. Alfresco Google Docs Repo amp  
2. Alfresco Share, with:  
2.1 Alfresco Google Docks Share amp  
3. A Postgres DB  
4. Alfresco Solr6  

## Running with Docker Compose
#### Prerequisites
* Docker
* Docker-compose

#### Run ACS
1. Clone this repository or download single [docker-compose](docker-compose/docker-compose.yml).
2. Navigate to the folder where the _docker-compose.yml_ file is located.
3. Run ```docker-compose up```
4. Check that everything starts up by checking the following URLs in the browser:
* http://<machine_ip>:8082/alfresco
* http://<machine_ip>:8080/share
* http://<machine_ip>:8083/solr
Please note: If you are re-running ```docker-compose up``` after destroying a previous docker compose cluster then please
use the command: ```docker-compose down && docker-compose build --no-cache && docker-compose up``` at Step-3 above.

#### Notes:
* Make sure the machine has open ports (5432, 8080, 8082, 8083), see the _docker-compose.yml_ for details.
* If the Docker is running on your local machine the ip address will be just _localhost_. If you are using [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows) the ip address can be found by running ```docker-machine ip```

## Running with Kubernetes
### Minikube

#### Prerequisites
* Minikube
* Helm
* kubectl

#### Start minikube VM
Allocate at least 8GB of RAM, 2 CPU cores and 20GB disk space to minikube VM.
```bash
minikube start --cpus=4 --memory=8000 
```
Check that the minikube is running
```bash
minikube version
minikube ip
```
Try the admin dashboard web UI of the minikube cluster
```bash
minikube dashboard
```

**Note**
Start up command for Windows 10 (you need to have the "My_Virtual_Switch" set up before this first command - see [blog](https://blogs.msdn.microsoft.com/wasimbloch/2017/01/23/setting-up-kubernetes-on-windows10-laptop-with-minikube/)):
```bash
minikube start --vm-driver="hyperv" --cpus=4 --memory=8000 --hyperv-virtual-switch="My_Virtual_Switch" --v=7 --alsologtostderr
```
This will download a linux iso and install it in your Hyper V Manager - you should see a **minikube** VM, after it is installed. It also installs all the needed software in that VM, to simulate a kubernetes cluster.  
You may need to add ```--extra-config=kubelet.ImagePullProgressDeadline=30m0s``` parameter to your start command, as the docker images are rather big.  

#### Initialize Helm
```bash
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```
#### Add the Alfresco incubator Helm repository
Add a new repository
```bash
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
```
Update repository indexes
```bash
helm repo update
```
Check that the repository was added
```bash
helm repo list
```
#### Install the ingress service:
Deploy nginx:
```bash
helm install stable/nginx-ingress --set rbac.create=true
```
After running this command remember the name of the ingress deployment, like: "singed-chipmunk"

#### Deploy Alfresco Content Services from the incubator helm repository

When you install Alfresco Content Services from the alfresco helm repository, you don't need to download any code locally. All the charts will be picked up from the helm repository.
Before starting the deployment, gather the required configuration:
* IP and port of the ingress controller
```bash
minikube ip
# It will print something like: 172.31.147.123
kubectl get service singed-chipmunk-nginx-ingress-controller -o jsonpath={.spec.ports[0].nodePort}
# This will print a port like: 30917
```
Deploy ACS:
```bash
helm install alfresco-incubator/alfresco-content-services --set externalProtocol="http" --set externalHost="172.31.147.123" --set externalPort="30917"
```

#### Alternatively deploy Alfresco Content Services from the source code

If you want to modify the deployment, and test it, you probably want to use the deployment method from code.

##### Clone this repository (https://github.com/Alfresco/acs-deployment) and modify if required
```bash
git clone git@github.com:Alfresco/acs-deployment.git
cd acs-deployment
```
##### Update the dependencies required

The current directory is important.
```bash
cd helm/alfresco-content-services
helm dependency update
cd ..
```
##### Install ACS
```bash
# make sure you are in the /helm folder
helm install alfresco-content-services --set externalProtocol="http" --set externalHost="172.31.147.123" --set externalPort="30917"
```

#### Check that ACS is running
After installation of ACS there will be URLs displayed in the terminal:
```
  Content: http://172.31.147.123:30917/alfresco
  Share: http://172.31.147.123:30917/share
  Solr: http://172.31.147.123:30917/solr
```
Some time is required for the deployment to start up. Use minikube dashboard to track the state of the deployment.

## Customising alfresco deployment.
Alfresco Content Services is composed out of the following images:
1. alfresco-content-repository |  [tags](https://hub.docker.com/r/alfresco/alfresco-content-repository/tags/)
2. alfresco-pdf-renderer | [tags](https://hub.docker.com/r/alfresco/alfresco-pdf-renderer/tags/)
3. alfresco-imagemagick | [tags](https://hub.docker.com/r/alfresco/alfresco-imagemagick/tags/)
4. alfresco-libreoffice | [tags](https://hub.docker.com/r/alfresco/alfresco-libreoffice/tags/)
5. alfresco-share | [tags](https://hub.docker.com/r/alfresco/alfresco-share/tags/)
6. alfresco-search-services | [tags](https://hub.docker.com/r/alfresco/alfresco-search-services/tags/)
7. postgres | [tags](https://hub.docker.com/r/library/postgres/tags/)

For docker-compose usage, edit image tags in [docker-compose.yml](https://github.com/Alfresco/acs-deployment/blob/master/docker-compose/docker-compose.yml) file.  
For helm charts usage, edit image tags in [values.yaml](https://github.com/Alfresco/acs-deployment/blob/master/helm/alfresco-content-services/values.yaml) file.  

```
project
│
└───docker-compose
│   │
│   └──docker-compose.yml
│
└───helm
    │  
    └───alfresco-content-services
        │
        └───values.yaml
```

#### Notes:  
* Not all combination of image tags may work, please use the recommended ones.
* Values from [values.yaml](https://github.com/Alfresco/acs-deployment/blob/master/helm/alfresco-content-services/values.yaml) can be changed when deploying the helm chart by running ```helm install alfresco-incubator/alfresco-content-services --set repository.image.tag="yourTag" --set share.image.tag="yourTag"```.
* Hint: Run  ```eval $(minikube docker-env)``` to switch to your minikube docker environment on osx.

## Other information
Alternative commands and start up [tutorial with AWS support](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/running-a-cluster.md)

[Tips and tricks](https://github.com/Alfresco/alfresco-anaxes-shipyard/blob/master/docs/tips-and-tricks.md) for working with kubernetes and ACS.

