{{/*
generate an ephemral volume name
*/}}
{{- define "alfresco.amps.vols" -}}
{{ toYaml .modules | sha1sum }}
{{- end -}}

{{/*
Alfresco modules initContainers
*/}}
{{- define "alfresco.amps.init" -}}
- name: get-amps
  image: curlimages/curl:8.00.1
  #image: "{{ .image.repository }}:{{ .image.tag }}"
  imagePullPolicy: {{ .image.pullPolicy }}
  {{- template "component-security-context" . }}
  resources:
    limits:
      cpu: "0.25"
      memory: "10Mi"
  command:
    - curl
  args:
    - --output-dir
    - /amps
    - -O
    - -Lv
    - >-
      {{- $urls := list }}
      {{- range .modules }}
      {{- $urls = append $urls (printf "%s/%s.%s" .url .name .type) }}
      {{- end }}
      {
      {{- join "," $urls -}}
      }
  volumeMounts:
    - mountPath: /amps
      name: {{ template "alfresco.amps.vols" . }}
- name: repack-amps
  image: alfresco/alfresco-base-java:jdk17-rockylinux8
  {{- template "component-security-context" . }}
  resources: {{- toYaml .resources | nindent 4 }}
  command:
    - /bin/bash
    - -xec
  args:
    - |
      cd /amps
      [ -d jars ] || mkdir jars
      [ ! -f *.jar ] || mv *.jar jars
      for AMP in $(ls /amps/*.amp); do
        mkdir amp && cd $_
        jar xf $AMP
        module_id=$(grep 'module\.id' module.properties | cut -d= -f 2 | tr -d '[:cntrl:]')
        echo "repackaging $module_id..."
        [ -d "config/alfresco/module/${module_id}" ] || mkdir -p "config/alfresco/module/${module_id}"
        mv module.properties config/alfresco/module/${module_id}
        jar -c -f ${AMP%.amp}-classes.jar -C config/ .
        cd ../ && rm -rf amp
      done
  volumeMounts:
    - mountPath: /amps
      name: {{ template "alfresco.amps.vols" . }}
{{- end -}}
