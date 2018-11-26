#!/usr/bin/env bash
# this will serve the charts created locally
kill $(pgrep helm) # kill the helm repo if is opened
helm serve &
HELM_PID=$!
echo "Serving local charts using helm, on PID:$HELM_PID"
