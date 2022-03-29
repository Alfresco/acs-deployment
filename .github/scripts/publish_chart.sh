#!/usr/bin/env bash
export BRANCH_NAME=$(echo ${GITHUB_REF##*/})

CHART_VERSION=$(yq eval .version helm/${PROJECT_NAME}/Chart.yaml)
ALPHA_BUILD_VERSION="${CHART_VERSION%-*}-A${GITHUB_RUN_NUMBER}"
if [[ "${BRANCH_NAME}" != "master" ]]
then
    echo "Changing Chart version to ${ALPHA_BUILD_VERSION} as this is a feature branch..."
    sed -i s,$CHART_VERSION,$ALPHA_BUILD_VERSION,g helm/${PROJECT_NAME}/Chart.yaml
elif [[ "${COMMIT_MESSAGE}" == *"[release]"* ]]
then export HELM_REPO=stable
    git checkout -B "${BRANCH_NAME}"
    git config --global user.email "alfresco-build@alfresco.com"
    git config --global user.name "alfresco-build"
    echo "Tagging repository with v$CHART_VERSION..."
    export GIT_TAG="v$CHART_VERSION"
    git tag $GIT_TAG -a -m "Generated tag from github action for build $GITHUB_RUN_NUMBER"
    #git push https://$GITHUB_TOKEN@github.com/Alfresco/acs-deployment $GIT_TAG
    git tag -d latest || true
    git tag -a -m "current latest -> $GIT_TAG" -f latest ${GIT_TAG}^{}
    for ref in ':refs/tags/latest' 'latest'
    do echo "lol"#git push https://$GITHUB_TOKEN@github.com/Alfresco/acs-deployment $ref
    done
fi

COMMIT_MESSAGE_FIRST_LINE=$(git log --pretty=format:%s --max-count=1)
echo using COMMIT_MESSAGE_FIRST_LINE=${COMMIT_MESSAGE_FIRST_LINE}
git config --global user.email "alfresco-build@alfresco.com"
git config --global user.name "alfresco-build"
git clone https://${GITHUB_TOKEN}@github.com/Alfresco/charts.git
echo using PROJECT_NAME=${PROJECT_NAME},BRANCH=${BRANCH},HELM_REPO=${HELM_REPO}
mkdir repo
helm package --dependency-update --destination repo helm/${PROJECT_NAME}
helm repo index repo --url ${HELM_REPO_BASE_URL}/${HELM_REPO} --merge charts/${HELM_REPO}/index.yaml
mv repo/* charts/${HELM_REPO}
cd charts
git add ${HELM_REPO}
git commit -m "${COMMIT_MESSAGE_FIRST_LINE}"
#git push --quiet origin master
