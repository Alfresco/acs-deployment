# Installing AMPs

This document describes options that can be used to install AMP files into Alfresco Content Repository and Alfresco Share images. These custom images can then be deployed using docker-compose.

To install an amp, you must create a custom image from Alfresco's Docker images which contains the installed AMP. This process requires some familiarty with [Docker](https://www.docker.com/) and specifically [Dockerfile commands](https://docs.docker.com/engine/reference/builder/).

An example approach is:

## Setting up

1. Clone this git hub repository and change directory to acs-deployment
```bash
git clone https://github.com/Alfresco/acs-deployment.git && \
cd acs-deployment
```
2. Switch to the correct tag for the ACS version required. These are indexed [here](https://github.com/Alfresco/acs-deployment#versioning), for example below we are using tag 4.1.0 which equates to ACS 6.2.2
```bash
git checkout 4.1.0
```
3. Switch to the docker-compose directory, then create directories to hold AMP files and Dockerfiles
```bash
cd docker-compose && \
mkdir -p repository/amps share/share_amps && \
touch repository/Dockerfile share/Dockerfile
```
4. Copy your Alfresco AMP files to the newly created `repository/amps` directory and copy your Share AMP files to the newly crated `share/share_amps` directory.

## Custom Alfresco Content Repository Image

You will now need to install the AMP files into the Alfresco Content Repository image.

1. Take note of the image and tag being used in docker-compose.yml for the **alfresco** docker-compose service. For example, if you are using acs-deployment github tag 4.1.0, you will find this on [line 15](https://github.com/Alfresco/acs-deployment/blob/4.1.0/docker-compose/docker-compose.yml#L15) as follows:
```
alfresco/alfresco-content-repository:6.2.2
```
**Make sure you are looking at docker-compose.yml from the correct github repository tag.**
2. Add the following Docker commands to the repository/Dockerfile file and save, making sure to change the image name and tag to match from the above step:
```Dockerfile
FROM alfresco/alfresco-content-repository:6.2.2

# Customize container: install amps

ARG TOMCAT_DIR=/usr/local/tomcat

USER root

ADD ./amps/*.amp ${TOMCAT_DIR}/amps/

RUN java -jar ${TOMCAT_DIR}/alfresco-mmt/alfresco-mmt*.jar install \
	${TOMCAT_DIR}/amps ${TOMCAT_DIR}/webapps/alfresco -directory -nobackup -verbose

USER alfresco
```
**NOTE:** In the above example RUN docker command, alfresco-mmt jar is run with -directory, -nobackup and -verbose options. You must make sure these are suitable for your requirements. Documentation on alfresco-mmt can be found [here](https://docs.alfresco.com/6.2/concepts/dev-extensions-modules-management-tool.html).
3. Build the image, make sure you give the image an appropriate name and tag so you can easily identify the image afterwards. In the below example, you will want to replace `myregistrydomain/my-custom-alfresco-content-repository:6.2.2` and `myregistrydomain/my-custom-alfresco-content-repository:latest` with your own Docker registry, image name and tag as per your requirements.
```bash
docker build repository -t myregistrydomain/my-custom-alfresco-content-repository:6.2.2 -t myregistrydomain/my-custom-alfresco-content-repository:latest
```
Once the image build is complete, you should see successful messages similar to the below:
```
Successfully built 632eda3ea296
Successfully tagged myregistrydomain/my-custom-alfresco-content-repository:6.2.2
Successfully tagged myregistrydomain/my-custom-alfresco-content-repository:latest
```
4. Replace the image used by the alfresco service in docker-compose.yml, for example with tag 4.1.0 and using the above custom images:
**replace**
`image: alfresco/alfresco-content-repository:6.2.2`
**with**
`image: myregistrydomain/my-custom-alfresco-content-repository:6.2.2`
5. Save docker-compose.yml

## Custom Alfresco Share Image

We will now repeat the process for the Alfresco Share image.

1. Take note of the image and tag being used in the docker-compose.yml file for the **share** docker-compose service. For example, if you are using acs-deployment github tag 4.1.0, you will find this on [line 93](https://github.com/Alfresco/acs-deployment/blob/4.1.0/docker-compose/docker-compose.yml#L93) as follows:
```
alfresco/alfresco-share:6.2.2
```
**Make sure you are looking at docker-compose.yml from the correct github repository tag.**
2. Add the following Docker commands to the share/Dockerfile file and save, making sure to change the image name and tag to match from the above step:
```Dockerfile
FROM alfresco/alfresco-share:6.2.2

ARG TOMCAT_DIR=/usr/local/tomcat

ADD ./share_amps/*.amp ${TOMCAT_DIR}/amps_share/

RUN java -jar ${TOMCAT_DIR}/alfresco-mmt/alfresco-mmt*.jar install \
	${TOMCAT_DIR}/amps_share ${TOMCAT_DIR}/webapps/share -directory -nobackup -verbose
```
**NOTE:** In the above example RUN docker command, alfresco-mmt jar is run with -directory, -nobackup and -verbose options. You must make sure these are suitable for your requirements. Documentation on alfresco-mmt can be found [here](https://docs.alfresco.com/6.2/concepts/dev-extensions-modules-management-tool.html).
3. Build the image, make sure you give the image an appropriate name and tag so you can easily identify the image afterwards. In the below command, you will want to replace `myregistrydomain/my-custom-alfresco-share:6.2.2` and `myregistrydomain/my-custom-alfresco-share:latest` with your own Docker registry, image name and tag as per your requirements.
```bash
docker build share -t myregistrydomain/my-custom-alfresco-share:6.2.2 -t myregistrydomain/my-custom-alfresco-share:latest
```
Once the image build is complete, you should see successful messages similar to the below:
```
Successfully built 6d5ee67935da
Successfully tagged myregistrydomain/my-custom-alfresco-share:6.2.2
Successfully tagged myregistrydomain/my-custom-alfresco-share:latest
```
4. Replace the image used by the alfresco service in docker-compose.yml, for example with tag 4.1.0 and using the above custom images:
**replace**
`image: alfresco/alfresco-share:6.2.2`
**with**
`image: myregistrydomain/my-custom-alfresco-share:6.2.2`
5. Save docker-compose.yml

## Start up the docker-compose service

You have now built two custom images (one for Alfresco Content Repository and one for Alfreso Share). These have been added to your docker-compose.yml services.

You can start your custom docker-compose.yml using the following command:
```
docker-compose up
```
Further information on starting up or troubleshooting can be found [here](https://github.com/Alfresco/acs-deployment/tree/master/docs/docker-compose).
