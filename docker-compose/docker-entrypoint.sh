#!/bin/bash

# Check if the architecture is ARM64 (aarch64)
if [[ "$(uname -m)" != "x86_64" ]]; then
  export LIBREOFFICE_HOME=${LIBREOFFICE_HOME:=/usr/lib64/libreoffice}
fi

# Run the Alfresco transformation service JAR file with the specified Java options
exec java $JAVA_OPTS -jar /usr/bin/${1}.jar "$@"
