# fretes  - ForgeRock on Kubernetes

##Warning

**This code is not supported by ForgeRock and it is your responsibility to verify that the software is suitable and safe for use.**

Run the ForgeRock Stack (OpenAM, OpenDJ, OpenIDM, OpenIG) on Kubernetes (k8s)


# Contributing 

This repository is located at https://stash.forgerock.org/projects/DOCKER/repos/fretes/browse
and mirrored to github at https://github.com/ForgeRock/fretes 

Pull requests should be made on the stash repository. You will 
need a ForgeRock community account to create pull requests.


# Prerequisites

You need to have Kubernetes installed to run these examples.  See
http://kubernetes.io

I have been testing with kube verson 1.2


You will need ForgeRock Docker images. You can build these using the
Dockerfiles in https://stash.forgerock.org/projects/DOCKER/repos/docker/browse

If you push these images to your own registry you will need to modify the image:
tag in the manifests. Eventually the manifests will be 
managed by helm so that things like tags can be templated out


# Samples:

frstack - example that shows how to run OpenAM, OpenDJ, OpenIG and OpenIDM using 
persistent volumes. This is the most recent
work - so start here.  Please see the README notes in that folder


openidm - Run's OpenIDM with the Postgres database. Also configures an instance of OpenDJ

Example:

```
prepare.sh
kubectl create -f frstack
kubectl get pods
kubectl get services
```
