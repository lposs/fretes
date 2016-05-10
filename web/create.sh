#!/usr/bin/env bash
# Create the web server


# clean up old installs
kubectl delete configmap nginx-conf
kubectl delete -f web.yaml


kubectl create configmap nginx-conf --from-file=nginx.conf

kubectl create -f web.yaml
