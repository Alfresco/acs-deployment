{{/*
Local transformers config
*/}}
{{- define "alfresco-content-services.localTransformConfig" -}}
localTransform.core-aio.url=
localTransform.pdfrenderer.url=http://{{ template "alfresco-transform-service.pdfrenderer.fullname" . }}
localTransform.imagemagick.url=http://{{ template "alfresco-transform-service.imagemagick.fullname" . }}
localTransform.libreoffice.url=http://{{ template "alfresco-transform-service.libreoffice.fullname" . }}
localTransform.tika.url=http://{{ template "alfresco-transform-service.tika.fullname" . }}
localTransform.misc.url=http://{{ template "alfresco-transform-service.transform-misc.fullname" . }}
{{- end -}}

{{/*
ATS Tengines config
*/}}
{{- define "alfresco-content-services.tengineConfig" -}}
alfresco-pdf-renderer.url=http://{{ template "alfresco-transform-service.pdfrenderer.fullname" . }}
img.url=http://{{ template "alfresco-transform-service.imagemagick.fullname" . }}
jodconverter.url=http://{{ template "alfresco-transform-service.libreoffice.fullname" . }}
tika.url=http://{{ template "alfresco-transform-service.tika.fullname" . }}
transform.misc.url=http://{{ template "alfresco-transform-service.transform-misc.fullname" . }}
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
transform.service.url=http://{{ template "alfresco-transform-service.transform-router.fullname" $atsCtx }}
sfs.url=http://{{ template "alfresco-transform-service.filestore.fullname" $atsCtx }}
{{ template "alfresco-content-services.tengineConfig" $atsCtx }}
{{- end }}
{{- end }}
