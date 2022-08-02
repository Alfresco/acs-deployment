#!/usr/bin/env bash

if [ -z "${ACS_VERSION}" ]; then
  echo "ACS_VERSION variable is not set"
  exit 2
fi
if [ -z "${COMMIT_MESSAGE}" ]; then
  echo "COMMIT_MESSAGE variable is not set"
  exit 2
fi
if [ -z "${GITHUB_RUN_NUMBER}" ]; then
  echo "GITHUB_RUN_NUMBER variable is not set"
  exit 2
fi
if [ -z "${BRANCH_NAME}" ]; then
  echo "BRANCH_NAME variable is not set"
  exit 2
fi

GIT_DIFF="$(git diff origin/master --name-only .)"
VALID_VERSION=$(echo "${ACS_VERSION}" | tr -d '.' | awk '{print tolower($0)}')
namespace=$(echo "${BRANCH_NAME}" | cut -c1-28 | tr /_ - | tr -d [:punct:] | awk '{print tolower($0)}')-"${GITHUB_RUN_NUMBER}"-"${VALID_VERSION}"
release_name_ingress=ing-"${GITHUB_RUN_NUMBER}"-"${VALID_VERSION}"
release_name_acs=acs-"${GITHUB_RUN_NUMBER}"-"${VALID_VERSION}"
HOST=localhost
PROJECT_NAME=alfresco-content-services

