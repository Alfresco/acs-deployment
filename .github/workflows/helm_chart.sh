#!/usr/bin/env bash

COMMIT_MESSAGE=$1
export GIT_DIFF=$(git diff origin/master --name-only .)
export BRANCH_NAME=$(echo ${GITHUB_REF##*/})
VALID_VERSION=$(echo ${VERSION} | tr -d '.' | awk '{print tolower($0)}')
export namespace=$(echo ${BRANCH_NAME} | cut -c1-28 | tr /_ - | tr -d [:punct:] | awk '{print tolower($0)}')-${GITHUB_RUN_NUMBER}-${VALID_VERSION}
export release_name_ingress=ing-${GITHUB_RUN_NUMBER}-${VALID_VERSION}
export release_name_acs=acs-${GITHUB_RUN_NUMBER}-${VALID_VERSION}

# pod status
pod_status() {
    kubectl get pods --namespace $namespace -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,READY:.status.conditions[?\(@.type==\'Ready\'\)].status
}

# failed pods logs
failed_pod_logs() {
    pod_status | grep False | awk '{print $1}' | while read pod; do echo -e '\e[1;31m' $pod '\e[0m' && kubectl logs $pod --namespace $namespace; done
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
    failed_pod_logs
    if [[ "$COMMIT_MESSAGE" != *"[keep env]"* ]]; then
        helm delete $release_name_ingress $release_name_acs -n $namespace
        kubectl delete namespace $namespace
    fi
    exit 1
    fi
}

prepare_namespace() {
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
EOF
}


export values_file=helm/alfresco-content-services/values.yaml
if [[ ${VERSION} != "test" ]]; then
    values_file="helm/alfresco-content-services/${VERSION}_values.yaml"  #change this later
fi

deploy=false

if [[ "${BRANCH_NAME}" == "master" ]] || [[ "${COMMIT_MESSAGE}" == *"[run all tests]"* ]] || [[ "${COMMIT_MESSAGE}" == *"[release]"* ]] || [[ "${GIT_DIFF}" == *helm/alfresco-content-services/${VERSION}_values.yaml* ]] || [[ "${GIT_DIFF}" == *helm/alfresco-content-services/templates* ]] || [[ "${GIT_DIFF}" == *helm/alfresco-content-services/charts* ]] || [[ "${GIT_DIFF}" == *helm/alfresco-content-services/requirements* ]] || [[ "${GIT_DIFF}" == *helm/alfresco-content-services/values.yaml* ]] || [[ "${GIT_DIFF}" == *test/postman/helm* ]]
then
    deploy=true
fi

echo 'mieszko'
echo $deploy
deploy=true


if $deploy; then
# Utility Functions

  prepare_namespace
  kubectl create secret generic quay-registry-secret --from-file=.dockerconfigjson=$HOME/.docker/config.json --type=kubernetes.io/dockerconfigjson -n $namespace

  # install ingress
  #AWS_SG is empty???
  helm upgrade --install $release_name_ingress --repo https://kubernetes.github.io/ingress-nginx ingress-nginx --version=3.7.1 \
  --set controller.scope.enabled=true \
  --set controller.scope.namespace=$namespace \
  --set rbac.create=true \
  --set controller.config."proxy-body-size"="100m" \
  --set controller.service.targetPorts.https=80 \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-backend-protocol"="http" \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-ports"="https" \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-cert"="${ACM_CERTIFICATE}" \
  --set controller.service.annotations."external-dns\.alpha\.kubernetes\.io/hostname"="$namespace.${HOSTED_ZONE}" \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-ssl-negotiation-policy"="ELBSecurityPolicy-TLS-1-2-2017-01" \
  --set controller.service.annotations."service\.beta\.kubernetes\.io/aws-load-balancer-security-groups"="${AWS_SG}" \
  --set controller.publishService.enabled=true \
  --set controller.admissionWebhooks.enabled=false \
  --wait \
  --namespace $namespace

  # install acs
  helm dep up helm/alfresco-content-services
  helm upgrade --install $release_name_acs helm/alfresco-content-services \
      --values=$values_file \
      --set global.tracking.sharedsecret=$(openssl rand 24 -hex) \
      --set externalPort="443" \
      --set externalProtocol="https" \
      --set externalHost="$namespace.${HOSTED_ZONE}" \
      --set persistence.enabled=true \
      --set persistence.storageClass.enabled=true \
      --set persistence.storageClass.name="nfs-client" \
      --set postgresql.persistence.existingClaim="" \
      --set postgresql-syncservice.persistence.existingClaim="" \
      --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
      --wait \
      --timeout 20m0s \
      --namespace=$namespace


  # check dns and pods
  DNS_PROPAGATED=0
  DNS_COUNTER=0
  DNS_COUNTER_MAX=90
  DNS_SLEEP_SECONDS=10

  echo "Trying to perform a trace DNS query to prevent caching"
  dig +trace $namespace.${HOSTED_ZONE} @8.8.8.8
  while [ "$DNS_PROPAGATED" -eq 0 ] && [ "$DNS_COUNTER" -le "$DNS_COUNTER_MAX" ]; do
      host $namespace.${HOSTED_ZONE} 8.8.8.8
      if [ "$?" -eq 1 ]; then
      DNS_COUNTER=$((DNS_COUNTER + 1))
      echo "DNS Not Propagated - Sleeping $DNS_SLEEP_SECONDS seconds"
      sleep "$DNS_SLEEP_SECONDS"
      else
      echo "DNS Propagated"
      DNS_PROPAGATED=1
      fi
  done

  [ $DNS_PROPAGATED -ne 1 ] && echo "DNS entry for $namespace.${HOSTED_ZONE} did not propagate within expected time" && exit 1

  pods_ready

  # Delay running the tests to give ingress & SOLR a chance to fully initialise
  echo "Waiting 3 minutes from $(date) before running tests..."
  sleep 180

  # run acs checks
  docker run -a STDOUT --volume $PWD/test/postman/helm:/etc/newman --network host postman/newman_alpine33:3.9.2 run "acs-test-helm-collection.json" --global-var "protocol=https" --global-var "url=$namespace.${HOSTED_ZONE}"
  TEST_RESULT=$?
  echo "TEST_RESULT=${TEST_RESULT}"
  if [[ "${TEST_RESULT}" == "0" ]]; then
      TEST_RESULT=0
      # run sync service checks
      if [[ "$values_file" != "helm/alfresco-content-services/community_values.yaml" ]]; then
          docker run -a STDOUT --volume $PWD/test/postman/helm:/etc/newman --network host postman/newman_alpine33:3.9.2 run "sync-service-test-helm-collection.json" --global-var "protocol=https" --global-var "url=$namespace.${HOSTED_ZONE}"
          TEST_RESULT=$?
          echo "TEST_RESULT=${TEST_RESULT}"
      fi


      if [[ "${TEST_RESULT}" == "0" ]]; then
          # For checking if persistence failover is correctly working with our deployments
          # in the next phase we delete the acs and postgress pods,
          # wait for k8s to recreate them, then check if the data created in the first test run is still there
          kubectl delete pod -l app=$release_name_acs-alfresco-cs-repository,component=repository -n $namespace
          kubectl delete pod -l app=postgresql-acs,release=$release_name_acs -n $namespace
          helm upgrade $release_name_acs helm/alfresco-content-services \
              --wait \
              --timeout 10m0s \
              --reuse-values \
              --namespace=$namespace

      # check pods
      pods_ready

      # run checks after pod deletion
      docker run -a STDOUT --volume $PWD/test/postman/helm:/etc/newman --network host postman/newman_alpine33:3.9.2 run "acs-validate-volume-collection.json" --global-var "protocol=https" --global-var "url=$namespace.${HOSTED_ZONE}"
      TEST_RESULT=$?
      echo "TEST_RESULT=${TEST_RESULT}"
      fi
  fi

  if [[ "$TRAVIS_COMMIT_MESSAGE" != *"[keep env]"* ]]; then
      echo "tmp"
      helm delete $release_name_ingress $release_name_acs -n $namespace
      kubectl delete namespace $namespace
  fi

  if [[ "${TEST_RESULT}" == "1" ]]; then
      echo "Tests failed, exiting"
      exit 1
  fi
fi
