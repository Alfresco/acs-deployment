---
title: Accessing JMX metrics with Jconsole
parent: Docker Compose
---

# Accessing JMX metrics with Jconsole

This guide aims to demonstrate how to set up Jconsole to access JMX metrics from
an Alfresco Content Services instance.

## Prerequisites

This example uses values files from `docs/docker-compose/examples/values` folder:

```yaml
- jconsole-overrides.yaml
```

To ease the setup process, you can copy these files to to `docker-compose` folder.

## Running the Example

When the files are in place, you can start the ACS instance with JMX enabled:

```bash
docker-compose -f compose.yaml -f jconsole-overrides.yaml up -d
```

This will start the ACS instance with JMX enabled.

## Accessing JMX with Jconsole

When the ACS instance is up and running, you can connect to it using Jconsole
with `localhost:50500` or
`service:jmx:rmi://localhost:50500/jndi/rmi://localhost:50500/jmxrmi` as the
connection string.
