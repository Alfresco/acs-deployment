Alfresco Elasticsearch Connector

The [Alfresco Elasticsearch Connector](https://docs.alfresco.com/) ...

## Prerequisites

...


## Deploy

...

```bash
helm install acs alfresco/alfresco-content-services \
--values esc_values.yaml \
--set externalPort="80" \
--set externalProtocol="http" \
--set externalHost="localhost" \
--set global.alfrescoRegistryPullSecrets=my-registry-secrets \
--set repository.replicaCount=1 \
--set transformrouter.replicaCount=1 \
--set pdfrenderer.replicaCount=1 \
--set imagemagick.replicaCount=1 \
--set libreoffice.replicaCount=1 \
--set tika.replicaCount=1 \
--set transformmisc.replicaCount=1 \
--set postgresql-syncservice.resources.requests.memory="500Mi" \
--set postgresql-syncservice.resources.limits.memory="500Mi" \
--set postgresql.resources.requests.memory="500Mi" \
--set postgresql.resources.limits.memory="500Mi" \
--set alfresco-search.resources.requests.memory="1000Mi" \
--set alfresco-search.resources.limits.memory="1000Mi" \
--set share.resources.limits.memory="1500Mi" \
--set share.resources.requests.memory="1500Mi" \
--set repository.resources.limits.memory="2500Mi" \
--set repository.resources.requests.memory="2500Mi"\
--atomic \
--timeout 10m0s \
--namespace=alfresco
```

Access to Kibana console

```bash
kubectl port-forward service/acs-kibana 5601:5601 -n davide
```
