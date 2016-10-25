#!/usr/bin/env bash
curl -X POST -T cloudbuild.json -H "Content-Type: application/json" \
  -H "Authorization: Bearer $(gcloud auth print-access-token)" \
  https://cloudbuild.googleapis.com/v1/projects/engineering-devops/builds


# -H "Content-length: [NUM_OF_BYTES_IN_REQUEST]" \