# pod status
pod_status() {
  kubectl get pods --namespace "${namespace}" -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase,READY:.status.conditions[?\(@.type==\'Ready\'\)].status
}

# failed pods logs
failed_pod_logs() {
  pod_status | grep False | awk '{print $1}' | \
    while read pod; do
      echo -e '\e[1;31m' "${pod}" '\e[0m' && \
      kubectl get event --namespace "${namespace}" --field-selector involvedObject.name="${pod}"
      kubectl logs "${pod}" --namespace "${namespace}" --tail 1024
    done
}

wait_for_connection() {
  declare -ir MAX_SECONDS=600
  declare -ir TIMEOUT=$SECONDS+$MAX_SECONDS
  while [[ $SECONDS < $TIMEOUT ]] && [[ "${http_resp}" != "200" ]]; do
    local http_resp=$(curl -s -o - -I "${HOST}"/alfresco/ | grep HTTP/1.1 | awk '{print $2}')
    echo "http response=${http_resp} from ${HOST}/alfresco/"
    sleep 10
  done
}

# pods ready
pods_ready() {
  PODS_COUNTER=0
  PODS_COUNTER_MAX=60
  PODS_SLEEP_SECONDS=10

  while [ "${PODS_COUNTER}" -lt "${PODS_COUNTER_MAX}" ]; do
    totalpods=$(pod_status | grep -v NAME | wc -l | sed 's/ *//')
    readypodcount=$(pod_status | grep ' True' | wc -l | sed 's/ *//')
    if [ "${readypodcount}" -eq "${totalpods}" ]; then
      echo "     ${readypodcount}/${totalpods} pods ready now"
      pod_status
      echo "All pods are ready!"
      break
    fi
    PODS_COUNTER=$((PODS_COUNTER + 1))
    echo "just ${readypodcount}/${totalpods} pods ready now - sleeping ${PODS_SLEEP_SECONDS} seconds - counter ${PODS_COUNTER}"
    sleep "${PODS_SLEEP_SECONDS}"
    continue
  done

  if [ "${PODS_COUNTER}" -ge "${PODS_COUNTER_MAX}" ]; then
    pod_status
    echo "Pods did not start - failing build"
    failed_pod_logs
    if [[ "${COMMIT_MESSAGE}" != *"[keep env]"* ]]; then
      helm delete "${release_name_ingress}" "${release_name_acs}" -n "${namespace}"
      kubectl delete namespace "${namespace}" --grace-period=1
    fi
    return 1
  fi
}

newman() {
  # shellcheck disable=SC2048
  # shellcheck disable=SC2086
  for i in {1..5}; do
    docker run -t -v "${PWD}/test/postman:/etc/newman" --net host postman/newman:5.3 $* && return 0
    echo "newman run failed, trying again ($i run)"
    sleep 10
  done
  return 1
}
prepare_namespace() {
  cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Namespace
metadata:
    name: ${namespace}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: ${namespace}:psp
  namespace: ${namespace}
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
  name: ${namespace}:psp:default
  namespace: ${namespace}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ${namespace}:psp
subjects:
- kind: ServiceAccount
  name: default
  namespace: ${namespace}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ${namespace}:psp:${release_name_ingress}-nginx-ingress
  namespace: ${namespace}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ${namespace}:psp
subjects:
- kind: ServiceAccount
  name: ${release_name_ingress}-nginx-ingress
  namespace: ${namespace}
---
EOF
}

export values_file=helm/"${PROJECT_NAME}"/values.yaml
if [[ ${ACS_VERSION} != "latest" ]]; then
  values_file="helm/${PROJECT_NAME}/${ACS_VERSION}_values.yaml"
fi

if [[ "${BRANCH_NAME}" == "OPSEXP-1546-kind" ]] ||
  [[ "${COMMIT_MESSAGE}" == *"[run all tests]"* ]] ||
  [[ "${COMMIT_MESSAGE}" == *"[release]"* ]] ||
  [[ "${GIT_DIFF}" == *helm/${PROJECT_NAME}/${ACS_VERSION}_values.yaml* ]] ||
  [[ "${GIT_DIFF}" == *helm/${PROJECT_NAME}/templates* ]] ||
  [[ "${GIT_DIFF}" == *helm/${PROJECT_NAME}/charts* ]] ||
  [[ "${GIT_DIFF}" == *helm/${PROJECT_NAME}/requirements* ]] ||
  [[ "${GIT_DIFF}" == *helm/${PROJECT_NAME}/values.yaml* ]] ||
  [[ "${GIT_DIFF}" == *test/postman/helm* ]]; then
  echo "deploying..."
else
  exit 0
fi

# Main
prepare_namespace
kubectl create secret generic quay-registry-secret --from-file=.dockerconfigjson="${HOME}"/.docker/config.json --type=kubernetes.io/dockerconfigjson -n "${namespace}"

echo "Install kind patched ingress..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

# install acs
helm dep up helm/"${PROJECT_NAME}"
helm upgrade --install "${release_name_acs}" helm/"${PROJECT_NAME}" \
  --values="${values_file}" \
  --set global.tracking.sharedsecret="$(openssl rand -hex 24)" \
  --set externalPort="80" \
  --set externalProtocol="http" \
  --set externalHost="${HOST}" \
  --set global.alfrescoRegistryPullSecrets=quay-registry-secret \
  --set alfresco-sync-service.syncservice.enabled=false \
  --set postgresql-syncservice.enabled=false \
  --set repository.replicaCount=1 \
  --set transformrouter.replicaCount=1 \
  --set pdfrenderer.replicaCount=1 \
  --set imagemagick.replicaCount=1 \
  --set libreoffice.replicaCount=1 \
  --set tika.replicaCount=1 \
  --set transformmisc.replicaCount=1 \
  --set postgresql-syncservice.resources.requests.memory="500Mi" \
  --set postgresql-syncservice.resources.limits.memory="500Mi" \
  --set postgresql.resources.requests.memory="500Mi" \
  --set postgresql.resources.limits.memory="500Mi" \
  --set alfresco-search.resources.requests.memory="1000Mi" \
  --set alfresco-search.resources.limits.memory="1000Mi" \
  --set transformrouter.resources.requests.memory="1000Mi" \
  --set transformrouter.resources.limits.memory="1000Mi" \
  --set share.resources.limits.memory="1500Mi" \
  --set share.resources.requests.memory="1500Mi" \
  --set repository.resources.limits.memory="3500Mi" \
  --set repository.resources.requests.memory="3500Mi" \
  --wait \
  --timeout 20m0s \
  --namespace="${namespace}"


pods_ready || exit 1

# Delay running the tests to give ingress & SOLR a chance to fully initialise
echo "Waiting 3 minutes from $(date) before running tests..."
sleep 180

# run acs checks
wait_for_connection
newman run helm/acs-test-helm-collection.json --global-var "protocol=http" --global-var "url=${HOST}"
TEST_RESULT=$?
echo "TEST_RESULT=${TEST_RESULT}"
if [[ "${TEST_RESULT}" == "0" ]]; then
  TEST_RESULT=0
  # run sync service checks
  if [[ ${ACS_VERSION} != "community" ]]; then
    wait_for_connection
    newman run "helm/sync-service-test-helm-collection.json" --global-var "protocol=https" --global-var "url=${HOST}"
    TEST_RESULT=$?
    echo "TEST_RESULT=${TEST_RESULT}"
  fi

  if [[ "${TEST_RESULT}" == "0" ]] && [[ ${ACS_VERSION} == "latest" ]]; then
    # For checking if persistence failover is correctly working with our deployments
    # in the next phase we delete the acs and postgresql pods,
    # wait for k8s to recreate them, then check if the data created in the first test run is still there
    kubectl delete pod -l app="${release_name_acs}"-alfresco-cs-repository,component=repository -n "${namespace}"
    kubectl delete pod -l app=postgresql-acs,release="${release_name_acs}" -n "${namespace}"
    helm upgrade "${release_name_acs}" helm/"${PROJECT_NAME}" \
      --wait \
      --timeout 10m0s \
      --reuse-values \
      --namespace="${namespace}"

    # check pods
    pods_ready || exit 1

    # run checks after pod deletion
    wait_for_connection
    newman run "helm/acs-validate-volume-collection.json" --global-var "protocol=http" --global-var "url=${HOST}"
    TEST_RESULT=$?
    echo "TEST_RESULT=${TEST_RESULT}"
  fi
fi
if [[ "${COMMIT_MESSAGE}" != *"[keep env]"* ]]; then
  helm delete "${release_name_ingress}" "${release_name_acs}" -n "${namespace}"
  kubectl delete namespace "${namespace}" --grace-period=1
fi

if [[ "${TEST_RESULT}" == "1" ]]; then
  echo "Tests failed, exiting"
  exit 1
fi
