#!/bin/bash

set -e
# Utility Functions

# pod status
pod_status() {
  kubectl get pods --namespace $namespace -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,READY:.status.conditions[?\(@.type==\'Ready\'\)].status
}

# pods ready
pods_ready() {
  PODS_COUNTER=0
  PODS_COUNTER_MAX=60
  PODS_SLEEP_SECONDS=10

  while [ "$PODS_COUNTER" -lt "$PODS_COUNTER_MAX" ]; do
    totalpods=$(pod_status | grep -v NAME | wc -l | sed 's/ *//')
    readypodcount=$(pod_status | grep ' True' | wc -l | sed 's/ *//')
    if [ "$readypodcount" -eq "$totalpods" ]; then
          echo "     $readypodcount/$totalpods pods ready now"
          pod_status
      echo "All pods are ready!"
      break
    fi
      PODS_COUNTER=$((PODS_COUNTER + 1))
      echo "just $readypodcount/$totalpods pods ready now - sleeping $PODS_SLEEP_SECONDS seconds - counter $PODS_COUNTER"
      sleep "$PODS_SLEEP_SECONDS"
      continue
    done
  
  if [ "$PODS_COUNTER" -ge "$PODS_COUNTER_MAX" ]; then
    pod_status
    echo "Pods did not start - exit 1"
    exit 1
  fi
}

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
  name: $namespace
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: $namespace:psp
  namespace: $namespace
rules:
- apiGroups:
  - policy
  resourceNames:
  - kube-system
  resources:
  - podsecuritypolicies
  verbs:
  - use
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: $namespace:psp:default
  namespace: $namespace
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: $namespace:psp
subjects:
- kind: ServiceAccount
  name: default
  namespace: $namespace
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: $namespace:psp:$release_name_ingress-nginx-ingress
  namespace: $namespace
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: $namespace:psp
subjects:
- kind: ServiceAccount
  name: $release_name_ingress-nginx-ingress
  namespace: $namespace
---
$(kubectl create secret docker-registry quay-registry-secret --dry-run=client --docker-server=${DOCKER_REGISTRY} --docker-username=${DOCKER_REGISTRY_USERNAME} --docker-password=${DOCKER_REGISTRY_PASSWORD} -n $namespace -o yaml)
EOF

# install ingress
helm upgrade --install $release_name_ingress stable/nginx-ingress \
--set controller.scope.enabled=true \
--set controller.scope.namespace=$namespace \
--set rbac.create=true \
--set controller.config."proxy-body-size"="100m" \
--set controller.service.targetPorts.https=80 \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-backend-protocol"="http" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-ports"="https" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-cert"="${ACM_CERTIFICATE}" \
--set controller.service.annotations."external-dns\.alpha\.kubernetes\.io/hostname"="$namespace.dev.alfresco.me" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-negotiation-policy"="ELBSecurityPolicy-TLS-1-2-2017-01" \
--set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-security-groups"="${AWS_SG}" \
--set controller.publishService.enabled=true \
--wait \
--atomic \
--namespace $namespace

# install acs
helm dep up helm/alfresco-content-services
helm upgrade --install $release_name_acs helm/alfresco-content-services \
--values=$values_file \
--set externalPort="443" \
--set externalProtocol="https" \
--set externalHost="$namespace.dev.alfresco.me" \
--set persistence.enabled=true \
--set persistence.storageClass.enabled=true \
--set persistence.storageClass.name="nfs-client" \
--set global.alfrescoRegistryPullSecrets=quay-registry-secret \
--wait \
--timeout 9m0s \
--atomic \
--namespace=$namespace

# check dns and pods
DNS_PROPAGATED=0
DNS_COUNTER=0
DNS_COUNTER_MAX=90
DNS_SLEEP_SECONDS=10

echo "Trying to perform a trace DNS query to prevent caching"
dig +trace $namespace.dev.alfresco.me @8.8.8.8

while [ "$DNS_PROPAGATED" -eq 0 ] && [ "$DNS_COUNTER" -le "$DNS_COUNTER_MAX" ]; do
  host $namespace.dev.alfresco.me 8.8.8.8
  if [ "$?" -eq 1 ]; then
    DNS_COUNTER=$((DNS_COUNTER + 1))
    echo "DNS Not Propagated - Sleeping $DNS_SLEEP_SECONDS seconds"
    sleep "$DNS_SLEEP_SECONDS"
  else
    echo "DNS Propagated"
    DNS_PROPAGATED=1
  fi
done

[ $DNS_PROPAGATED -ne 1 ] && echo "DNS entry for $namespace.dev.alfresco.me did not propagate within expected time"

pods_ready

# run acs checks
docker run -a STDOUT --volume $PWD/test/postman/helm:/etc/newman --network host postman/newman_alpine33:3.9.2 run "acs-test-helm-collection.json" --global-var "protocol=https" --global-var "url=$namespace.dev.alfresco.me"

# delete pods
kubectl delete pod -l app=$release_name_acs-alfresco-cs-repository,component=repository -n $namespace
kubectl delete pod -l app=postgresql-acs,release=$release_name_acs -n $namespace
helm upgrade $release_name_acs helm/alfresco-content-services \
--wait \
--timeout 10m0s \
--atomic \
--reuse-values \
--namespace=$namespace

# check pods
pods_ready

# run checks after pod deletion
docker run -a STDOUT --volume $PWD/test/postman/helm:/etc/newman --network host postman/newman_alpine33:3.9.2 run "acs-validate-volume-collection.json" --global-var "protocol=https" --global-var "url=$namespace.dev.alfresco.me"