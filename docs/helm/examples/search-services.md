---
title: Search Services
parent: Examples
grand_parent: Helm
---

# Dealing with Search service deployment

Solr has some internal behavior that make it a not so great fit for orchestrated
container based environments. Some are mentioned bellow:

- Solr performs better on block storage with good I/O and those usually involve
  some stickiness to worker nodes. While this is not impossible to setup in
  Kubernetes it is however not very convenient and reduces the benefit of using
  workload scheduler.
- Solr is known to be quite resource greedy, in particular in terms of memory
  allocation. That has a direct impact on Kubernetes worker nodes sizing.
- It uses some filesystem based locking mechanisms which  do not play well with
  workload scheduling or the ephemeral nature of containers in general.

For that reason we recommend for production environments to install Search
services alongside the Kubernetes cluster and configure the Helm charts to not
deploy it and instead point the repository to the external one.

## Configuring Helm chart

Below we explain how to configure the Helm chart to point the repository to a
Solr instance outside of the kubernetes cluster.

Installing Solr instance(s) is out of the scope of this document, but it can be
done following the [Search service
documentation](https://docs.alfresco.com/insight-engine/latest/install/options/#install-without-mutual-tls---http-with-secret-word-zip),
or by using the Ansible playbook (replication setup require an additional
load-balancer), as explained
[here](https://github.com/Alfresco/alfresco-ansible-deployment/blob/master/docs/search-services-deployment-guide.md).

On the chart side you need to:

- Tell the Helm to not create the Solr deployment
- Give Helm the shared secret to use when contacting Solr.
- Provide details so the repository can be configured properly

  ```yaml
  global:
    search:
      url: http://internal-load-balancer-ac3a091cb.eu-west-1.elb.amazonaws.com/solr
      flavor: solr6
      securecomms: secret
      sharedSecret: d0ntT3llAny0n3
  alfresco-search:
    enabled: false
  ```

In this example an internal load balancer is created and aims a target group
composed of the slaves Solr nodes deployed on EC2 instances. All these resources
should be deployed within the Kubernetes cluster's VPC, so the traffic remains
internal.

## Enable Alfresco Search Services External Access

This example demonstrates how to enable Alfresco Search Services (`/solr`) for
external access which is disabled by default. You must also manually forge the
security header to access the Solr API externally. This workaround is clunky and
not recommended for production use.

### Prepare Data

1. Obtain the list of IP addresses you want to allow access to `/solr`
2. Format the IP addresses as a comma separated list of CIDR blocks i.e.
   "192.168.0.0/16,10.0.0.0/16", to allow access to everyone use "0.0.0.0/0"
3. Generate a `base64` encoded `htpasswd` formatted string using the following
   command, where "solradmin" is username and "somepassword" is the password:

    ```bash
    echo -n "$(htpasswd -nbm solradmin somepassword)" | base64 | tr -d '\n'
    ```

### Install ACS Helm Chart With Search External Access

Follow the [EKS deployment](../eks-deployment.md) guide up until the
[ACS](../eks-deployment.md#development-version-of-charts) section, once the docker registry secret is
installed come back here.

Deploy the latest version of ACS Enterprise by running the command below
(replacing `YOUR-DOMAIN-NAME` with the hosted zone you created previously and
replacing `YOUR-BASIC-AUTH` and `YOUR-IPS` with the encoded basic
authentication string and list of whitelisted IP addresses you prepared in the
previous section).

```bash
helm install acs alfresco/alfresco-content-services \
  --set alfresco-repository.persistence.enabled=true \
  --set alfresco-repository.persistence.storageClass.enabled=true \
  --set alfresco-repository.persistence.storageClass.name="nfs-client" \
  --set global.known_urls=https://acs.YOUR-DOMAIN-NAME \
  --set global.search.securecomms=none \
  --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
  --set alfresco-search.ingress.enabled=true \
  --set alfresco-search.ingress.annotations.nginx\.ingress.kubernetes\.io/whitelist-source-range=10.0.0.0/8 \
  --set alfresco-search.ingress.basicAuth="YOUR-BASIC-AUTH" \
  --atomic \
  --timeout 10m0s \
  --namespace=alfresco
```
