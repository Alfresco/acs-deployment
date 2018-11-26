#!/usr/bin/env bash
if [ $# -lt 1 ]; then
   echo "Please pass the current version as first parameter so I can generate the new version!" 
   echo "Example: $ $0 0.0.2 #will generate 0.0.3" 
   exit 1 
fi
set -e
echo $1 | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}'