# Enable Alfresco Search Services External Access

This example demonstrates how to enable Alfresco Search Services (`/solr`) for external access which is disabled by default.

## Prerequisites

## Install ACS Helm Chart With Search External Access

Follow the [EKS deployment](../eks-deployment.md) guide up until the [ACS](../eks-deployment.md#acs) section, once the docker registry secret is installed return to this page.

When we bring all this together we can deploy ACS using the command below (replacing all the `YOUR-XZY` properties with the values gathered during the setup of the services):

# Example: `echo -n "$(htpasswd -nbm admin admin)" | base64` # i.e. admin / admin



```bash
helm install acs alfresco-incubator/alfresco-content-services \
--set externalPort="443" \
--set externalProtocol="https" \
--set externalHost="acs.YOUR-DOMAIN-NAME" \
--set persistence.enabled=true \
--set persistence.storageClass.enabled=true \
--set persistence.storageClass.name="nfs-client" \
--set global.alfrescoRegistryPullSecrets=quay-registry-secret \
--set repository.image.repository="quay.io/alfresco/alfresco-content-repository-aws" \
--set alfresco-search.ingress.enabled=true \
--set alfresco-search.ingress.basicAuth="YWRtaW46JGFwcjEkVVJqb29uS00kSEMuS1EwVkRScFpwSHB2a3JwTDd1Lg==" \
--set alfresco-search.ingress.whitelist_ips="0.0.0.0/0" \
--atomic \
--timeout 10m0s \
--namespace=alfresco
```

## Upgrade ACS Helm Chart With Search External Access

If you've previously deployed ACS
Below is the snippet for upgrading ACS with Search external access (where it was previously disabled).

```bash
helm upgrade acs alfresco-incubator/alfresco-content-services \
--set alfresco-search.ingress.enabled=true \
--set alfresco-search.ingress.basicAuth="YWRtaW46JGFwcjEkVVJqb29uS00kSEMuS1EwVkRScFpwSHB2a3JwTDd1Lg==" \
--set alfresco-search.ingress.whitelist_ips="0.0.0.0/0" \
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
