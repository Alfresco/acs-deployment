#!/bin/bash
#rm *.tgz
pushd install
helm dependency update
popd
pushd postgres
helm dependency update
popd
pushd alfresco-content-services
helm dependency update
popd
pushd alfresco-identity-service
helm dependency update
popd
helm package *
helm repo index .
