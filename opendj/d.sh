#!/bin/bash
# for testing


kubectl delete petset opendj
kubectl delete pod opendj-0
kubectl delete pod opendj-1

kubectl delete configmap djconfig
kubectl create configmap djconfig --from-file=djconfig=setup.sh --from-file=replicate=replicate.sh


echo "Run the following"
echo kubectl create -f opendj.yaml



