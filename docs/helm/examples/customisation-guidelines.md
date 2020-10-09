# Customisation Guidelines

Any customisations (including major configuration changes) should be done inside the Docker image, resulting in the creation of a new image with a new tag. This approach allows changes to be tracked in the source code (Dockerfile) and rolling updates to the deployment in the K8s cluster.

The helm chart configuration customisation should only include environment-specific changes (for example DB server connection properties) or altered Docker image names and tags. The configuration changes applied via "--set" will only be reflected in the configuration stored in k8s cluster, a better approach would be to have those in source control i.e. maintain your own values files.

## Creating Custom Docker Images

The [docker compose Customisation Guide](../../docker-compose/examples/customisation-guidelines.md) provides a detailed example of how to apply an AMP in a custom image and a more advanced example of building a custom image with configuration can be found [here](https://github.com/Alfresco/acs-packaging/blob/master/docs/create-custom-image-using-existing-docker-image.md#applying-amps-that-require-additional-configuration-advanced).

## Using Custom Docker Images

Once you have created your custom image you can either change the default values in the appropriate values file in [this folder](../../../helm/alfresco-content-services) or you can override the values via the `--set` command line option during install as shown below:

```bash
helm install alfresco-incubator/alfresco-content-services --set repository.image.repository="yourRegistry" --set repository.image.tag="yourTag" --set share.image.repository="yourRegistry" --set share.image.tag="yourTag"
```
