# alfresco-repo — Custom Alfresco image with customDictModel loaded on classpath
ARG BASE_IMAGE=alfresco/alfresco-content-repository:latest
FROM ${BASE_IMAGE} AS alfresco-content-repository

ARG ALF_GROUP=Alfresco
ARG TOMCAT_DIR=/usr/local/tomcat

USER root

# Add custom model to Alfresco classpath
COPY model/customDictModel.xml \
     ${TOMCAT_DIR}/shared/classes/alfresco/model/customDictModel.xml

RUN chgrp -R ${ALF_GROUP} ${TOMCAT_DIR}/shared && \
    find ${TOMCAT_DIR}/shared -type f -exec chmod 0640 {} \;

USER alfresco

# cd-init — Python script that seeds Cascading Dictionary data via REST API
FROM python:3.9-slim AS cd-init
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY cd-init.py .
COPY data/ ./data/
CMD ["python", "./cd-init.py"]
