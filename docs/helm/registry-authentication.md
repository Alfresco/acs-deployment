---
title: Registry authentication
parent: Guides
grand_parent: Helm
---

# Private registry authentication

For pulling images served by a registry that requires authentication, you have
to create a secret which contains the credentials and provide its name in the
`global.alfrescoRegistryPullSecrets` value.

> Secret should be created in the same namespace where you are going to install ACS

Create the secret of type `docker-registry` with following command, replacing
`YOUR-USERNAME` and `YOUR-PASSWORD` with your credentials and `YOUR-REGISTRY`
with your private registry hostname:

```bash
kubectl -n alfresco create secret docker-registry my-registry-secret --docker-server=YOUR-REGISTRY --docker-username=YOUR-USERNAME --docker-password=YOUR-PASSWORD 
```

For the Alfresco Enterprise docker images, you need to have credentials for `quay.io`:

```bash
kubectl -n alfresco create secret docker-registry quay-registry-secret --docker-server=quay.io --docker-username=YOUR-USERNAME --docker-password=YOUR-PASSWORD 
```

Alternatively, you can also leverage an already configured docker client using the `--from-file` option (this will create a secret containing ALL the credentials you have currently configured):

```bash
kubectl -n alfresco create secret generic docker-registry-secrets --from-file=.dockerconfigjson=/your-home/.docker/config.json --type=kubernetes.io/dockerconfigjson 
```
