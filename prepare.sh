#!/bin/bash

# Anything we need to set up as pre-requisites


echo "If you are on GKE/GCE, create a cluster with:"
echo "misc/create-cluster.sh"

echo "Creating persistent volumes and claims"
kubectl create -f pv/pv-host.yaml
kubectl create -f pv/pvc.yaml

echo "If you want an ingress, and you are not on GKE/GCE, run:"
echo "ingress/create-nginix-ingress.sh"
