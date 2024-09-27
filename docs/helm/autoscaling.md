---
title: Autoscaling
parent: Guides
grand_parent: Helm
---

# Automatically scaling Alfresco Content Services

`alfresco-content-services` can leverage Kubernetes HorinzontalPodAutoscaling
provided by individual Alfresco components. This means that you can add more
instances of the same service to handle more load. This is a common pattern in
cloud environments, and also allows to remove instances when the load decreases.

`alfresco-content-services` can also leverage the [KEDA](https://keda.sh/)
framework to scale based on custom, more application centric metrics. To use
this more advanced scaling mechanism, you of course need to have KEDA installed.

This document aims at providing a details on configuring each of the components
which support HPA, either using plain kKubernetes HPA or a [KEDA
scaler](https://keda.sh/docs/latest/scalers/).

Which type of auto scaling is best?
Well that depends of course. We can see the basic HPA based on CPU as a reactive
auto scaling strategy where the system spins up more pods because existing pods
are already quite loaded. Also the threshold which triggers scaling is
calculated based on resource reservation and hence result in different behavior
based on the resource allocation strategy you have chosen. For example, if you
prefer to rely on the cluster ability to over-commit resources, you might want
to set the threshold to a higher value, otherwise scaling will be triggered
sooner than expected. In this way, the CPU based autoscaling is a bit more
difficult to tune.
On the other hand, the KEDA based scaling is more proactive, as it can be
triggered by custom metrics from any other system. For example in the Alfresco
content platform, you could scale specific services based on the number of
messages in the message broker (This is what we document here for ATS pods), or
the number of active users (or a metric which is a representation of this).

## Prerequisites

All scaling capabilities requires Alfresco Enterprise Edition.
In order to use the autoscaling features, you need to have a Kubernetes cluster
with a metrics server installed.
If you're planning on using basic HPA, you need to have the Kubernetes "vanilla"
[metrics-server`](https://github.com/kubernetes-sigs/metrics-server).

Check the [official metric-server
documentation](https://github.com/kubernetes-sigs/metrics-server) for more
information on how to install the metrics server and which version is compatible
with your cluster.

If you prefer to use KEDA, you need to have KEDA installed in your cluster. You
can find the installation instructions in the [KEDA official
documentation](https://keda.sh/docs/latest/deploy/). Make sure to install the
appropriate Custom Resource Definitions (CRDs) for the scalers you want to use.

e.g:

```bash
helm install \
  --repo https://kedacore.github.io/charts alfresco-keda keda \
  --namespace keda \
  --version 2.14.2
```

## Alfresco components auto-scaling

### Alfresco Repository

#### Basic (CPU based) scaling for Alfresco repository

Refer to the
[alfresco-repository auto-scaling
documentation](https://github.com/Alfresco/alfresco-helm-charts/blob/main/charts/alfresco-repository/docs/autoscaling.md)
for a detailed guide on Alfresco repository auto-scaling configuration and
implications.

#### KEDA based scaling for Alfrsco repository

To start with, make sure your Kubernetes cluster has KEDA & prometheus installed.
You must also make sure Alfresco repository is setup to expose prometheus
metrics and prometheus has the appropriate scrape configuration.

Refer to the [acs-packaging
doc](https://github.com/Alfresco/acs-packaging/tree/master/docs/micrometer)

The minimum configuration for the Alfresco repository to expose prometheus
metrics should be:

```yaml
alfresco-repository:
  environment:
    CATALINA_OPTS: >-
      -Dmetrics.enabled=true
      -Dmetrics.jvmMetricsReporter.enabled=true
      ...
```

##### Prometheus scaler

The KEDA based auto scaler relies on the number of Tomcat threads used. By
default the Alfresco repository image uses up to 200 threads. When the system
consistently uses more than 170 threads, the KEDA scaler will start to scale up
the number of pods. This can be tuned using the
`alfresco-repository.autoscaling.kedaTargetValue` if your image has a
configuration with more or less `maxThreads`.
In the same maner the parameters below can be set:

* `behavior.scaleUp.stabilizationWindowSeconds`: The number of threads used must
  remain above target on average for 30 seconds before a scale up can happen.
* `kedaPollingInterval`: threads are checked every 15 seconds.
* `kedaInitialCoolDownPeriod`: KEDA will wait for 5 minutes before activating
  the scaling object (before no scaling can happen).
* `minReplicas`: The default minimum number of replica count is 1.
* `maxReplicas`: The default maximum number of replica count is 3.

### Alfresco Transform Service

#### Basic (CPU based) scaling for ATS

Refer to the
[alfresco-repository auto-scaling
documentation](https://alfresco.github.io/alfresco-helm-charts/charts/alfresco-transform-service/docs/autoscaling.html)
for a detailed guide on Alfresco repository auto-scaling configuration and
implications.

#### KEDA based scaling for ATS

To start with, make sure your Kubernetes cluster has KEDA installed

##### Activemq scaler

Regular ActiveMQ instances exposes a rest API which can be used to get the
number of messages in a queue. This can be used to scale individual ATS T-engine
pods. This scaling mechanism is implemented directly in the
`alfresco-content-services` chart. To enable it you need to set the following:

```yaml
keda:
  components:
    - alfresco-transform-service
```

This will install the KEDA activemq scaler and configure it to scale all the
T-engine workloads (`imagemagick`, `libreoffice`, `transformmisc`, `pdfrenderer`
& `tika`) as described below:

* `kedaTargetValue`: new pods will be started when the corresponding message
  queue has more than 10 messages.
* `behavior.scaleUp.stabilizationWindowSeconds`: The number of messages in the
  queue must remain above target on average for 30 seconds before a scale up can
  happen.
* `kedaPollingInterval`: Queues are checked every 15 seconds.
* `kedaInitialCoolDownPeriod`: KEDA will wait for 5 minutes before activating
  the scaling object (before no scaling can happen).
* `kedaCooldownPeriod`: After KEDA has found there is no activity in the
  monitored queue, it will wait for 15 minutes before scaling down the pods to
  0.
* `kedaIdleReplicas`: The default idle replica count is 0 (tears down the
  service).
* `minReplicas`: The default minimum number of replica count is 1.
* `maxReplicas`: The default maximum number of replica count is 3.

> Values mentioned above must be set for each tengine
> `alfresco-transform-service._TENGINE_NAME_.autoscaling` where `_TENGINE_NAME_`
> is one of the following: `imagemagick`, `libreoffice`, `transformmisc`,
> `pdfrenderer` & `tika`.

Scaling replicas down to zero is great when you have workload that is consistent
enough with long period of inactivity (e.g. during the night). But it can trigger a
delay for the first requests when the workload starts again (e.g. the morning
after). If you want to avoid scaling down you ATS deployments down to zero and
always have at least one pod up to deal quickly with "sparse" requests just
apply the yaml below for the appropriate scaler object (here for pdf
convertion):

```yaml
alfresco-transform-service:
  pdfrenderer:
    autoscaling:
      kedaIdleReplicas: null
```

**Important**: If you're using a version of the ATS T-router prior to 5.1.3, you
need to set the `kedaIdleReplicas` to `0` for all tengines, otherwise the
T-router will eventually crash.

If you want to use an external ActiveMQ broker instead of the embedded one
(recommended), you can set the following values:

```yaml
messageBroker:
  url: failover:(tcp://mybroker.domain.tld:61616)
  webConsole: mybroker.domain.tld:8161
  brokerName: mybroker
  restAPITemplate: https://{{.ManagementEndpoint}}/api/jolokia/read/org.apache.activemq:type=Broker,brokerName={{.BrokerName}},destinationType=Queue,destinationName={{.DestinationName}}/QueueSize
```

To set the authentication you must ensure the broker user has web console access
too.

#### Using AWS AmazonMQ (ActiveMQ)

If you're running Alfresco on AWS you may be using AmazonMQ as your message
broker the jolokia restAPI which ActiveMQ normally provides is not available.
In order to use the KEDA and scale based on message queues size you will need to
use the [Cloudwatch scaler](https://keda.sh/docs/latest/scalers/aws-cloudwatch/)
, create your own
[scaledobject](https://keda.sh/docs/2.14/concepts/scaling-deployments/#scaledobject-spec)
using [Cloudwatch scaler](https://keda.sh/docs/latest/scalers/aws-cloudwatch/)
as a `trigger` leveraging one of the [AWS authentication
provider](https://keda.sh/docs/2.14/authentication-providers/) and disable the
KEDA integration for ATS in this chart (which essentially creates the KEDA CRDs
for you).
