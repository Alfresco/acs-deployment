#!/bin/bash
rm *.tgz
pushd alfresco-content-services
helm dependency update
popd
helm package *
helm repo index .
