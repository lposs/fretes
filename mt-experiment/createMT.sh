#!/usr/bin/env bash
# Create k8s manifests for multiple tenant IDM installs
# This uses labels to select the appropriate backend services
TENANTS="bar foo"
DIR=out

mkdir -p $DIR

rm -f $DIR/*

for tenant in $TENANTS
do
echo creating config for $tenant
jsonnet  --var tenant="$tenant" openidm.jsonnet > "$DIR/idm-$tenant.json"
jsonnet  --var tenant="$tenant" idmsvc.jsonnet > "$DIR/idmsvc-$tenant.json"

done

# Create the ingress
jsonnet  --var tenants="$TENANTS" ingress.jsonnet > $DIR/ingress.json

