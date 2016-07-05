#!/bin/bash

kubectl delete configmap djconfig
kubectl create configmap djconfig --from-file=djconfig=setup.sh 

