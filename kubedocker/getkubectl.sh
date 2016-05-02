#!/bin/bash

export K8S_VERSION=$(curl -sS https://storage.googleapis.com/kubernetes-release/release/stable.txt)

wget http://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubectl

echo "moving kubectl to ~/bin"

mv kubectl ~/bin
chmod +x ~/bin/kubectl


echo "you can add the following aliases"

echo "alias kc=kubectl"
echo "alias ks='kubectl --namespace=kube-system'"


