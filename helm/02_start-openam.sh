#!/usr/bin/env bash

# Comment this out if not deploying to GKE
#GKE="-f gke.yaml"

#DRYRUN="--dry-run --debug"

echo "Deleting the install chart as it is no longer required "
# We can delete the install chart now - its job is done
helm delete openam-install --purge

echo "Creating the OpenAM runtime"
helm install ${GKE} ${DRYRUN} --name openam openam-runtime

#minikube dashboard

