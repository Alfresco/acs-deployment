{{/*
Local transformers config
*/}}
{{- define "alfresco-content-services.localTransformConfig" -}}
localTransform.core-aio.url=
localTransform.pdfrenderer.url=http://{{ template "alfresco-transform-service.deployment-pdfrenderer.name" . }}
localTransform.imagemagick.url=http://{{ template "alfresco-transform-service.deployment-imagemagick.name" . }}
localTransform.libreoffice.url=http://{{ template "alfresco-transform-service.deployment-libreoffice.name" . }}
localTransform.tika.url=http://{{ template "alfresco-transform-service.deployment-tika.name" . }}
localTransform.misc.url=http://{{ template "alfresco-transform-service.deployment-transform-misc.name" . }}
{{- end -}}

{{/*
ATS Tengines config
*/}}
{{- define "alfresco-content-services.tengineConfig" -}}
alfresco-pdf-renderer.url=http://{{ template "alfresco-transform-service.deployment-pdfrenderer.name" . }}
img.url=http://{{ template "alfresco-transform-service.deployment-imagemagick.name" . }}
jodconverter.url=http://{{ template "alfresco-transform-service.deployment-libreoffice.name" . }}
tika.url=http://{{ template "alfresco-transform-service.deployment-tika.name" . }}
transform.misc.url=http://{{ template "alfresco-transform-service.deployment-transform-misc.name" . }}
{{- end -}}

{{/*
Get Alfresco Content Service configuration for Alfresco Transform Service
*/}}
{{- define "alfresco-content-services.atsConfig" -}}
{{- $atsCtx := (dict "Values" (index .Values "alfresco-transform-service") "Chart" $.Chart "Release" $.Release) }}
{{ template "alfresco-content-services.localTransformConfig" $atsCtx }}
{{- if and $atsCtx.Values.filestore.enabled $atsCtx.Values.transformrouter.enabled }}
{{- $routerCtx := (dict "Values" (dict "nameOverride" "router" ) "Chart" .Chart "Release" .Release) }}
{{- $sfsCtx := (dict "Values" (dict "nameOverride" "filestore" ) "Chart" .Chart "Release" .Release) }}
transform.service.url=http://{{ template "alfresco-transform-service.deployment-transform-router.name" $atsCtx }}
sfs.url=http://{{ template "alfresco-transform-service.deployment-filestore.name" $atsCtx }}
{{ template "alfresco-content-services.tengineConfig" $atsCtx }}
{{- end }}
{{- end }}
