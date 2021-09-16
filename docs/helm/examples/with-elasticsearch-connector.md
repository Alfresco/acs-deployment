# Alfresco Elasticsearch Connector 

The [Alfresco Elasticsearch Connector](https://github.com/Alfresco/alfresco-elasticsearch-connector) (aka Search Service v.3x) aims to replace Alfresco Search in order to index and search Alfresco nodes using Elasticsearch instead of Solr.

## Prerequisites

Depending on where do you want to install Alfresco Content Services (ACS) , you need to follow the corresponding guide, for instance this is the one for a Kubernetes cluster based on [Docker Desktop](../docker-desktop-deployment.md).

## Deploy

In order to replace Alfresco Search with Alfresco Elasticsearch Connector you need to set the `alfresco-elasticsearch-connector.enabled` property to `true` and `alfresco-search.enabled` to `false`.
You can use the esc_values.yaml file in the Git repository adding more configuration if required.

The Alfresco Elasticsearch Connector will start **4 new Kubernetes deployment** for live indexing:
- **Mediation**, must be always a single node, it orchestrates events from Alfresco Repository.
- **Metadata**, it is responsible for indexing node metadata.
- **Content**, it is in charge of indexing content.
- **Path**, this application indexes the path of a node

Moreover, a **Kubernetes job** will be started in order to reindex existing contents in Elasticsearch. We suggest running this job only at the first startup.
You can enable or disable it setting the `alfresco-elasticsearch-connector.reindexing.enabled` property to `true` or `false`.
Currently, this Helm chart supports only the single node reindexing service. Feel free to run it manually if you prefer to use reindexing service with the horizontal scalability support..

To deploy Alfresco with Elasticsearch Connector you can use the command below:

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
--timeout 10m0s \
--namespace=alfresco
```

If you are using *Docker Desktop* locally, you have to set `antiAffinity` to `soft` and it is recommended to reduce Elasticsearch resources:

```
elasticsearch:
  enabled: true
  antiAffinity: "soft"

  # Shrink default JVM heap.
  esJavaOpts: "-Xmx128m -Xms128m"

  # Allocate smaller chunks of memory per pod.
  resources:
    requests:
      cpu: "100m"
      memory: "512M"
    limits:
      cpu: "1000m"
      memory: "512M"

  # Request smaller persistent volumes.
  volumeClaimTemplate:
    accessModes: [ "ReadWriteOnce" ]
    storageClassName: "hostpath"
    resources:
      requests:
        storage: 100M
```

When the system is up and running, you can access to the Kibana console using port forward:

```bash
kubectl port-forward service/acs-kibana 5601:5601 -n alfresco
```

and then visiting http://localhost:5601/app/kibana#.

If you need to access to Elasticsearch directly you have to perform the same operation:

```bash
kubectl port-forward service/elasticsearch-master 9200:9200 -n alfresco
```

and then visiting http://localhost:9200/.

Properties that can be used to configure the chart are available [here](../../../helm/alfresco-content-services/charts/alfresco-elasticsearch-connector/README.md).
