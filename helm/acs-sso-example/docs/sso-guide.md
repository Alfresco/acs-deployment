# SSO integration with Keycloak (vanilla)

This is an extension of the base setup presented in the [step by step
guide](./step-by-step-guide.md). Make sure you have it running before reading
further (unless you just want to look at how to integrate Keycloak with ACS
component without trying it on your local machine).

## Architecture of the deployment

The following components are deployed by the example chart:

```mermaid
flowchart TB
classDef alf fill:#0c0
classDef thrdP fill:#ffa

subgraph legend
  t[3rd party component]:::thrdP
  a[Alfresco component]:::alf
end

repodb[(Repository\nDatabase)]:::thrdP
amq{{Message\nBroker}}:::thrdP
repo[Alfresco\nRepository]:::alf
keycloak[Identity\nProvider]:::thrdP
share(Alfreso\nShare UI):::alf
adf(Alfreso\nContent App):::alf

repo ==> amq
repo ==> repodb
share --> repo
adf --> repo
repo --> keycloak
share --> keycloak
adf --> keycloak
```
