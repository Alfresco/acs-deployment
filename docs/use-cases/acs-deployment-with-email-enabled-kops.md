# Alfresco Content Services Deployment with Inbound & Outbound SMTP configuration

This documentation demonstrates how to enable Inbound and Outbound email when installing ACS Helm chart.

Below is an example set up in the US-East-1 (N.Virginia) region.

## Create Kubernetes cluster with Kops

Follow the steps outlined in [Setting up a Kubernetes cluster on AWS with Kops](../helm-deployment-aws_kops.md#setting-up-kubernetes-cluster-on-aws-with-kops).

Once the Kubernetes cluster is up and running with an nginx-ingress controller, an S3 bucket is required for ACS Deployment with the S3 Connector module.

## Deploy ACS Helm chart with email server enabled

Refer to [Deploying Alfresco Content Services](../helm-deployment-aws_kops.md#deploying-alfresco-content-services) for  the full `helm install` reference.  The example below enables the email service by passing the related [configuration options]((../../helm/README.md#configuration)).

```bash
helm install alfresco-incubator/alfresco-content-services \
--version 1.1.3 \
--name my-acs \
--set externalProtocol="https" \
--set externalHost="$CLUSTER_NAME" \
--set externalPort="443" \
--set global.alfrescoRegistryPullSecrets=quay-registry-secret \
...
...
--set email.server.enabled=true \
--set email.inbound.unknownUser="some.user@gmail.com" \
--set mail.host="smtp.gmail.com" \
--set mail.from.default="some.user@gmail.com" \
--set mail.username="some.user@gmail.com" \
--set mail.password="somepassword" \
--set mail.protocol=smtp \
--set mail.smtp.auth=true \
--set imap.server.enabled=true \
--namespace=$DESIREDNAMESPACE
```

# Exposing email service
Ingress-nginx currently does not support TCP or UDP services.  The helm chart will expose SMTP service as a LoadBalancer (it creates a new AWS ELB).  This LoadBalancer/ELB information can be obtained as:

```bash
$ kubectl get services `kubectl get services --namespace=$DESIREDNAMESPACE | grep email | awk '{print $1}'` --namespace=$DESIREDNAMESPACE
NAME                          TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)          AGE
alert-fly-alfresco-cs-email   LoadBalancer   100.XX.33.188   a1dXXXXXab11eaac6702XXXf87b-XXXXXXXXXX.eu-west-1.elb.amazonaws.com   1125:30554/TCP   2d
```

# References
* [Alfresco Configuring email](https://docs.alfresco.com/6.2/concepts/email.html)
* [Kubernetes Ingress-nginx Exposing TCP and UDP services](https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/exposing-tcp-udp-services.md#exposing-tcp-and-udp-services)
