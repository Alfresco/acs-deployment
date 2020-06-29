#!/bin/bash
docker info
docker-compose --version

docker-compose config
echo "Starting Alfresco in Docker container"
docker-compose ps
docker-compose pull
COMPOSE_HTTP_TIMEOUT=120 docker-compose up -d
# docker-compose up

WAIT_INTERVAL=1
COUNTER=0
TIMEOUT=300
t0=`date +%s`

echo "Waiting for alfresco to start"
response=$(curl --write-out %{http_code} --output /dev/null --silent http://localhost:8080/alfresco/)
until [ "200" -eq "$response" ] || [ "$COUNTER" -eq "$TIMEOUT" ]; do
   printf '.'
   sleep $WAIT_INTERVAL
   COUNTER=$(($COUNTER+$WAIT_INTERVAL))
   response=$(curl --write-out %{http_code} --output /dev/null --silent http://localhost:8080/alfresco/)
done

if (("$COUNTER" < "$TIMEOUT")) ; then
   t1=`date +%s`
   delta=$((($t1 - $t0)/60))
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
until [ "200" -eq "$response" ] || [ "$COUNTER" -eq "$TIMEOUT" ]; do
   printf '.'
   sleep $WAIT_INTERVAL
   COUNTER=$(($COUNTER+$WAIT_INTERVAL))
   response=$(curl --write-out %{http_code} --output /dev/null --silent http://localhost:8080/share/page)
done

if (("$COUNTER" < "$TIMEOUT")) ; then
   t1=`date +%s`
   delta=$((($t1 - $t0)/60))
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
until [ "$COUNTER" -eq "$TIMEOUT" ]; do
   printf '.'
   sleep $WAIT_INTERVAL
   COUNTER=$(($COUNTER+$WAIT_INTERVAL))
done