# Customising your deployment

Alfresco Content Services is composed of the following images:

1. alfresco-content-repository |  [tags](https://hub.docker.com/r/alfresco/alfresco-content-repository/tags/)
2. alfresco-pdf-renderer | [tags](https://hub.docker.com/r/alfresco/alfresco-pdf-renderer/tags/)
3. alfresco-imagemagick | [tags](https://hub.docker.com/r/alfresco/alfresco-imagemagick/tags/)
4. alfresco-libreoffice | [tags](https://hub.docker.com/r/alfresco/alfresco-libreoffice/tags/)
5. alfresco-tika | [tags](https://hub.docker.com/r/alfresco/alfresco-taka/tags/)
6. alfresco-share | [tags](https://hub.docker.com/r/alfresco/alfresco-share/tags/)
7. alfresco-search-services | [tags](https://hub.docker.com/r/alfresco/alfresco-search-services/tags/)
8. postgres | [tags](https://hub.docker.com/r/library/postgres/tags/)

For Docker Compose usage, edit the image tags in the [docker-compose.yml](https://github.com/Alfresco/acs-deployment/blob/master/docker-compose/docker-compose.yml) file.  

For Helm charts usage, edit the image tags in the  [values.yaml](https://github.com/Alfresco/acs-deployment/blob/master/helm/alfresco-content-services/values.yaml) file.  

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

**Note:**
* Use the recommended image tags, as not all combinations may work.
* You can modify the values provided in [values.yaml](https://github.com/Alfresco/acs-deployment/blob/master/helm/alfresco-content-services/values.yaml) when deploying the Helm chart. For example, you can run:
```bash
helm install alfresco-incubator/alfresco-content-services --set repository.image.tag="yourTag" --set share.image.tag="yourTag"
```
* You can run ```eval $(minikube docker-env)``` to switch to your Minikube Docker environment on Mac OS X.

### K8s deployment customization guidelines
 
 All the customizations (including major configuration changes) should be done inside the Docker image, resulting in the creation of a new image with a new tag. This approach allows changes to be tracked in the source code (Dockerfile) and rolling updates to the deployment in the K8s cluster.
 
 The helm chart configuration customization should only include environment-specific changes (for example DB server connection properties) or altered Docker image names and tags. The configuration changes applied via "--set" will only be reflected in the configuration stored in k8s cluster, a better approach would be to have those in VCS.
