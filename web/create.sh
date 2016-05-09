#!/usr/bin/env bash
# Create the web server


kubectl create configmap nginx-conf --from-file=nginx.conf

kubectl create -f web.yaml
