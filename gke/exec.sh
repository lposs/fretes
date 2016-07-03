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
      echo "Logs for $POD"
      kubectl --namespace=$1 exec ${POD}  -it /bin/bash 
      exit 0
   fi
done



