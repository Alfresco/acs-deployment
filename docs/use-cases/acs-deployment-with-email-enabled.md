# Alfresco Content Services Deployment with Inbound & Outbound SMTP configuration

This documentation demonstrates how to enable Inbound and Outbound email when installing ACS Helm chart.

## Deploy ACS Helm chart with email server enabled

Currently, the ingress-nginx does not support tcp/udp services due to kubernetes limitations and the workaround is to expose the TCP (for example smtp(s), imap(s)) to be accessible from outside over internet, a kubernetes Service LoadBalancer is required.  This means inbound email need to be sent using this Service LoadBalancer address which is serving tcp traffic.  This may means there is an overhead of an extra L4 LoadBalancer cost.  This is purely due to current limitations on Kubernetes for TCP/UDP services and not related to ACS helm setup.

So, for example if your ACS Helm chart is enabled with Inbound/Outbound email in domain `*.example.com`, then the service endpoints would be:
- `myacs.example.com` - For general Alfresco, Share and Digital Workspace endpoints
- `smtps-myacs.example.com` - For sending emails to ACS smtp(s) server (for example port: 1125 (smtps), 1144(imaps))

It is recommended to enable TLS while configuring SMTP(s) and IMAP(s) configuration.  If TLS is enabled for inbound email, then the helm chart expects the TLS certificate as a Secret before installing the chart.  This secret name is passed on as a parameter with helm chart installation to be used for inbound email with TLS and repository will create keystore and truststore accordingly from the provided SSL certificates.

For example, if your ACS email server name is `smtps-myacs.example.com` and your SSL certificates (self signed or signed) are as below:
```
cert.pem
fullchain.pem
privkey.pem
```
then, the command to create a kubernetes secret in the namespace where ACS will be installed would be:
```
kubectl create secret tls your-cert-secret --key privkey.pem --cert fullchain.pem --namespace=$DESIREDNAMESPACE
```

Refer to [Deploying Alfresco Content Services](../helm-deployment-aws_kops.md#deploying-alfresco-content-services) for  the full `helm install` reference.  The example below enables the email service with TLS enabled by passing the related [configuration options]((../../helm/README.md#configuration)).

```bash
helm install alfresco-incubator/alfresco-content-services \
--name my-acs \
--set externalProtocol="https" \
--set externalHost="$CLUSTER_NAME" \
--set externalPort="443" \
--set global.alfrescoRegistryPullSecrets=quay-registry-secret \
...
...
--set mail.host="smtp.gmail.com" \
--set mail.from.default="some.user@gmail.com" \
--set mail.username="some.user@gmail.com" \
--set mail.password="somepassword" \
--set mail.protocol=smtps \
--set mail.smtp.auth=true \
--set mail.smtps.auth=true \
...
...
--set email.server.enabled=true \
--set email.server.auth.enabled=true \
--set email.server.enableTLS=true \
--set email.server.domain=smtps-myacs.example.com \
--set email.inbound.unknownUser="some.user@gmail.com" \
--set email.ssl.secretName=your-cert-secret \
...
...
--set imap.server.enabled=true \
--set imap.server.imap.enabled=true \
--set imap.server.imaps.enabled=true \
...
...
--namespace=$DESIREDNAMESPACE
```
NOTE: If you are using (for example Gmail or Yahoo) as the outbound email server, your application's attempts to send outgoing emails may be blocked by the email providers due to their security policies as if it considers the authentication attempts to be suspicious. When this happens, you will receive a security alert at the corresponding email address. To proceed, you will need to manually confirm the validity of the authentication attempt before the email provider will permit the application to send outbound emails. For more information on [Less secure apps & your Google Account](https://support.google.com/accounts/answer/6010255).

# Exposing email service
Ingress-nginx currently does not support TCP or UDP services.  The helm chart will expose SMTP service as a LoadBalancer (it creates a new AWS ELB).  This LoadBalancer/ELB information can be obtained as:

```bash
$ kubectl get services `kubectl get services --namespace=$DESIREDNAMESPACE | grep email | awk '{print $1}'` --namespace=$DESIREDNAMESPACE
NAME                          TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)          AGE
alert-fly-alfresco-cs-email   LoadBalancer   100.XX.33.188   a1dXXXXXab11eaac6702XXXf87b-XXXXXXXXXX.eu-west-1.elb.amazonaws.com   1125:30554/TCP   2d
```

# Test email service
A friendly dns name can be created with the above AWS ELB (from EXTERNAL_IP), so for example the ELB's friendly name can be `smtps-myacs.example.com`.  Telnet can be used to test communication:

```
$ telnet smtps-myacs.example.com 1125
Trying 34.249.150.165...
Connected to smtps-myacs.example.com.
Escape character is '^]'.
220 smtps-myacs.example.com ESMTP SubEthaSMTP 3.1.7
```

# References
* [Alfresco Configuring email](https://docs.alfresco.com/6.2/concepts/email.html)
* [Kubernetes Ingress-nginx Exposing TCP and UDP services](https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/exposing-tcp-udp-services.md#exposing-tcp-and-udp-services)
