#!/usr/bin/env bash
# Create k8s manifests for multiple tenant IDM installs
# This approach uses namespaces to create isolated instances
TENANTS="bar foo"
DIR=out

mkdir -p $DIR

rm -f $DIR/*

# With namespaces the services can all be generic since they are isolated
jsonnet  --var tenant="openidm" openidm.jsonnet > "$DIR/idm.json"
jsonnet  --var tenant="openidm" idmsvc.jsonnet > "$DIR/idmsvc.json"

# Create the ingress
# An ingress can not select across namespaces. See
# https://github.com/kubernetes/kubernetes/issues/17088
jsonnet  --var tenants="openidm" ingress.jsonnet > $DIR/ingress.json

for tenant in $TENANTS
do
echo creating namespace for $tenant
jsonnet  --var tenant="$tenant" namespace.jsonnet > "$DIR/ns-$tenant.json"
kubectl create -f "$DIR/ns-$tenant.json"

kubectl --namespace="$tenant" create -f $DIR/idm.json
kubectl --namespace="$tenant" create -f $DIR/idmsvc.json
kubectl --namespace="$tenant" create -f $DIR/ingress.json

done





