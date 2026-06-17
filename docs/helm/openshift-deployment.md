---
title: OpenShift
parent: Deployment
grand_parent: Helm
---

# Alfresco Content Services Helm Deployment on OpenShift

This page describes how to deploy Alfresco Content Services (ACS) Community
using [Helm](https://helm.sh) on [OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift).

## How OpenShift differs from vanilla Kubernetes

OpenShift enforces a **restricted Security Context Constraint (SCC)** by
default. The key behaviours that affect ACS are:

- **Arbitrary UID assignment** — OpenShift overrides the container UID at
  runtime with a value from a per-namespace range (e.g. `1000650000`). Any
  image that requires a specific UID will fail.
- **GID 0 membership** — regardless of the assigned UID, every container is
  always a member of the root group (GID 0). Files that must be written at
  runtime must be group-writable by GID 0.
- **No `runAsUser` in pod specs** — specifying a fixed `runAsUser` in the pod
  security context conflicts with the SCC and the pod will be rejected.

The `alfresco-common` library chart used by all ACS sub-charts sets
`runAsUser: 33099` and `fsGroupChangePolicy: OnRootMismatch` by default.
These must be overridden for OpenShift.

## Deploying on OpenShift

An `openshift_values.yaml` overlay is provided alongside `community_values.yaml`
in the chart. Apply it as the last `-f` argument so it overrides the defaults:

```bash
helm install acs . \
  -f community_values.yaml \
  -f openshift_values.yaml
```

The overlay nulls out `runAsUser`, `runAsGroup`, `fsGroup`, and
`fsGroupChangePolicy` for every enabled sub-chart while keeping
`runAsNonRoot: true`. OpenShift's SCC then assigns UIDs and fsGroups from the
namespace's allowed ranges.

## Known image limitations

Some Alfresco images are not yet fully OpenShift-compatible. The sections below
describe the failures and the required image-level fixes.

### PostgreSQL

**Symptom:**

```text
initdb: error: could not change permissions of directory "/var/lib/postgresql/data": Operation not permitted
```

**Root cause:** `initdb` always calls `chmod 700` on the data directory. The
PVC is mounted at `/var/lib/postgresql/data` and is owned by root; a non-root
UID cannot `chmod` a root-owned directory.

**Fix:** Set `PGDATA` to a subdirectory of the mount point and apply GID 0
permissions to the parent in the Dockerfile (see
[Building OpenShift-compatible images](#building-openshift-compatible-images)):

```dockerfile
ENV PGDATA /var/lib/postgresql/data/pgdata

RUN mkdir -p /var/lib/postgresql/data && \
    chgrp -R 0 /var/lib/postgresql && \
    chmod -R g=u /var/lib/postgresql
```

At runtime the entrypoint creates `pgdata` as a new subdirectory — owned by the
running UID — so `initdb`'s `chmod 700` succeeds. This works unchanged on
vanilla Kubernetes (UID 999) and on OpenShift (UID 1000650000).

### ActiveMQ

**Symptom:**

```text
/usr/local/bin/entrypoint.sh: line 7: /opt/activemq/conf/users.properties: Permission denied
```

**Root cause:** The entrypoint writes broker credentials into
`/opt/activemq/conf/users.properties` at startup. The file is owned by the
`activemq` UID baked into the image; the OpenShift-assigned UID has no write
access.

**Fix:** Apply GID 0 group ownership and group-write permissions to the conf
directory in the Dockerfile:

```dockerfile
RUN chgrp -R 0 /opt/activemq/conf && \
    chmod -R g=u /opt/activemq/conf
```

## Building OpenShift-compatible images

The following requirements apply to every image deployed on OpenShift. They
are derived from the official
[OpenShift guidelines for creating images](https://docs.openshift.com/container-platform/latest/openshift_images/create-images.html).

### 1. Support arbitrary user IDs

Never assume a specific UID. OpenShift overrides the container UID at runtime
from the namespace's SCC UID range. Your process must start successfully
regardless of the UID it runs as.

### 2. Make runtime-writable paths owned by GID 0

OpenShift containers are always members of the root group (GID 0). Any file or
directory that the entrypoint writes to must be group-owned by GID 0 and
group-writable. The canonical Dockerfile snippet is:

```dockerfile
RUN chgrp -R 0 /path/to/writable && \
    chmod -R g=u /path/to/writable
```

`chmod g=u` mirrors user permission bits onto the group bits — `rwx------`
becomes `rwxrwx---`, `rw-r--r--` becomes `rw-rw-r--` — without hardcoding
specific modes, which is important when files in the same tree have mixed
permissions.

### 3. Never call `chmod` on mounted volume directories

Storage provisioners create PVC directories owned by root. A non-root UID
cannot `chmod` or `chown` a root-owned path. If your entrypoint needs to
set permissions on a volume-backed path, use one of these approaches instead:

- Write into a **subdirectory** created at container startup (owned by the
  running UID, see the PostgreSQL pattern above).
- Delegate permission setup to an init container that runs under a SCC
  permitting root (requires cluster-admin cooperation).

### 4. Do not rely on `fsGroup` for image-internal file access

`fsGroup` is a pod-level mechanism that instructs Kubernetes to chown mounted
volumes to a specific GID at mount time. It has no effect on files baked into
the image. For files inside the image, GID 0 group-write permissions (rule 2)
are the correct solution.

### 5. Do not request extra privileges

Images must not require `privileged: true`, additional Linux capabilities, or
`hostPID`/`hostNetwork`. OpenShift's restricted SCC drops all capabilities and
disallows privilege escalation.

## Testing OpenShift compatibility on vanilla Kubernetes

Two complementary techniques let you validate compatibility without an OKD or
OCP cluster.

### Pod Security Admission — catches spec-level violations

Label your test namespace with the `restricted` profile (Kubernetes 1.23+):

```bash
kubectl label namespace <your-ns> \
  pod-security.kubernetes.io/enforce=restricted \
  pod-security.kubernetes.io/warn=restricted
```

Kubernetes will reject any pod spec that would also be rejected by OpenShift's
restricted SCC (missing `runAsNonRoot`, wrong capabilities, etc.).

### Explicit high UID — catches runtime permission failures

PSA only validates the pod spec; it does not catch entrypoint failures at
runtime. An [`openshift_testing_values.yaml`](https://github.com/Alfresco/acs-deployment/blob/master/helm/alfresco-content-services/openshift_testing_values.yaml)
file is provided for this purpose. It pins every pod to UID `1000650000` and
adds `supplementalGroups: [0]` to replicate OpenShift's automatic GID 0
membership:

```bash
helm install acs . \
  -f community_values.yaml \
  -f openshift_testing_values.yaml
```

Any container that fails to start will surface the same permission errors you
would see on OpenShift.
