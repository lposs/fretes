#!/bin/bash

# See https://github.com/kubernetes/contrib/tree/master/ingress/controllers/nginx

P="https://raw.githubusercontent.com/kubernetes/contrib/master/ingress/controllers/nginx"

# Create the default http backend
curl -s "$P/examples/default-backend.yaml" | kubectl create -f -
kubectl expose rc default-http-backend --port=80 --target-port=8080 --name=default-http-backend

# Create the custom nginx
kubectl create -f nginx-conf.yaml
kubectl create -f rc-default.yaml

