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

And a **Kubernetes job** will be started in order to reindex existing contents in Elasticsearch. 
We suggest running this job only at the first startup. You can enable or disable it setting the `alfresco-elasticsearch-connector.reindexing.enabled` property to `true` or `false`.
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

Please add lines above to _esc_values.yaml_ file.

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

## Configuration

Properties that can be used to configure the chart are available [here](../../../helm/alfresco-content-services/charts/alfresco-elasticsearch-connector/README.md).

Additional properties for the services can be set using environment variables as below:
```
alfresco-elasticsearch-connector:
  enabled: true
  liveIndexing:
    environment:
      ALFRESCO_EVENT_RETRY_DELAY:20
  reindexing:
    enabled: true
    environment:
      ALFRESCO_REINDEX_JOBNAME:reindexByIds
      ALFRESCO_REINDEX_FROMID:100
      ALFRESCO_REINDEX_TOID:200
```
The example above increase the live indexing retry delay to 20 seconds and indexes all documents from id 100 to 200.

Please check Alfresco Elasticsearch Connector documentation for a full list of available properties.

## Known issues

* When starting the Helm chart with multiple instances for Repository service you can have a trial license creation concurrency conflicts. In the log you will have an error similar to:

  ```
  DEBUG [org.alfresco.enterprise.license.LicenseComponent] [main] Alfresco license: Failed due to de.schlichtherle.license.NoLicenseInstalledException: There is no license certificate installed for Enterprise - v7.1.
  ```
  
  To solve this issue just restart the failed node, then he will read the licence correctly.
* Search API can return an HTTP error 500 when the system is just started. This happens because at every startup the system checks the index configuration and can load any new configuration. To solve this issue, just wait few seconds until you see the log below:
  ```
  INFO  [elasticsearch.contentmodelsync.ContentModelSynchronizer] [elasticsearch-initializer] Successfully loaded analysers.
  INFO  [elasticsearch.contentmodelsync.ElasticsearchInitialiser] [elasticsearch-initializer] Successfully connected to Elasticsearch index
  ```





