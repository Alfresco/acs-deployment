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
