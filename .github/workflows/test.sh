#!/usr/bin/env bash

export STAGE_SUFFIX=$(echo ${TRAVIS_BUILD_STAGE_NAME} | tr -d . | awk '{print tolower($0)}')
export namespace=$(echo ${TRAVIS_BRANCH} | cut -c1-28 | tr /_ - | tr -d [:punct:] | awk '{print tolower($0)}')-${TRAVIS_BUILD_NUMBER}-${STAGE_SUFFIX}
export release_name_ingress=ing-${TRAVIS_BUILD_NUMBER}-${STAGE_SUFFIX}
export release_name_acs=acs-${TRAVIS_BUILD_NUMBER}-${STAGE_SUFFIX}
export values_file=helm/alfresco-content-services/values.yaml
echo "test"
