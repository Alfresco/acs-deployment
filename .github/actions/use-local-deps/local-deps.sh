#!/bin/bash -e
# Compute charts dependencies and force local dependencies resolution
CHARTS_ROOT=$(dirname "$1")
CHART_NAME=$(basename "$1")

# Get every charts we MAY depend on
for DEP_ROOT in $(ls -d "${CHARTS_ROOT}"/* | grep -v "${CHART_NAME}")
do export DEP=$(basename "$DEP_ROOT")
  DEP_VER=$(yq e '.version' "${CHARTS_ROOT}"/"${DEP}"/Chart.yaml)
  # Get every charts descriptor including subcharts
  for CHART_NSUBS in $(find "${CHARTS_ROOT}/${CHART_NAME}" -type f ! -regex "${CHARTS_ROOT}/.*$DEP/Chart.yaml" -name Chart.yaml)
  do echo "Looking for $DEP as a dependency in $CHART_NSUBS"
    CHART_WORKDIR=$(dirname "$CHART_NSUBS")/charts
    # Check charts r subchart ACTUALLY depends on the local dependency
    if yq e -i 'del(.dependencies[] | select(.name==strenv(DEP)).repository)' "${CHART_NSUBS}" > /dev/null 2>&1; then
      helm package --dependency-update --destination "${CHART_WORKDIR}" "${CHARTS_ROOT}/${DEP}"
      tar zxf "${CHART_WORKDIR}/${DEP}-${DEP_VER}.tgz" -C "${CHART_WORKDIR}"
      rm "${CHART_WORKDIR}/${DEP}-${DEP_VER}.tgz"
    else echo "no dependency to $DEP found in ${CHART_NSUBS}, skipping"
    fi
  done
done
