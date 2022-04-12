#!/usr/bin/env bash

COMMIT_MESSAGE=$1

export BRANCH_NAME=$(echo ${GITHUB_REF##*/})
export GIT_DIFF=$(git diff origin/master --name-only .)

export compose_file="docker-compose.yml"
export alf_port=8080
deploy=false
if [[ ${VERSION} != "test" ]]; then
    export compose_file="${VERSION}-docker-compose.yml"
fi
if [[ "${BRANCH_NAME}" == "master" ]] || [[ "${COMMIT_MESSAGE}" == *"[run all tests]"* ]] || [[ "${COMMIT_MESSAGE}" == *"[release]"* ]] || [[ "${GIT_DIFF}" == *$compose_file* ]] || [[ "${GIT_DIFF}" == *test/postman/docker-compose* ]]
then
    deploy=true
fi

echo "mieszko"
echo $GIT_DIFF
echo $deploy
deploy=true


if $deploy; then
cd docker-compose
docker info
docker-compose --version
docker-compose -f $compose_file config
echo "Starting Alfresco in Docker container"
docker-compose ps
docker-compose -f $compose_file pull
export COMPOSE_HTTP_TIMEOUT=120
docker-compose -f $compose_file up -d
# docker-compose up
WAIT_INTERVAL=1
COUNTER=0
TIMEOUT=300
t0=`date +%s`
echo "Waiting for alfresco to start"
response=$(curl --write-out %{http_code} --output /dev/null --silent http://localhost:$alf_port/alfresco/)
until [[ "200" -eq "$response" ]] || [[ "$COUNTER" -eq "$TIMEOUT" ]]; do
    printf '.'
    sleep $WAIT_INTERVAL
    COUNTER=$((COUNTER + WAIT_INTERVAL))
    response=$(curl --write-out %{http_code} --output /dev/null --silent http://localhost:$alf_port/alfresco/)
done
if (("$COUNTER" < "$TIMEOUT")) ; then
    t1=`date +%s`
    delta=$(((t1 - t0)/60))
    echo "Alfresco Started in $delta minutes"
else
    echo "Waited $COUNTER seconds"
    echo "Alfresco could not start in time."
    echo "The last response code from /alfresco/ was $response"
    exit 1
fi
COUNTER=0
echo "Waiting for share to start"
response=$(curl --write-out %{http_code} --output /dev/null --silent http://localhost:8080/share/page)
until [[ "200" -eq "$response" ]] || [[ "$COUNTER" -eq "$TIMEOUT" ]]; do
    printf '.'
    sleep $WAIT_INTERVAL
    COUNTER=$((COUNTER + WAIT_INTERVAL))
    response=$(curl --write-out %{http_code} --output /dev/null --silent http://localhost:8080/share/page)
done
if (("$COUNTER" < "$TIMEOUT")) ; then
    t1=`date +%s`
    delta=$(((t1 - t0)/60))
    echo "Share Started in $delta minutes"
else
    echo "Waited $COUNTER seconds"
    echo "Share could not start in time."
    echo "The last response code from /share/ was $response"
    exit 1
fi
COUNTER=0
TIMEOUT=20
echo "Waiting more time for SOLR"
response=$(curl --write-out %{http_code} --user admin:admin --output /dev/null --silent http://localhost:$alf_port/alfresco/s/api/solrstats)
until [[ "200" -eq "$response" ]] || [[ "$COUNTER" -eq "$TIMEOUT" ]]; do
    printf '.'
    sleep $WAIT_INTERVAL
    COUNTER=$((COUNTER + WAIT_INTERVAL))
    response=$(curl --write-out %{http_code} --user admin:admin --output /dev/null --silent http://localhost:$alf_port/alfresco/s/api/solrstats)
done
cd ../test/postman/docker-compose
docker run -a STDOUT --volume $PWD:/etc/newman --network host postman/newman_alpine33:3.9.2 run "acs-test-docker-compose-collection.json" --global-var "protocol=http" --global-var "url=localhost:8080"
fi
