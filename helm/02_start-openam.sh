#!/usr/bin/env bash


echo "Deleting the install chart "
# We can delete the install chart now - its job is done
helm delete openam-install --purge


helm install --name openam openam-runtime

#minikube dashboard

