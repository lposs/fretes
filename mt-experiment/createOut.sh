#!/usr/bin/env bash

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


jsonnet  --var tenants="$TENANTS" ingress.jsonnet > $DIR/ingress.json

