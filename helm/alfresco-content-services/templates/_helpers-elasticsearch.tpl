{{- define "repo.elasticsearch.config" -}}
-Dindex.subsystem.name=elasticsearch
-Delasticsearch.host={{ index .Values "alfresco-elasticsearch-connector" "elasticsearch" "host" | default .Values.global.elasticsearch.host }}
-Delasticsearch.port={{ index .Values "alfresco-elasticsearch-connector" "elasticsearch" "port" | default .Values.global.elasticsearch.port }}
-Delasticsearch.user={{ index .Values "alfresco-elasticsearch-connector" "elasticsearch" "user" | default .Values.global.elasticsearch.user }}
-Delasticsearch.password={{ index .Values "alfresco-elasticsearch-connector" "elasticsearch" "password" | default .Values.global.elasticsearch.password }}
-Delasticsearch.createIndexIfNotExists=true
-Delasticsearch.indexName={{ index .Values "alfresco-elasticsearch-connector" "indexName" }}
{{- end -}}
