### Apply Pod Security Policies to k8s cluster

[Pod Security Policy](https://kubernetes.io/docs/concepts/policy/pod-security-policy) allows administrators to define a set of conditions that a pod must run with in order to be accepted into the system.

The following recommendations need to be applied to the k8s cluster before any other pod is deployed.

* If kops is used, edit cluster configuration by running:
```
kops edit cluster
```
and adding the following:
```
spec:
  kubeAPIServer:
    admissionControl:
    - PodSecurityPolicy
    - NamespaceLifecycle
    - LimitRanger
    - ServiceAccount
    - DefaultStorageClass
    - DefaultTolerationSeconds
    - MutatingAdmissionWebhook
    - ValidatingAdmissionWebhook
    - ResourceQuota
```
Please note the presence of _PodSecurityPolicy_ admission controller.

* Update the cluster by running:
```
kops update cluster --yes
kops rolling-update cluster --yes
```

* Once the cluster is back in operation check if the default Pod Security Policy (psp) was created by running:
```
kubectl get psp
```
The output should show a default psp named _kube-system_.

* Modify the psp by running:
```
kubectl edit psp kube-system
```
Change the following configuration:
```
spec:
  allowPrivilegeEscalation: false
  privileged: false
  hostNetwork: false
  hostIPC: false
  hostPID: false
  volumes:
  - configMap
  - emptyDir
  - projected
  - secret
  - downwardAPI
  - persistentVolumeClaim
```
Note that the containers are still allowed to use _root_ user as tiller requires it, see [this issue](https://github.com/kubernetes/helm/issues/3992). Also using root filesystem (_readOnlyRootFilesystem_) is allowed as nginx ingress needs it.

If [cluster-autoscaler](https://github.com/kubernetes/kops/tree/master/addons/cluster-autoscaler) is deployed, it will require _hostPath_ type volume to operate.

* Installation of pods using _cluster-admin_ role in _kube-system_ namespace can now use the new psp. Other deployments like _nginx-ingress_ will require additional roles to be set up:
```
kubectl -n $namespace create role $namespace:psp --verb=use --resource=podsecuritypolicy --resource-name=kube-system
kubectl -n $namespace create rolebinding $namespace:psp:default --role=$namespace:psp --serviceaccount=$namespace:default
kubectl -n $namespace create rolebinding $namespace:psp:$release_name-nginx-ingress --role=$namespace:psp --serviceaccount=$namespace:$release_name-nginx-ingress
```
A new role is created in the desired namespace. This role can _use_ the new psp. This role then needs to be bound to _default_ and _nginx-ingress_ service accounts in the desired namespace.