# Alfresco Content Services Helm Deployment with external Hazelcast cluster

- [Alfresco Content Services Helm Deployment with external Hazelcast cluster](#alfresco-content-services-helm-deployment-with-external-hazelcast-cluster)
  - [Prerequisites](#prerequisites)
  - [Step by step guide](#step-by-step-guide)

## Prerequisites

- Having installed either of:
  - [Rancher for Desktop](https://rancherdesktop.io/). Includes kubectl and Helm, ready to use right after installation.
  - [Docker for Desktop](https://docs.docker.com/desktop/). Requires separate install of kubectl and Helm.

## Step by step guide

1. Deploy alfresco-content-services. See [desktop deployment](../desktop-deployment.md) section. Remember to stick to one namespace in next steps.

2. Prepare a valid Hazelcast xml configuration.
    - Locate the `caches.properties` file within the alfresco.`war:WEB-INF\lib\alfresco-repository-*.jar` archive. Or use this one [caches.properties](https://github.com/Alfresco/alfresco-community-repo/blob/master/repository/src/main/resources/alfresco/caches.properties)
    - Clone [alfresco-community-repo](https://github.com/Alfresco/alfresco-community-repo) and generate .xml file using script from newly cloned repository and `caches.properties` file located before

    ```bash
    python repository/scripts/hazelcast-init generate-hazelcast-config.py -s </path/to/caches.properties>
    ```

    - You should now have configuration file under `repository/scripts/hazelcast-init/alfresco-hazelcast-config.xml`

3. Replace the `<cluster-name>` within the `alfresco-hazelcast-config.xml`file with a secure value that is hard to guess. For all intents and purposes this field  should be treated as a password, as if matching it allows client-server / member-member connection.

4. Add appropriate configation for kubernetes autodiscovery feature and [rest api groups](https://docs.hazelcast.com/hazelcast/5.3/maintain-cluster/rest-api#using-rest-endpoint-groups) depending on your choise.

    ```xml
    <network>
        <join>
            <kubernetes enabled="true">
                <namespace>default</namespace>
                <service-name>hazelcast</service-name>
            </kubernetes>
        </join>
        <rest-api enabled="true">
            <endpoint-group name="CLUSTER_READ" enabled="true"/>
            <endpoint-group name="CLUSTER_WRITE" enabled="true"/>
            <endpoint-group name="HEALTH_CHECK" enabled="true"/>
            <endpoint-group name="HOT_RESTART" enabled="true"/>
            <endpoint-group name="WAN" enabled="true"/>
            <endpoint-group name="DATA" enabled="true"/>
        </rest-api>
    </network>
    <jet enabled="true">
    </jet>
    ```

5. Managment center in this feature is disabled by default but you still have to accordingly change the values in xml.

    ```xml
    <management-center data-access-enabled="false">
        <trusted-interfaces>
            <interface>http://hazelcast-mancenter</interface>
        </trusted-interfaces>
    </management-center>
    ```

6. Now preparation of the xml configuration is finished. Next step is to create configmap manifest. Add below section to newly created file:

    ```yaml
    apiVersion: v1
    kind: ConfigMap
    metadata:
    name: manual-hazelcast-configuration
    labels:
      app.kubernetes.io/name: hazelcast
    data:
    hazelcast.xml: |
    ```

    Now copy generated xml configuration into manifest file. (Remember to corectly indent copied text)

7. Deploy created manifest

    ```bash
    kubectl apply -f configmap-hazelcast.yaml 
    ```

8. Deploy hazelcast with values presented below

    ```yaml
    hazelcast:
      javaOpts: -Dhazelcast.config=/data/hazelcast/hazelcast.xml
      existingConfigMap: manual-hazelcast-configuration
    mancenter:
      enabled: true
    ```

    ```bash
    helm install hazelcast hazelcast/hazelcast -f hazelcast.yaml
    ```

9. Now change the config of alfresco-repository by adding another values file. In below file specify properties that will make repository use external hazelcast cluster deployed in previous step. Remember to accordingly change the values if needed.

    ```yaml
    alfresco-repository:
    replicaCount: 3
    config:
    repository:
      additionalGlobalProperties: 
      alfresco.hazelcast.embedded: false
      alfresco.hazelcast.client.address: hazelcast:5701
      alfresco.cluster.name: test
    ```

    ```bash
    helm upgrade acs helm/alfresco-content-services \    
    --values local-dev-values.yaml \
    --set global.search.sharedSecret=$(openssl rand -hex 24) \
    --atomic \
    --timeout 10m0s \
    --values acs-hazelcast.yaml
    ```
