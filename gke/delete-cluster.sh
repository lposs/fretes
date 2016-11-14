#!/usr/bin/env bash

export ZONE=us-central1-f
PROJECT=engineering-devops

gcloud container clusters delete openam --zone $ZONE


# Clean up all gcr images. This may or may not be what you want....
echo "Run this to clean up GCR"
echo gsutil -m rm -r gs://artifacts.${PROJECT}.appspot.com

