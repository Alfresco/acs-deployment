# Deploy Alfresco Content Services with the ability to manage licenses

Alfresco content repository Docker images come with an embedded license which last only 2 days. If you've built a custom image, it may have a one year license but in order to change it you would need to build a new image.
You can configure the ACS Helm chart so the license is instead read from a kubernetes secret so that when it's time to renew the license the only thing you need to do is to update that secret as needed.

This relies on 2 steps:
* creating a secret to hold the license
* configuring the chart to use that secret

## Create a kubernetes secret to store the license

Make sure your license available is readable and you have appropriate kubernetes access in order to create a secret in the ACS namespace where you want to deploy the helm release.

```bash
ACS_NAMESPACE=acs
LIC64=$(base64 < ~/Downloads/Alfresco-ent72-foobar.lic)
cat <<EOF | kubectl -n $ACS_NAMESPACE apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: acslicense
type: Opaque
data:
  alfresco.lic: $LIC64
EOF
```

## Configure the chart to leverage that secret.

In the chart value file add the following:

```yaml
repository:
  licenseSecret: acslicense
```

> You can obtain a license file for your Alfresco enterprise subscription from the [Hyland Community portal](https://community.hyland.com/)

## Applying a new license.

Before your license expires you will want to apply a new one. It's actually very easy do to so. All you need to do is overwrite the secret you created on previous deployment.
You can use the exact same command just replacing the license file with the new one.

> Secret update will trigger pods update. The default update strategy with repository pods is set to `Recreate`.
> As a consequence updating the license will trigger a downtime. You might want to switch the repository deployment to a smoother update strategy by removing `Recreate` setting.
> See [our main chart doc](/helm/alfresco-content-services/README.md) for details on `RollingUpdate` strategy.
