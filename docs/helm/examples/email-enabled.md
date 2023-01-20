# Alfresco Content Services Deployment with Inbound & Outbound SMTP Configuration

This example demonstrates how to enable Inbound and Outbound email when installing the ACS Helm chart.

## Prerequisites

Follow the [EKS deployment](../eks-deployment.md) guide up until the [ACS](../eks-deployment.md#acs) section, once the docker registry secret is installed return to this page.

## Deploy ACS Helm Chart With Email Server Enabled

Currently, the ingress-nginx does not support tcp/udp services due to kubernetes limitations and the workaround is to expose the TCP (for example smtp(s), imap(s)) to be accessible from outside over internet, a kubernetes Service LoadBalancer is required.  This means inbound email need to be sent using this Service LoadBalancer address which is serving tcp traffic.  This may means there is an overhead of an extra L4 LoadBalancer cost.  This is purely due to current limitations on Kubernetes for TCP/UDP services and not related to ACS helm setup.

So, for example if your ACS Helm chart is enabled with Inbound/Outbound email in domain `*.example.com`, then the service endpoints would be:

- `myacs.example.com` - For general Alfresco, Share and Digital Workspace endpoints
- `smtps-myacs.example.com` - For sending emails to ACS smtp(s) server (for example port: 1125 (smtps), 1144(imaps))

It is recommended to enable TLS while configuring SMTP(s) and IMAP(s) configuration.  If TLS is enabled for inbound email, then the helm chart expects the TLS certificate as a Secret before installing the chart.  This secret name is passed on as a parameter with helm chart installation to be used for inbound email with TLS and repository will create keystore and truststore accordingly from the provided SSL certificates.

For example, if your ACS email server name is `smtps-myacs.example.com` and your SSL certificates (self signed or signed) are `cert.pem`, `fullchain.pem` and `privkey.pem` run the following command to create a kubernetes TLS secret:

```bash
kubectl create secret tls your-cert-secret --key privkey.pem --cert fullchain.pem --namespace=alfresco
```

Deploy the latest version of ACS Enterprise by running the command below (replacing `YOUR-DOMAIN-NAME` with the hosted zone you created and replacing the email values appropriately). For the full list of available options please refer to the table of [configuration options](../../../helm/README.md#configuration).

```bash
helm install acs alfresco/alfresco-content-services \
  --set externalPort="443" \
  --set externalProtocol="https" \
  --set externalHost="acs.YOUR-DOMAIN-NAME" \
  --set repository.persistence.enabled=true \
  --set repository.persistence.storageClass="nfs-client" \
  --set filestore.persistence.enabled=true \
  --set filestore.persistence.storageClass="nfs-client" \
  --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
  --set global.tracking.sharedsecret=$(openssl rand -hex 24) \
  --set mail.host="smtp.gmail.com" \
  --set mail.from.default="some.user@gmail.com" \
  --set mail.username="some.user@gmail.com" \
  --set mail.password="somepassword" \
  --set mail.protocol=smtps \
  --set mail.smtp.auth=true \
  --set mail.smtps.auth=true \
  --set email.server.enabled=true \
  --set email.server.auth.enabled=true \
  --set email.server.enableTLS=true \
  --set email.server.domain=smtps-myacs.example.com \
  --set email.inbound.unknownUser="some.user@gmail.com" \
  --set email.ssl.secretName=your-cert-secret \
  --set imap.server.enabled=true \
  --set imap.server.imap.enabled=true \
  --set imap.server.imaps.enabled=true \
  --atomic \
  --timeout 10m0s \
  --namespace=alfresco
```

> NOTE: If you are using GMail or Yahoo as the outbound email server, your application's attempts to send outgoing emails may be blocked by the email providers due to their security policies as if it considers the authentication attempts to be suspicious. When this happens, you will receive a security alert at the corresponding email address. To proceed, you will need to manually confirm the validity of the authentication attempt before the email provider will permit the application to send outbound emails. For more information on [Less secure apps & your Google Account](https://support.google.com/accounts/answer/6010255).

## Exposing Email Service

Ingress-nginx currently does not support TCP or UDP services.  The helm chart will expose SMTP service as a LoadBalancer (it creates a new AWS ELB).  This LoadBalancer/ELB information can be obtained by running the following command:

```bash
kubectl get services `kubectl get services --namespace=alfresco | grep email | awk '{print $1}'` --namespace=alfresco
```

This will produce an output similar to the one below, the ELB DNS name can be found in the "EXTERNAL-IP" column.

```bash
NAME                          TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)          AGE
alert-fly-alfresco-cs-email   LoadBalancer   100.XX.33.188   a1dXXXXXab11eaac6702XXXf87b-XXXXXXXXXX.eu-west-1.elb.amazonaws.com   1125:30554/TCP   2d
```

## Test Email Service

1. Use Route53 to register a more friendly name for the ELB DNS name retrieved in the previous section, for example `smtps-myacs.example.com`.

2. Test the communication using Telnet:

    ```bash
    $ telnet smtps-myacs.example.com 1125
    Trying 34.249.150.165...
    Connected to smtps-myacs.example.com.
    Escape character is '^]'.
    220 smtps-myacs.example.com ESMTP SubEthaSMTP 3.1.7
    ```

## References

- [Alfresco Configuring email](https://docs.alfresco.com/content-services/latest/admin/)
- [Kubernetes Ingress-nginx Exposing TCP and UDP services](https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/exposing-tcp-udp-services.md#exposing-tcp-and-udp-services)
