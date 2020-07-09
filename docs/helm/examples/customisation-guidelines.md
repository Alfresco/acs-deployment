# Customisation Guidelines

To use a custom Docker image edit the image tags in the [values.yaml](../../../helm/alfresco-content-services/values.yaml) file.

```
project
│
└───helm
    │  
    └───alfresco-content-services
        │
        └───values.yaml
```

**Note:**
* Use or extend from the recommended image tags, as not all combinations may work.
* You can override the values provided in [values.yaml](../../../helm/alfresco-content-services/values.yaml) when deploying the Helm chart. For example, you can run:
```bash
helm install alfresco-incubator/alfresco-content-services --set repository.image.tag="yourTag" --set share.image.tag="yourTag"
```

## K8s deployment customization guidelines

All the customizations (including major configuration changes) should be done inside the Docker image, resulting in the creation of a new image with a new tag. This approach allows changes to be tracked in the source code (Dockerfile) and rolling updates to the deployment in the K8s cluster.

The helm chart configuration customization should only include environment-specific changes (for example DB server connection properties) or altered Docker image names and tags. The configuration changes applied via "--set" will only be reflected in the configuration stored in k8s cluster, a better approach would be to have those in VCS.
