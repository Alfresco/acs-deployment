---
title: OpenSearch IAM Auth
parent: Examples
grand_parent: Helm
---

# Authenticating to Amazon OpenSearch with AWS IAM (SigV4)

- [Authenticating to Amazon OpenSearch with AWS IAM (SigV4)](#authenticating-to-amazon-opensearch-with-aws-iam-sigv4)
  - [Overview](#overview)
  - [AWS prerequisites](#aws-prerequisites)
  - [Helm values](#helm-values)
  - [Notes](#notes)
  - [Verification](#verification)

## Overview

When ACS uses an external
[Amazon OpenSearch](with-aws-services.md#amazon-opensearch) domain, the default
approach is to authenticate with a master username and password (HTTP Basic
auth) stored in a Kubernetes secret. This page describes the alternative:
authenticating the ACS workloads to the domain with **AWS IAM (SigV4)** instead,
so requests are signed with credentials obtained from an IAM role rather than a
static username and password.

With IAM auth:

- No search username or password is stored in the cluster.
- Access to the domain is governed by an IAM policy attached to a dedicated role.
- Each ACS component that talks to OpenSearch runs under a Kubernetes service
  account bound to that role, and signs its requests with SigV4.

This applies to an **external AWS OpenSearch** domain only, using
`flavor: elasticsearch` and `securecomms: https`. It does not apply to the
embedded Elasticsearch cluster or to Solr.

> This page covers only what the helm charts need. How you provision the EKS
> cluster, the OpenSearch domain and the IAM role is up to you. If you deploy
> with the internal `terraform-alfresco-pipeline`, set
> `ACS_EXTERNAL_ELASTICSEARCH_IAM_AUTH=true` and it wires up everything described
> below automatically.

## AWS prerequisites

Before deploying, make sure the following are in place on the AWS side:

1. **OpenSearch domain without a master user for data-plane access.** Fine-grained
   access control with an internal user database expects a master
   username/password, which IAM auth does not use. Configure the domain so that
   data-plane requests are authorized by IAM — typically by disabling fine-grained
   access control / the internal user database, or otherwise not requiring a
   master user.

2. **A domain access policy that allows the IAM role.** Grant the dedicated role
   `es:ESHttp*` on the domain, for example:

   ```json
   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Effect": "Allow",
         "Principal": { "AWS": "arn:aws:iam::<account-id>:role/<opensearch-role>" },
         "Action": "es:ESHttp*",
         "Resource": "arn:aws:es:<region>:<account-id>:domain/<domain-name>/*"
       }
     ]
   }
   ```

3. **An IAM role your pods can assume.** Create a role that ACS pods can use
   through
   [IAM Roles for Service Accounts (IRSA)](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html)
   or [EKS Pod Identity](https://docs.aws.amazon.com/eks/latest/userguide/pod-identities.html).
   The role's trust policy must allow the three ACS service accounts used below,
   in the namespace where you install the chart:

   - `alfresco-repo-sa`
   - `alfresco-search-enterprise-sa`
   - `alfresco-audit-storage-sa` (only if Alfresco Audit Storage is enabled)

   The service account **names must match** both the role's trust policy subjects
   and the `serviceAccount.name` values in the helm values below, otherwise the
   pods will not receive the role credentials.

4. **Network access** from the pods to the domain endpoint over `443/tcp`.

## Helm values

Enable IAM auth by setting the external OpenSearch URL **without** a username or
password, annotating each component's service account with the IAM role ARN, and
telling the components to sign requests with SigV4.

Replace `YOUR-DOMAIN-HOSTNAME`, `YOUR-AWS-REGION` and the role ARN with your own
values.

```yaml
global:
  search:
    url: https://YOUR-DOMAIN-HOSTNAME/
    # username and password are intentionally omitted: IAM auth is used instead
  auditIndex:
    # only required when Alfresco Audit Storage is enabled
    url: https://YOUR-DOMAIN-HOSTNAME/

alfresco-repository:
  configuration:
    search:
      flavor: elasticsearch
      securecomms: https
      elasticsearchProperties:
        auth.mode: aws-iam
        aws.region: YOUR-AWS-REGION
        aws.service: es
  serviceAccount:
    create: true
    name: alfresco-repo-sa
    annotations:
      eks.amazonaws.com/role-arn: arn:aws:iam::<account-id>:role/<opensearch-role>

alfresco-search-enterprise:
  enabled: true
  serviceAccount:
    create: true
    name: alfresco-search-enterprise-sa
    annotations:
      eks.amazonaws.com/role-arn: arn:aws:iam::<account-id>:role/<opensearch-role>
  liveIndexing:
    environment:
      SPRING_ELASTICSEARCH_AUTH_MODE: aws-iam
      SPRING_ELASTICSEARCH_AWS_REGION: YOUR-AWS-REGION
      SPRING_ELASTICSEARCH_AWS_SERVICE: es
  reindexing:
    environment:
      SPRING_ELASTICSEARCH_AUTH_MODE: aws-iam
      SPRING_ELASTICSEARCH_AWS_REGION: YOUR-AWS-REGION
      SPRING_ELASTICSEARCH_AWS_SERVICE: es

# only required when Alfresco Audit Storage is enabled
alfresco-audit-storage:
  serviceAccount:
    create: true
    name: alfresco-audit-storage-sa
    annotations:
      eks.amazonaws.com/role-arn: arn:aws:iam::<account-id>:role/<opensearch-role>

elasticsearch:
  enabled: false
```

The `elasticsearchProperties` entries render as
`-Delasticsearch.auth.mode=aws-iam`, `-Delasticsearch.aws.region=...` and
`-Delasticsearch.aws.service=es` Java system properties on the repository, which
is how the repository is told to sign OpenSearch requests with SigV4.

## Notes

- **Do not set** `global.search.username` / `password` (nor the `auditIndex`
  equivalents). Leaving them unset is what selects IAM auth; the chart still
  creates the search secret with empty credentials, which the connector ignores
  in `aws-iam` mode.
- The search-enterprise **mediation** component does not talk to OpenSearch, so it
  does not need the role; only the live-indexing deployment and the reindexing job
  run under the annotated service account.
- **Alfresco Audit Storage** has no explicit auth-mode setting: with no username
  or password and an IRSA-annotated service account, it obtains credentials from
  the default AWS credential chain (the projected web-identity token) and signs
  its requests automatically.

## Verification

1. Confirm the pods received the role. On the repository, search-enterprise and
   (if enabled) audit-storage pods, the AWS web-identity environment variables
   should be present:

   ```bash
   kubectl -n <namespace> exec deploy/<acs-repository> -- \
     printenv AWS_ROLE_ARN AWS_WEB_IDENTITY_TOKEN_FILE
   ```

2. Check the repository `create-index-template` init container completed
   successfully (it performs an authenticated call to OpenSearch at startup):

   ```bash
   kubectl -n <namespace> logs <acs-repository-pod> -c create-index-template
   ```

3. Confirm live indexing is writing to the domain — the `alfresco` and
   `alfresco-archive` indices should appear and grow as content is added:

   ```bash
   GET https://YOUR-DOMAIN-HOSTNAME/_cat/indices/alfresco*?v
   ```

4. Check the repository and search-enterprise logs for authentication or
   authorization errors against OpenSearch; there should be none.
