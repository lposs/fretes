#!/usr/bin/env bash
# source this
export HELM_DIR="~/src/go/src/github.com/kubernetes/helm"

alias helm="$HELM_DIR/bin/helm"
alias tiller="$HELM_DIR/bin/tiller"

# init helm
echo helm init -n default

