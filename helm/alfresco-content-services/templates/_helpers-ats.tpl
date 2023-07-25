{{/*
Local transformers config
*/}}
{{- define "alfresco-content-service.localTransformConfig" -}}
-DlocalTransform.core-aio.url=
-DlocalTransform.pdfrenderer.url=http://{{ template "alfresco-transform-service.deployment-pdfrenderer.name" . }}
-DlocalTransform.imagemagick.url=http://{{ template "alfresco-transform-service.deployment-imagemagick.name" . }}
-DlocalTransform.libreoffice.url=http://{{ template "alfresco-transform-service.deployment-libreoffice.name" . }}
-DlocalTransform.tika.url=http://{{ template "alfresco-transform-service.deployment-tika.name" . }}
-DlocalTransform.misc.url=http://{{ template "alfresco-transform-service.deployment-transform-misc.name" . }}
{{- end -}}

{{/*
ATS Tengines config
*/}}
{{- define "alfresco-content-service.tengineConfig" -}}
-Dalfresco-pdf-renderer.url=http://{{ template "alfresco-transform-service.deployment-pdfrenderer.name" . }}
-Dimg.url=http://{{ template "alfresco-transform-service.deployment-imagemagick.name" . }}
-Djodconverter.url=http://{{ template "alfresco-transform-service.deployment-libreoffice.name" . }}
-Dtika.url=http://{{ template "alfresco-transform-service.deployment-tika.name" . }}
-Dtransform.misc.url=http://{{ template "alfresco-transform-service.deployment-transform-misc.name" . }}
{{- end -}}

{{/*
Get Alfresco Content Service configuration for Alfresco Transform Service
*/}}
{{- define "alfresco-content-service.atsConfig" -}}
{{- $atsCtx := (dict "Values" (index .Values "alfresco-transform-service") "Chart" $.Chart "Release" $.Release) }}
{{ template "alfresco-content-service.localTransformConfig" $atsCtx }}
{{- if and $atsCtx.Values.filestore.enabled $atsCtx.Values.transformrouter.enabled }}
{{- $routerCtx := (dict "Values" (dict "nameOverride" "router" ) "Chart" .Chart "Release" .Release) }}
{{- $sfsCtx := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
-Dtransform.service.url=http://{{ template "alfresco-transform-service.deployment-transform-router.name" $atsCtx }}
-Dsfs.url=http://{{ template "alfresco-transform-service.deployment-filestore.name" $atsCtx }}
{{ template "alfresco-content-service.tengineConfig" $atsCtx }}
{{- end }}
{{- end }}
