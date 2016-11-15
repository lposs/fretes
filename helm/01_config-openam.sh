#!/usr/bin/env bash
# Script that configures DJ and then runs the openam-install chart
# At completion openam should be ready to go

# Uncomment to run on GKE
#GKE="-f gke.yaml"

helm install ${GKE} --name opendj opendj

echo "Giving DJ some time to start"

# This takes a while the first time a PVC is provisioned
# Todo: Have a wait loop that can tell when DJ is up and stable, replication has been initiaized, etc.
sleep 180

echo "Configuring OpenAM"
helm install ${GKE} --name openam-install openam-install

echo "Waiting for the configurator "


sleep 30

echo "When you see configuration complete you can control-c this shell"

kubectl logs openam-install -c config -f

