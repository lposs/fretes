#!/usr/bin/env bash
# Script that configures DJ and then runs the openam-install chart
# At completion openam should be ready to go
# Set the env var HELM_VALUES to use a custom value.yaml override
# Example:  export HELM_VALUES=gke.yaml

OPT=""

# Uncomment this if you want to see what helm will deploy
#DRYRUN="--dry-run --debug"


if [ ! -z ${HELM_VALUES+x} ]; then
   OPT="-f ${HELM_VALUES}"
fi;

helm install ${OPT} ${DRYRUN} --name opendj opendj

echo "Giving DJ some time to start"

# This takes a while the first time a PVC is provisioned
# Todo: Have a wait loop that can tell when DJ is up and stable, replication has been initiaized, etc.
sleep 180

echo "Configuring OpenAM"

helm install ${OPT} ${DRYRUN} --name openam-install openam-install

echo "Waiting for the configurator "


sleep 50

echo "When you see configuration complete you can control-c this shell"

kubectl logs openam-install -c config -f

