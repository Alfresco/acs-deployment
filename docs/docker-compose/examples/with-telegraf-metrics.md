---
title: Collecting Alfresco metrics with Telegraf
parent: Docker Compose
---

# Collecting Alfresco metrics with Telegraf

This guide aims to demonstrate how to set up Telegraf to collect JMX and
Micrometer metrics from an Alfresco Content Services instance. The collected
metrics in this example are shipped to an InfluxDB instance but Telegraf
supports other outputs as well. See [output plugins](https://github.com/influxdata/telegraf/tree/release-1.35/plugins/outputs)
for details.

## Prerequisites

This example uses config files from `docs/docker-compose/examples/config` folder:

- telegraf-overrides.yaml
- telegraf.conf

To ease the setup process, you can copy these files to `docker-compose` folder.

For Jolokia to work it is required to download the
[Jolokia JVM agent jar](https://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-agent-jvm/2.3.0/jolokia-agent-jvm-2.3.0-javaagent.jar) file and place it in `docker-compose` folder.

## Running the Example

When the files are in place, you can start the ACS instance with Telegraf enabled:

```bash
docker-compose -f compose.yaml -f telegraf-overrides.yaml up -d
```

This will start the ACS instance with Telegraf configured to collect Jolokia and
Micrometer metrics and ship them to an InfluxDB instance.

## Micrometer Configuration

To enable Micrometer metrics in Alfresco Content Services, the following Java
system properties need to be set:

```yaml
    environment:
      JAVA_OPTS: >-
        -Dmetrics.enabled=true
        -Dmetrics.dbMetricsReporter.enabled=true
        -Dmetrics.dbMetricsReporter.query.enabled=true
        -Dmetrics.dbMetricsReporter.query.statements.enabled=true
        -Dmetrics.jvmMetricsReporter.enabled=true
        -Dmetrics.restMetricsReporter.enabled=true
        -Dmetrics.restMetricsReporter.path.enabled=true
        -Dmetrics.tomcatMetricsReporter.enabled=true
        -Dmetrics.authenticationMetricsReporter.enabled=true
```

These properties are already included in the `telegraf-overrides.yaml` file.
This configuration enables repository to expose metrics on
`http://localhost:8080/alfresco/s/prometheus` endpoint.

Telegraf is configured to collect these metrics with the following section in
the `telegraf.conf` file:

```toml
[[inputs.prometheus]]
  urls = [
    "http://alfresco:8080/alfresco/s/prometheus"
  ]
```

The hostname `alfresco` is used as the Telegraf container and Alfresco Content
Services container are part of the same Docker network created by Docker
Compose. This configuration is specific to the
[prometheus input plugin](https://github.com/influxdata/telegraf/tree/release-1.35/plugins/inputs/prometheus).

Shipping Micrometer metrics to InfluxDB is configured with the following section
in the `telegraf.conf` file:

```toml
[[outputs.influxdb_v2]]
  bucket = "alfresco"
  organization = "alfresco"
  timeout = "5s"
  token = "influx"
  urls = [
    "http://influxdb2:8086"
  ]
```

This configuration is specific to the [influxdb_v2 output plugin](https://github.com/influxdata/telegraf/tree/release-1.35/plugins/outputs/influxdb_v2)

There is a [regex plugin](https://github.com/influxdata/telegraf/tree/release-1.35/plugins/processors/regex)
configured to transform the Micrometer metric similar to what is described in
[Micrometer documentation](https://github.com/Alfresco/acs-packaging/blob/master/docs/micrometer/README.md).

To verify that Micrometer metrics are being collected and shipped to InfluxDB
you can enter InfluxDB UI at `http://localhost:8086` with the following
credentials:

- Username: `alfresco`
- Password: `alfresco`

Once logged in, you can use the Data Explorer to query the `alfresco` bucket
and visualize the metrics.

## Jolokia Configuration

To enable JMX metrics collection with Jolokia, the following Java system
properties need to be set:

```yaml
    environment:
      JAVA_OPTS: >-
        -Dcom.sun.management.jmxremote
        -javaagent:/usr/local/tomcat/lib/jolokia-agent-jvm.jar=port=7777,host=0.0.0.0,user=admin,password=admin
    volumes:
      - ./jolokia-agent-jvm-2.3.0-javaagent.jar:/usr/local/tomcat/lib/jolokia-agent-jvm.jar:ro
    ports:
      - "7777:7777"
```

These properties are already included in the `telegraf-overrides.yaml` file.
This configuration attaches the Jolokia JVM agent to the Alfresco process, which
exposes the JMX MBeans over an HTTP endpoint on port `7777`.

Telegraf is configured to collect these metrics with the following section in
the `telegraf.conf` file:

```toml
[[inputs.jolokia2_agent]]
  urls = ["http://alfresco:7777/jolokia"]
  username = "admin"
  password = "admin"

  [[inputs.jolokia2_agent.metric]]
    name = "alfresco_authority"
    mbean = "Alfresco:Name=Authority"
# ... other MBeans
```

The hostname `alfresco` is used as the Telegraf container and Alfresco Content
Services container are part of the same Docker network created by Docker
Compose. This configuration is specific to the
[jolokia2_agent input plugin](https://github.com/influxdata/telegraf/tree/release-1.35/plugins/inputs/jolokia2_agent).

Shipping metrics is done using the same InfluxDB configuration as for Micrometer
metrics.
