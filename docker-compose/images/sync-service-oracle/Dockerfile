FROM curlimages/curl:8.13.0 AS ojdbc

ARG OJDBC_URL="https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc11/23.8.0.25.04/ojdbc11-23.8.0.25.04.jar"
RUN curl -fL "$OJDBC_URL" -o /tmp/ojdbc11.jar

FROM quay.io/alfresco/service-sync:5.3.2
COPY --from=ojdbc /tmp/ojdbc11.jar /opt/alfresco-sync-service/connectors/ojdbc11.jar

