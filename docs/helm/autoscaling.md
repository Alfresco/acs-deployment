---
title: Autoscaling
parent: Guides
grand_parent: Helm
---

# Alfresco components auto-scaling

`alfresco-content-services` can leverage Kubernetes HorinzontalPodAutoscaling
provided by individual Alfresco components. This means that you can add more
instances of the same service to handle more load. This is a common pattern in
cloud environments, where you can add more instances of a service to handle
more load, and remove instances when the load decreases.
This document aims at providing a details on configuring each of the components
which support HPA.

## Alfresco Repository

Refer to the
[alfresco-repository auto-scaling
documentation](https://github.com/Alfresco/alfresco-helm-charts/blob/main/charts/alfresco-repository/docs/autoscaling.md)
for a detailed guide on Alfresco repository auto-scaling configuration and
implications.
