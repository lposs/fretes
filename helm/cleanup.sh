#!/usr/bin/env bash

kubectl delete service openam
kubectl delete service opendj-config
kubectl delete configmap openam-config
kubectl delete secrets dj-secrets
kubectl delete secrets openam-secrets
kubectl delete ingress openam-ingress
kubectl delete job openam-config
kubectl delete deployments openam
kubectl delete deployments opendj-config
kubectl delete pvc data-opendj-configstore-0
