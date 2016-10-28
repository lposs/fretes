#!/usr/bin/env bash


echo "Make sure you have an ingress controller deployed!"


# Install helm on the cluster
helm init


helm install --name opendj opendj

echo "Giving DJ some time to spin up"

sleep 30

echo "Configuring OpenAM"
helm install --name openam-install openam-install

sleep 5
echo "Waiting for the configurator "


kubectl logs openam-install -c config -f | while read LOGLINE
do
   echo $LOGLINE
   [[ "${LOGLINE}" == *"Configuration complete"* ]] && pkill -P $$ kubectl
done

# We can get rid of the intall chart now - its job is done
helm delete openam-install --purge

helm install --name openam openam-runtime

minikube dashboard

