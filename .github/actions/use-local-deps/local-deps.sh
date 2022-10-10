#!/bin/bash -e
# Compute charts dependencies and force local dependencies resolution
CHARTS_ROOT=$(dirname "$1")
CHART_NAME=$(basename "$1")

for DEP_ROOT in $(ls -d "${CHARTS_ROOT}"/* | grep -v "${CHART_NAME}")
do export DEP=$(basename "$DEP_ROOT")
  echo "Looking for $DEP as a dependency of $CHART_NAME"
  DEP_VER=$(yq e '.version' "${CHARTS_ROOT}"/"${DEP}"/Chart.yaml)
  if yq e -i 'del(.dependencies[] | select(.name==strenv(DEP)).repository)' "${CHARTS_ROOT}/${CHART_NAME}/Chart.yaml" > /dev/null 2>&1; then
    helm package --dependency-update --destination "${CHARTS_ROOT}/${CHART_NAME}/charts" "${CHARTS_ROOT}/${DEP}"
    tar zxf "${CHARTS_ROOT}/${CHART_NAME}/charts/${DEP}-${DEP_VER}.tgz" -C "${CHARTS_ROOT}/${CHART_NAME}/charts"
    rm "${CHARTS_ROOT}/${CHART_NAME}/charts/${DEP}-${DEP_VER}.tgz"
  else echo "$DEP is not a dependency of ${CHART_NAME}, skipping"
  fi
done
