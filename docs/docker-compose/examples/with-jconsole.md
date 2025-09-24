---
title: Accessing JMX metrics with Jconsole
parent: Docker Compose
---

# Accessing JMX metrics with Jconsole

This guide aims to demonstrate how to set up Jconsole to access JMX metrics from
an Alfresco Content Services instance.

## Running the Example

Edit `compose.yaml` and locate the `alfresco` service. Merge the following
snippet into its `environment` and `ports` sections:

```yaml
services:
  alfresco:
    environment:
      JAVA_OPTS: >-
        -Dcom.sun.management.jmxremote
        -Dcom.sun.management.jmxremote.ssl=false
        -Dcom.sun.management.jmxremote.authenticate=false
        -Dcom.sun.management.jmxremote.port=50500
        -Dcom.sun.management.jmxremote.rmi.port=50500
        -Dcom.sun.management.jmxremote.local.only=false
        -Dalfresco.jmx.connector.enabled=true
        -Dalfresco.rmi.services.port=50500
        -Djava.rmi.server.hostname=127.0.0.1
    ports:
      - "50500:50500"
```

Then start the stack:

```bash
docker-compose up -d
```

## Accessing JMX with Jconsole

When the ACS instance is up and running, you can connect to it using Jconsole
with `localhost:50500` or
`service:jmx:rmi://localhost:50500/jndi/rmi://localhost:50500/jmxrmi` as the
connection string.
