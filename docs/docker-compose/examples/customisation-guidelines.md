---
title: Customisation Guidelines
parent: Docker Compose
---

# Customisation Guidelines

Although it's possible to change and mount files/folders into existing Docker images the recommended approach is to create new custom Docker images.

Installling AMPs also requires the creation of a custom image, this guide describes the steps required to install AMP files into Alfresco Content Repository and Alfresco Share images. These custom images can then be deployed using Docker Compose.

This process requires some familiarty with [Docker](https://www.docker.com/) and specifically [Dockerfile commands](https://docs.docker.com/engine/reference/builder/).

## Setting Up

1. Clone this repository and change directory to acs-deployment

    ```bash
    git clone https://github.com/Alfresco/acs-deployment.git
    cd acs-deployment
    ```

2. Switch to the `docker-compose` directory, then create directories to hold AMP files and Dockerfiles

    ```bash
    cd docker-compose && \
    mkdir -p repository/amps share/share_amps && \
    touch repository/Dockerfile share/Dockerfile
    ```

3. Copy your Alfresco AMP files to the newly created `repository/amps` directory and copy your Share AMP files to the newly crated `share/share_amps` directory.

## Create Custom Alfresco Content Repository Image

You will now need to install the AMP files into the Alfresco Content Repository image.

1. The `docker-compose` folder contains a file for each main code line of ACS, examine the relevant docker compose file for the version of ACS you want to apply the AMPs to. For example, to apply to the latest version of 7.3 take a look at the [7.3.N-docker-compose file](https://github.com/Alfresco/acs-deployment/blob/master/docker-compose/7.3.N-compose.yaml)

2. Take note of the image and tag being used for the **alfresco** service in the docker compose file you chose in the previous step. For example, if you are using 7.3.N-compose.yaml, you will find this on [line 21](https://github.com/Alfresco/acs-deployment/blob/master/docker-compose/7.3.N-compose.yaml) as follows:

    ```bash
    alfresco/alfresco-content-repository:7.3.0.1
    ```

3. Add the following Docker commands to the repository/Dockerfile file and save, making sure to change the image name and tag to match from the above step:

    ```Dockerfile
    FROM alfresco/alfresco-content-repository:7.3.0.1

    # Customize container: install amps

    ARG ALF_GROUP=Alfresco
    ARG TOMCAT_DIR=/usr/local/tomcat

    USER root

    ADD ./amps/*.amp ${TOMCAT_DIR}/amps/

    RUN java -jar ${TOMCAT_DIR}/alfresco-mmt/alfresco-mmt*.jar install \
        ${TOMCAT_DIR}/amps ${TOMCAT_DIR}/webapps/alfresco -directory -nobackup -verbose

    # Restore permissions
    RUN chgrp -R ${ALF_GROUP} ${TOMCAT_DIR}/webapps && \
        find ${TOMCAT_DIR}/webapps -type d -exec chmod 0750 {} \; && \
        find ${TOMCAT_DIR}/webapps -type f -exec chmod 0640 {} \; && \
        find ${TOMCAT_DIR}/shared -type d -exec chmod 0750 {} \; && \
        find ${TOMCAT_DIR}/shared -type f -exec chmod 0640 {} \; && \
        chmod -R g+r ${TOMCAT_DIR}/webapps && \
        chgrp -R ${ALF_GROUP} ${TOMCAT_DIR}

    USER alfresco
    ```

    > **NOTE:** In the above example RUN docker command, alfresco-mmt jar is run with -directory, -nobackup and -verbose options. You must make sure these are suitable for your requirements. Documentation on alfresco-mmt can be found [here](https://docs.alfresco.com/7.3/concepts/dev-extensions-modules-management-tool.html).

4. Build the image, make sure you give the image an appropriate name and tag so you can easily identify the image afterwards. In the below example, you will want to replace `myregistrydomain/my-custom-alfresco-content-repository:7.3.0.1` and `myregistrydomain/my-custom-alfresco-content-repository:latest` with your own Docker registry, image name and tag as per your requirements

    ```bash
    docker build repository -t myregistrydomain/my-custom-alfresco-content-repository:0.2.2.1 -t myregistrydomain/my-custom-alfresco-content-repository:latest
    ```

    Once the image build is complete, you should see successful messages similar to the below:

    ```text
    Successfully built 632eda3ea296
    Successfully tagged myregistrydomain/my-custom-alfresco-content-repository:7.3.0.1
    Successfully tagged myregistrydomain/my-custom-alfresco-content-repository:latest
    ```

5. Replace the image used by the **alfresco** service in the compose file you chose to use in step 1, for example, **replace** `image: alfresco/alfresco-content-repository:7.3.0.1` **with** `image: myregistrydomain/my-custom-alfresco-content-repository:7.3.0.1`

6. Save the compose file

## Create Custom Alfresco Share Image

We will now repeat the process for the Alfresco Share image.

1. Take note of the image and tag being used for the **share** service in the docker compose file you chose in the previous section. For example, if you are using 7.3.N-compose.yaml, you will find this on [line 102](https://github.com/Alfresco/acs-deployment/blob/master/docker-compose/7.3.N-compose.yaml) as follows:

    ```bash
    alfresco/alfresco-share:7.3.0
    ```

2. Add the following Docker commands to the share/Dockerfile file and save, making sure to change the image name and tag to match from the above step:

    ```Dockerfile
    FROM alfresco/alfresco-share:7.3.0

    ARG TOMCAT_DIR=/usr/local/tomcat

    ADD ./share_amps/*.amp ${TOMCAT_DIR}/amps_share/

    RUN java -jar ${TOMCAT_DIR}/alfresco-mmt/alfresco-mmt*.jar install \
        ${TOMCAT_DIR}/amps_share ${TOMCAT_DIR}/webapps/share -directory -nobackup -verbose
    ```

    > **NOTE:** In the above example RUN docker command, alfresco-mmt jar is run with -directory, -nobackup and -verbose options. You must make sure these are suitable for your requirements. Documentation on alfresco-mmt can be found [here](https://docs.alfresco.com/7.3/concepts/dev-extensions-modules-management-tool.html).

3. Build the image, make sure you give the image an appropriate name and tag so you can easily identify the image afterwards. In the below command, you will want to replace `myregistrydomain/my-custom-alfresco-share:7.3.0` and `myregistrydomain/my-custom-alfresco-share:latest` with your own Docker registry, image name and tag as per your requirements

    ```bash
    docker build share -t myregistrydomain/my-custom-alfresco-share:7.3.0 -t myregistrydomain/my-custom-alfresco-share:latest
    ```

    Once the image build is complete, you should see successful messages similar to the below:

    ```text
    Successfully built 6d5ee67935da
    Successfully tagged myregistrydomain/my-custom-alfresco-share:7.3.0
    Successfully tagged myregistrydomain/my-custom-alfresco-share:latest
    ```

4. Replace the image used by the **share** service in the compose file you chose to use in the previous section, for example, **replace** `image: alfresco/alfresco-share:7.3.0` **with** `image: myregistrydomain/my-custom-alfresco-share:7.3.0`

5. Save the compose file

## Start The System

You have now built two custom images (one for Alfresco Content Repository and one for Alfreso Share). These have been added to your compose.yml services.

You can start your custom compose.yml using the following command:

```bash
docker compose -f <your-modified-compose.yml> up
```

Further information on starting up or troubleshooting can be found
[here](../README.md) and a more advanced example of building a custom image with
configuration can be found
[here](https://github.com/Alfresco/acs-packaging/blob/master/docs/create-custom-image-using-existing-docker-image.md).
