# Alfresco Content Services Docker Compose Deployment

This page describes how to quickly deploy Alfresco Content Services (ACS) using Docker Compose.

The system deployed is shown in the diagram below.

![Docker Compose Deployment Components](/docs/docker-compose/diagrams/docker-compose-components.png)

## Considerations

The Docker Compose file is undergoing continual development and improvement, and should not be used "as is" for your production environments, but should help you save time and effort deploying Alfresco Content Services for your organisation.

## Prerequisites

* [Docker](https://www.docker.com/products/docker-desktop)
* [Docker Compose](https://docs.docker.com/compose/install)
* Quay.io credentials requested by logging a ticket with [Alfresco Support](https://support.alfresco.com/)

## Deploy

1. Clone this repository or download the [docker-compose](../../docker-compose/docker-compose.yml) file.
2. Navigate to the folder where the _docker-compose.yml_ file is located.
3. Log in to Quay.io with your credentials: ```docker login quay.io```
4. Run ```docker-compose up```
5. Navigate to the Admin Console and apply your trial license:
   * [http://<machine_ip>:8080/alfresco/service/enterprise/admin/admin-license](http://localhost:8080/alfresco/service/enterprise/admin/admin-license) (```<machine_ip>``` will usually just be ```localhost```)
   * Default username and password is ```admin```
   * See [Uploading a new license](https://docs.alfresco.com/6.1/tasks/at-adminconsole-license.html) for more details
6. Open the following URLs in your browser to check that everything starts up:
   * Administration and REST APIs: [http://<machine_ip>:8080/alfresco](http://localhost:8080/alfresco)
   * Alfresco Digital Workspace: [http://<machine_ip>:8080/workspace](http://localhost:8080/workspace)
   * Share: [http://<machine_ip>:8080/share](http://localhost:8080/share)
   * Search administration: [http://<machine_ip>:8083/solr](http://localhost:8083/solr)

### Notes

Make sure that exposed ports are open on your host. Check the _docker-compose.yml_ file to determine the exposed ports - refer to the ```host:container``` port definitions. You'll see they include 5432, 8080, 8083 and others.

If Docker is running on your local machine, the IP address will be just _localhost_.

If you're using the [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows), run the following command to find the IP address:
```bash
docker-machine ip
```

## Configure

#### Alfresco Content Repository
| Property | Description | Default value |
|----------|-------------|---------------|
| JAVA_TOOL_OPTIONS | Adding this environment variable, allows to set sensible values (like passwords) that are not passed as arguments to the Java Process. | "-Dparam=value ..." |
| JAVA_OPTS | A set of properties that are picked up by the JVM inside the container | "-Dparam=value ..." |

#### Alfresco Share
| Property | Description | Default value |
|----------|-------------|---------------|
| REPO_HOST | Share needs to know how to register itself with Alfresco | alfresco |
| REPO_PORT | Share needs to know how to register itself with Alfresco | 8080 |
| JAVA_OPTS | A set of properties that are picked up by the JVM inside the container | "-Dparam=value ..." |

#### Alfresco Digital Workspace
| Property | Description | Default value |
|----------|-------------|---------------|
| BASE_PATH |  | ./ |
| APP_CONFIG_OAUTH2_HOST | The address of the Identity Service including the realm name configured. | "\<url\>" |
| APP_CONFIG_AUTH_TYPE | The authentication type. To use Single Sign-on mode you must change this property to OAUTH. | "BASIC"  |
| APP_CONFIG_OAUTH2_CLIENTID | The name of the client configured for Digital Workspace |  |
| APP_CONFIG_OAUTH2_REDIRECT_SILENT_IFRAME_URI | The address that Digital Workspace uses to refresh authorization tokens. |  |
| APP_CONFIG_OAUTH2_REDIRECT_LOGIN | The URL to redirect to after a user is successfully authenticated |  |
| APP_CONFIG_OAUTH2_REDIRECT_LOGOUT | The URL to redirect to after a user successfully signs out |  |
| APP_BASE_SHARE_URL | Base Share URL |  e.g. '{protocol}//{hostname}{:port}/workspace/#/preview/s' |
| AUTH_TYPE | The authentication type. To use Single Sign-on mode you must change this property to OAUTH. | "BASIC" |
| PROVIDER |  | "ALL" |
| ENVIRONMENT_SUFFIX | Only for Process Cloud instance | "_CLOUD" |
| API_HOST |  | "\<url\>" |
| API_CONTENT_HOST |  | "\<url\>" |
| API_CONTENT_HOST_LOCAL |  | "http://localhost:8080" |
| API_PROCESS_HOST |  | "\<url\>" |
| OAUTH_HOST |  | "\<url\>" |
| IDENTITY_HOST | The address of the Identity Service including the realm name configured. | "\<url\>" |
| E2E_HOST |  | "http://localhost" |
| E2E_PORT |  | "80" |
| API_HOST_CLOUD |  | "\<url\>" |
| API_CONTENT_HOST_CLOUD |  | "\<url\>" |
| API_PROCESS_HOST_CLOUD |  | "\<url\>" |
| OAUTH_HOST_CLOUD |  | "\<url\>" |
| IDENTITY_HOST_CLOUD |  | "\<url\>" |
| E2E_HOST_CLOUD |  | "http://localhost" |
| E2E_PORT_CLOUD |  | "4200" |
| APP_CONFIG_APPS_DEPLOYED | The name of the application deployed | "[{"name": "\<the name of the application deployed\>"}]" |

#### Alfresco Search Services (solr6)
| Property | Description | Default value |
|----------|-------------|---------------|
| SOLR_ALFRESCO_HOST | Solr needs to know how to register itself with Alfresco | "alfresco"  |
| SOLR_ALFRESCO_PORT | Solr needs to know how to register itself with Alfresco | 8080 |
| SOLR_SOLR_HOST | Alfresco needs to know how to call solr | "solr6" |
| SOLR_SOLR_PORT | Alfresco needs to know how to call solr | 8983 |
| SOLR_CREATE_ALFRESCO_DEFAULTS | Create the default alfresco and archive cores | "alfresco,archive" |
| SOLR_OPTS | Options to pass when starting the Java process. | e.g. "-Dparam=value ..." |
| SOLR_HEAP | The Java heap assigned to Solr. | e.g. 2g |
| SOLR_JAVA_MEM | The exact memory settings for Solr. Note that SOLR_HEAP takes precedence over this. | "-Xms2g -Xmx2g"|
| MAX_SOLR_RAM_PERCENTAGE | The percentage of available memory (an integer value) to assign to Solr. Note that SOLR_HEAP and SOLR_JAVA_MEM take precedence over this. | e.g. 2 |
| SEARCH_LOG_LEVEL | The root logger level. | ERROR, WARN, INFO, DEBUG or TRACE |
| ENABLE_SPELLCHECK | Whether spellchecking is enabled or not. | true or false |
| DISABLE_CASCADE_TRACKING | Whether cascade tracking is enabled or not. Disabling cascade tracking will improve performance, but result in some feature loss (e.g. path queries). | true or false |
| ALFRESCO_SECURE_COMMS | Whether communication with the repository is secured. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md) for more details. | https or none |
| SOLR_SSL_KEY_STORE | Path to SSL key store. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md#use-alfresco-search-services-docker-image-with-docker-compose) for more details. |  |
| SOLR_SSL_KEY_STORE_PASSWORD | Password for key store. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md#use-alfresco-search-services-docker-image-with-docker-compose) for more details. |  |
| SOLR_SSL_KEY_STORE_TYPE | Key store type. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md#use-alfresco-search-services-docker-image-with-docker-compose) for more details. | JCEKS |
| SOLR_SSL_TRUST_STORE | Path to SSL trust store. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md#use-alfresco-search-services-docker-image-with-docker-compose) for more details. |  |
| SOLR_SSL_TRUST_STORE_PASSWORD | Password for trust store. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md#use-alfresco-search-services-docker-image-with-docker-compose) for more details. |  |
| SOLR_SSL_TRUST_STORE_TYPE | Trust store type. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md#use-alfresco-search-services-docker-image-with-docker-compose) for more details. | JCEKS |
| SOLR_SSL_NEED_CLIENT_AUTH | This variable is used to configure SSL. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md#use-alfresco-search-services-docker-image-with-docker-compose) for more details. | true or false |
| SOLR_SSL_WANT_CLIENT_AUTH | This variable is used to configure SSL. See this [page](https://github.com/Alfresco/InsightEngine/blob/master/search-services/README.md#use-alfresco-search-services-docker-image-with-docker-compose) for more details. | true or false |

#### Alfresco Transform Router
| Property | Description | Default value |
|----------|-------------|---------------|
| JAVA_OPTS | A set of properties that are picked up by the JVM inside the container | "-Dparam=value ..." |
| ACTIVEMQ_URL | ActiveMQ URL (in this case the name of the container is used) | "nio://activemq:61616" |
| CORE_AIO_URL | Transform core AIO URL (in this case the name of the container is used) | "http://transform-core-aio:8090" |
| FILE_STORE_URL | Shared file store URL (in this case the name of the container is used) | "http://shared-file-store:8099/alfresco/api/-default-/private/sfs/versions/1/file" |

#### Alfresco Transform Core AIO
| Property | Description | Default value |
|----------|-------------|---------------|
| JAVA_OPTS | A set of properties that are picked up by the JVM inside the container | "-Dparam=value ..." |
| ACTIVEMQ_URL | ActiveMQ URL (in this case the name of the container is used) | "nio://activemq:61616" |
| FILE_STORE_URL | Shared file store URL (in this case the name of the container is used) | "http://shared-file-store:8099/alfresco/api/-default-/private/sfs/versions/1/file" |

#### Alfresco Shared File Store
| Property | Description | Default value |
|----------|-------------|---------------|
| JAVA_OPTS | A set of properties that are picked up by the JVM inside the container | "-Dparam=value ..." |
| fileStorePath | Shared File Store content storing path | /tmp/Alfresco |
| scheduler.contract.path | Cleanup Scheduler contract path | /tmp/scheduler.json |
| scheduler.content.age.millis | Content retention period | 86400000 |
| scheduler.cleanup.interval | Cleanup Scheduler interval | 86400000 |

#### Alfresco Sync Service
| Property | Description | Default value |
|----------|-------------|---------------|
| JAVA_OPTS | A set of properties that are picked up by the JVM inside the container | "-Dparam=value ..." |

## Cleanup

To bring the system down and cleanup the containers run the following command:

```bash
docker-compose down
```

## Troubleshooting

If you have issues running ```docker-compose up``` after deleting a previous Docker Compose cluster, try replacing step 4 with the following command:

```bash
docker-compose down && docker-compose build --no-cache && docker-compose up
```
