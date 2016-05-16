#!/usr/bin/env bash
# Create a cluster for testing
export ZONE=us-central1-f

# Options - we disable GCE http LB addon since we want to deploy the nginx load balancer.
# GCE LB is overkill for a test system
gcloud container clusters create openam --network "default" --num-nodes 1 \
  --machine-type  n1-standard-2 --zone $ZONE \
  --disable-addons HttpLoadBalancing \
  --disk-size 50 --scopes storage-full
