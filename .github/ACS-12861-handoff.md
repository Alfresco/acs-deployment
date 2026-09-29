# ACS-12861 handoff record

This record tracks coordination separately from the deployment documentation.
Do not mark a handoff complete without a dated link to the relevant ticket,
comment, meeting note, or message.

## DevOps review

Status: Pending notification

Required review:

* Confirm the production edge implementation applies the `remoteadm`, Solr,
  and Prometheus restrictions before the broad Repository route.
* Confirm Repository port `8080` has no untrusted network path that bypasses the
  edge proxy.
* Confirm non-NGINX URI normalization provides equivalent protection.

Notification date: Not recorded

Recipient or channel: Not recorded

Evidence link: Not recorded

Outcome: Not recorded

## Validation supplied with the handoff

Validation date: 2026-09-29

Versions: ACS Community `26.2.0`, Share `26.2.2`, NGINX `1.28`

Results:

* The reported `remoteadm` request returned the fixed `403 Forbidden` response
  through NGINX on `/service`, `/s`, `/wcservice`, and `/wcs`.
* The Prometheus Web Script returned `403 Forbidden` through NGINX on all four
  aliases.
* Real Share and Repository readiness routes returned `200` through NGINX.
* Loading the authenticated real Share dashboard returned `200`; Repository
  access logs recorded successful internal Share requests to
  `/alfresco/s/remoteadm/has/...`, including user dashboard components.

## Documentation Team notification

Status: Pending notification

Requested documentation changes:

* Document the `remoteadm` and Prometheus public-access restrictions and the
  requirement to keep Repository port `8080` private.
* Replace active guidance that relies on the archived
  `Alfresco/acs-ingress` repository with the maintained example in this
  repository.
* Describe the route table as a verified minimum, not a complete ACS endpoint
  inventory.

Notification date: Not recorded

Recipient or channel: Not recorded

Evidence link: Not recorded

Outcome: Not recorded