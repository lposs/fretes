#!/bin/bash
# Kill all the docker images and cleanup 
docker rm -f $(docker ps -aq)

sudo rm -fr /var/lib/kubelet 


