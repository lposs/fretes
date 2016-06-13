#!/usr/bin/env bash
# See https://github.com/GoogleCloudPlatform/continuous-deployment-on-kubernetes

kubectl get ns jenkins || kubectl create ns jenkins


gcloud compute images create jenkins-home-image --source-uri https://storage.googleapis.com/solutions-public-assets/jenkins-cd/jenkins-home.tar.gz
gcloud compute disks create jenkins-home --image jenkins-home-image
PASSWORD=`openssl rand -base64 15`; echo "Your password is $PASSWORD"; sed -i.bak s#CHANGE_ME#$PASSWORD# options

kubectl create secret generic jenkins --from-file=options --namespace=jenkins

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=jenkins/O=jenkins"

kubectl create secret generic tls --from-file=/tmp/tls.crt --from-file=/tmp/tls.key --namespace jenkins