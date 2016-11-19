#!/usr/bin/env bash
# Clean up and remove

helm delete openam --purge
helm delete opendj --purge
helm delete openam-install --purge

# Delete the dj data`
kubectl delete pvc data-opendj-configstore-0
