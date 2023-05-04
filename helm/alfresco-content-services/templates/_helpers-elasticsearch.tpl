{{- define "repo.elasticsearch.config" -}}
{{- if eq (index .Values "alfresco-search-enterprise" "elasticsearch" "protocol" | default .Values.global.elasticsearch.protocol) "https" }}
-Delasticsearch.secureComms=https
{{- end }}
-Delasticsearch.host={{ index .Values "alfresco-search-enterprise" "elasticsearch" "host" | default .Values.global.elasticsearch.host }}
-Delasticsearch.port={{ index .Values "alfresco-search-enterprise" "elasticsearch" "port" | default .Values.global.elasticsearch.port }}
-Delasticsearch.user={{ index .Values "alfresco-search-enterprise" "elasticsearch" "user" | default .Values.global.elasticsearch.user }}
-Delasticsearch.password={{ index .Values "alfresco-search-enterprise" "elasticsearch" "password" | default .Values.global.elasticsearch.password }}
-Delasticsearch.createIndexIfNotExists=true
-Delasticsearch.indexName={{ index .Values "alfresco-search-enterprise" "indexName" }}
{{- end -}}
