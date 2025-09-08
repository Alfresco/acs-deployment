#!/usr/bin/env bash

kubectl apply -f keycloak-config.yaml

kubectl create secret generic keycloak --from-literal=KC_BOOTSTRAP_ADMIN_PASSWORD=admin --from-literal=KC_BOOTSTRAP_ADMIN_USERNAME=admin
kubectl create secret generic keycloak-realm --from-file=alfresco.json=keycloak-realm.json

helm upgrade keycloak codecentric/keycloakx --version 6.0.0 --values values-keycloak.yaml

helm upgrade acs . --set global.alfrescoRegistryPullSecrets=quay-registry-secret --values ../../test/enterprise-integration-test-values.yaml