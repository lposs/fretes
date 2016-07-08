#!/bin/bash
# for testing


kubectl delete petset opendj
kubectl delete pod opendj-0
kubectl delete pod opendj-1


echo "Run the following"
echo kubectl create -f opendj.yaml



