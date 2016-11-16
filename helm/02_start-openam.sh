#!/usr/bin/env bash

OPT=""

if [ -v HELM_VALUES ]; then
   OPT="-f ${HELM_VALUES}"
fi;


#DRYRUN="--dry-run --debug"

echo "Deleting the install chart as it is no longer required "
# We can delete the install chart now - its job is done
#helm delete openam-install --purge

echo "Creating the OpenAM runtime"
helm install ${OPT} ${DRYRUN} --name openam openam-runtime

#minikube dashboard

