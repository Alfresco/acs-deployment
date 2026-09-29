---
title: Restrict internal Repository endpoints
nav_order: 4
---
# Restrict internal Repository endpoints

ACS must be deployed behind an edge proxy or ingress. The Repository service
port (normally `8080`) must only be reachable from trusted application networks;
do not publish it through a public load balancer, Kubernetes `NodePort`, host
port, firewall rule, or a second ingress that bypasses the edge policy.

The example [NGINX configuration](examples/nginx/nginx.conf) blocks known
internal Repository routes while retaining public ACS functionality. It is a
starting point for an environment-specific edge policy, not a complete
inventory of every endpoint supplied by ACS or installed extensions.

## Exposure policy

The Repository Web Script servlet has four aliases:

* `/alfresco/service/`
* `/alfresco/s/`
* `/alfresco/wcservice/`
* `/alfresco/wcs/`

The `remoteadm` Web Script is a Surf configuration store used by Share. Its GET
descriptor declares anonymous authentication and dispatches operations by the
`{method}` path segment. Confirmed read operations are `get`, `has`, `list`,
`listall`, `listpattern`, and `lastmodified`. Some results can contain user
names in Surf component filenames. Public clients do not need this namespace,
so the example blocks the entire `/remoteadm` boundary on every alias instead
of enumerating operations. This also covers future operations below the same
internal namespace.

The same boundary is blocked below Share's `/proxy/alfresco` forms. This closes
a potential path through Share without interfering with Share's server-side
connection to `http://alfresco:8080`, which remains on the private application
network. The fixed local `403 Forbidden` response is deliberate: it neither
contacts Repository nor reflects a Repository response body.

The example retains the existing protections for Repository Solr tracking APIs
and their Share proxy forms. Those routes are internal search integration APIs,
not public search endpoints.

The Repository Prometheus Web Script is also internal and unauthenticated. The
example blocks `/prometheus` on all four Web Script aliases. A trusted metrics
collector should connect over the private application network instead of the
public proxy.

Do not block all anonymously accessible URLs. Login bootstrap, public links,
and other supported features may intentionally use anonymous resources. The
example therefore uses targeted deny rules before broader application routes:

| Function | Public route used by the example | Notes |
|---|---|---|
| Core Repository and REST API | `/alfresco/`, including `/alfresco/api/-default-/public/alfresco/versions/1/` | Authentication remains the Repository's responsibility. |
| CMIS and mobile clients | `/alfresco/api/-default-/public/cmis/versions/1.1/` and the public REST API | Confirm exact client versions and any legacy APIs in use. |
| Share | `/share/` | Share reaches Repository directly on the private network. |
| AOS | `/alfresco/aos` | Required only when AOS is enabled. |
| Legacy/custom Web Scripts and Admin Console | Below `/alfresco/service/`, `/s/`, `/wcservice/`, and `/wcs/` | Allowed except for explicit internal namespaces. Review installed extensions. |

Digital Workspace, Content App, Control Center, Sync Service, API Explorer, and
other separately deployed applications need additional upstreams and locations
when they share this proxy. They are intentionally absent from the minimal
example.

## Use the example

1. Copy `docs/examples/nginx/nginx.conf` into the NGINX instance at the public
   trust boundary.
2. Change the `alfresco:8080` and `share:8080` upstream addresses if those DNS
   names are not valid on the private application network.
3. Add TLS, timeouts, access logging, request-size limits, and locations for
   optional applications according to local requirements. The example leaves
   request size unlimited to match the historical ACS proxy behavior; set an
   appropriate production limit.
4. Ensure Share continues to use the private Repository service address. Do not
   configure Share to call the public NGINX address for Repository traffic.
5. Remove all public paths to Repository port `8080`, then test from both an
   untrusted network and a Share container or pod.

For Docker Compose, services on the default Compose network can use
`http://alfresco:8080`; only the proxy port should be published. For Kubernetes,
use a `ClusterIP` Repository Service and restrict ingress to the edge controller.
NetworkPolicy, security groups, and firewall rules should permit Repository
traffic only from trusted workloads such as Share, Search, transforms, and
administration tooling that requires it.

Run the focused example checks with Docker:

```bash
docs/examples/nginx/test.sh
```

The checks use fixed-response mock upstreams to validate NGINX syntax, routing,
and location precedence. They exercise all four aliases and confirmed
`remoteadm` read operations, normalized paths and location boundaries, Solr and
Prometheus blocks, representative Repository, REST, CMIS, AOS, and Share paths,
and private-network routing. They do not prove application compatibility. The
mock Repository deliberately returns a username-like value, allowing the test
to verify that blocked responses do not disclose upstream content.

Before deploying a changed edge policy, perform a focused check with the real
ACS and Share versions used by the environment: the `remoteadm` URLs must return
the deliberate `403` through NGINX while loading Share must still produce
successful internal `remoteadm` requests from Share to Repository.

## Evidence and limitations

The route policy is based on these sources:

* [`remoteadm.get.desc.xml`](https://github.com/Alfresco/alfresco-community-repo/blob/master/remote-api/src/main/resources/alfresco/templates/webscripts/org/alfresco/repository/store/remoteadm.get.desc.xml)
  declares `/remoteadm/{method}` and `/remoteadm/{method}/{path}` with
  authentication `none`.
* [`BaseRemoteStore.java`](https://github.com/Alfresco/alfresco-community-repo/blob/master/remote-api/src/main/java/org/alfresco/repo/web/scripts/bean/BaseRemoteStore.java)
  dispatches the confirmed read operations listed above.
* [`ADMRemoteStore.java`](https://github.com/Alfresco/alfresco-community-repo/blob/master/remote-api/src/main/java/org/alfresco/repo/web/scripts/bean/ADMRemoteStore.java)
  runs reads as the system user and maps Surf user, site, page, and component
  configuration.
* Repository [`web.xml`](https://github.com/Alfresco/alfresco-community-repo/blob/master/packaging/war/src/main/webapp/WEB-INF/web.xml)
  maps Web Script authentication filters to the service aliases, including
  `/wcservice/*` and `/wcs/*`.
* Existing ACS deployment proxy rules and Postman collections protect Solr on
  the same four aliases.
* The Docker Compose [`base.yaml`](../docker-compose/commons/base.yaml)
  proxy policy restricts the Prometheus Web Script to loopback clients on the
  same four aliases.

This evidence confirms the `remoteadm` namespace and aliases; it does not prove
that no other extension or internal Web Script requires an edge restriction.
An allowlist for all Repository traffic is not included because the supported
route set varies with ACS edition, version, modules, and custom Web Scripts.

## Required deployment review

DevOps must confirm these points before rollout:

* Which ingress, gateway, CDN, or load balancer is the only public entry point,
  and can any DNS name or IP address bypass it to Repository port `8080`?
* Are URI normalization rules equivalent if the production edge is not NGINX?

Reviewing custom modules and adding rate limits, alerting, or audit retention are
optional deployment considerations, not acceptance requirements for this
example.

The Documentation Team should incorporate the exposure policy and backend
network restriction into official ACS security guidance and replace references
to the archived `Alfresco/acs-ingress` image with this maintained example. The
separate [project handoff record](../.github/ACS-12861-handoff.md) tracks the
required DevOps coordination and Documentation Team notification; this guide
does not claim those actions have occurred.
