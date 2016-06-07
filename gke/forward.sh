#!/bin/bash
# Forward ports to pod - useful for testing. Hard coded for port 8080 right now
# arg 1 is the namespace to search
# Arg 2 is the pod regex to match (.e.g openam)
# Alternative would be to use label selectors....


PODS=`kubectl --namespace=$1 get pod -o jsonpath="{.items[*].metadata.name}"`
echo Found pods $PODS

for POD in ${PODS}
do
   if [[ $POD == $2* ]];
   then
      echo "Will port forward to matching pod $POD"
      echo kubectl --namespace=$1 port-forward ${POD} 8080:8080
      kubectl --namespace=$1 port-forward ${POD} 8080:8080
      exit 0
   fi
done



