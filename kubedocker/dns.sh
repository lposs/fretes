#!/bin/bash
# Setup DNS for the cluster
# You probably want this most of the time - run after kube comes up
rm -f /tmp/skydns.* 
curl http://kubernetes.io/docs/getting-started-guides/docker-multinode/skydns.yaml.in  -o /tmp/skydns.yaml.in



export DNS_REPLICAS=1

export DNS_DOMAIN=cluster.local # specify in startup parameter `--cluster-domain` for containerized kubelet 

export DNS_SERVER_IP=10.0.0.10 


sed -e "s/{{ pillar\['dns_replicas'\] }}/${DNS_REPLICAS}/g;s/{{ pillar\['dns_domain'\] }}/${DNS_DOMAIN}/g;s/{{ pillar\['dns_server'\] }}/${DNS_SERVER_IP}/g" \
  < /tmp/skydns.yaml.in > /tmp/skydns.yaml


kubectl create -f ns.yaml 

kubectl create -f /tmp/skydns.yaml

