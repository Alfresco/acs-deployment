# Alfresco Content Services Deployment with custom metadata keystore

Alfresco content repository Docker images comes with a precreated default keystore that contains a secret key. See more information in [docs.alfresco.com](https://docs.alfresco.com/6.2/concepts/alf-keystores.html) and [Dockerfile](https://github.com/Alfresco/acs-packaging/blob/master/docker-alfresco/Dockerfile#L81-L85).

It is recommended to generate a new keystore in production systems. It can be mounted to the content-repository docker image to this location "/usr/local/tomcat/shared/classes/alfresco/keystore/". If the standard names of the keystore and the key are used, it is only required to change password values in [values.yaml](../../helm/alfresco-content-services/values.yaml):
```yaml
metadataKeystore:
  keystorePassword: ""
  keyPassword: ""
```
Otherwise, please refer to the full list of configuration options in [docs.alfresco.com](https://docs.alfresco.com/6.2/concepts/keystore-config.html)
