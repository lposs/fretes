#!/bin/bash
# Tear down the ingress

kubectl delete -f ingress.yaml
kubectl delete rc default-http-backend
kubectl delete svc default-http-backend
kubectl delete configmap tcp-configmap
kubectl delete configmap nginx-load-balancer-conf

