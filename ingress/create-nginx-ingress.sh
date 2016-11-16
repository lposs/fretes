#!/bin/bash

# See https://github.com/kubernetes/ingress

#P="https://raw.githubusercontent.com/kubernetes/contrib/master/ingress/controllers/nginx"

# Create the default http backend
kubectl create -f default-backend.yaml
kubectl expose rc default-http-backend --port=80 --target-port=8080 --name=default-http-backend

# Create the custom nginx
kubectl create -f nginx-conf.yaml
kubectl create -f tcp-configmap.yaml
kubectl create -f ingress.yaml



