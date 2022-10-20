# Enable Alfresco Search Services External Access

This example demonstrates how to enable Alfresco Search Services (`/solr`) for external access which is disabled by default.

## Prepare Data

1. Obtain the list of IP addresses you want to allow access to `/solr`
2. Format the IP addresses as a comma separated list of CIDR blocks i.e. "192.168.0.0/16,10.0.0.0/16", to allow access to everyone use "0.0.0.0/0"
3. Generate a `base64` encoded `htpasswd` formatted string using the following command, where "solradmin" is username and "somepassword" is the password:

    ```bash
    echo -n "$(htpasswd -nbm solradmin somepassword)" | base64 | tr -d '\n'
    ```

## Install ACS Helm Chart With Search External Access

Follow the [EKS deployment](../eks-deployment.md) guide up until the [ACS](../eks-deployment.md#acs) section, once the docker registry secret is installed return to this page.

Deploy the latest version of ACS Enterprise by running the command below (replacing `YOUR-DOMAIN-NAME` with the hosted zone you created previously and replacing `YOUR-BASIC-AUTH` and `YOUR-IPS` with the encoded basic authentication string and list of whitelisted IP addresses you prepared in the previous section).

```bash
helm install acs alfresco/alfresco-content-services \
--set externalPort="443" \
--set externalProtocol="https" \
--set externalHost="acs.YOUR-DOMAIN-NAME" \
--set persistence.enabled=true \
--set persistence.storageClass.enabled=true \
--set persistence.storageClass.name="nfs-client" \
--set global.alfrescoRegistryPullSecrets=quay-registry-secret \
--set alfresco-search.ingress.enabled=true \
--set alfresco-search.ingress.basicAuth="YOUR-BASIC-AUTH" \
--set alfresco-search.ingress.whitelist_ips="YOUR_IPS" \
--atomic \
--timeout 10m0s \
--namespace=alfresco
```

## Upgrade ACS Helm Chart With Search External Access

If you've previously deployed ACS where external search access was disabled (the default) you can run the following `helm upgrade` command to enable external access for `/solr` (replacing `YOUR-BASIC-AUTH` and `YOUR-IPS` with the encoded basic authentication string and list of whitelisted IP addresses you prepared in the "Prepare Data" section):

```bash
helm upgrade acs alfreso/alfresco-content-services \
--set alfresco-search.ingress.enabled=true \
--set alfresco-search.ingress.basicAuth="YOUR-BASIC-AUTH" \
--set alfresco-search.ingress.whitelist_ips="YOUR_IPS" \
```

**Note:** There are known issues when upgrading a Helm chart relating to Helm cache.

- `https://github.com/kubernetes/helm/issues/3275`
- `https://github.com/kubernetes/helm/issues/1193`
- `https://github.com/kubernetes/helm/pull/4146`

If your `helm upgrade` fails due to any of these example errors:

```bash
Error: UPGRADE FAILED: no Secret with the name "nosy-tapir-alfresco-search-solr" found
(or)
Error: UPGRADE FAILED: no Ingress with the name "nosy-tapir-alfresco-search-solr" found
```

Then, simply delete that resource.  Below is an example:

```bash
kubectl delete secret nosy-tapir-alfresco-search-solr --namespace=alfresco
(or)
kubectl delete ingress nosy-tapir-alfresco-search-solr --namespace=alfresco
```

And re-try above Upgrade ACS Helm Chart steps which will also re-create the above deleted resource.
