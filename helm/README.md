
# Deployment using Helm

See https://github.com/kubernetes/helm

Helm is a package manager for Kubernetes. It templates out 
kubernetes manifests by performing variable expansion using golang
templates. This enables us to have generic "charts" that can 
be reused in different deployment contexts.


This directory contains helm charts for:

* opendj  - A chart to deploy one or more OpenDJ instances 
* openam-install  - A chart to install openam (and eventually configure)
* openam-runtime - A chart for the OpenAM runtime. Assumes OpenAM is 
installed already. This can scale up horizontally by increasing the replica count.


# Quick start - Deploying OpenAM

deploy-openam.sh  deploys opendj for the config / CTS store, 
deploys the openam-install chart to install and configure OpenAM, 
and then launches the runtime. At the conclusion of this chart you should 
have one or more OpenAM instances running on a node port (30080) and/or 
an ingress of /openam, assuming you have deployed an ingress controller. 

To remove the deployment run ./remove-openam.sh. This delete the helm
charts and the persistent volume claims backing OpenDJ.

# Modifying the deployment

Each helm chart has a values.yaml file that contains default
chart values for things like the docker image, number of replicas, and
so on.  You can either edit values.yaml, or better yet, create 
your own values.yaml that overrides just the values you want to
change. You can then invoke helm with your custom values. 

For example,
assume you have ```custom-dj.yaml`` that sets the DJ imageTag to "test-4.1". 
You can deploy the OpenDJ chart using:

```helm install --name opendj -f customer-dj.yaml opendj```
 
Further documentation can be found in each chart's README.md

# Notes

The default OpenDJ deployment uses persistent volume claims (PVC) and
"PetSets" to provide stateful deployment of the data tier. If you
wish to start from scratch you should delete the PVC volumes. 
The remove-openam.sh script will do this for you. Note that
PVCs and PetSets are Kubernetes 1.4 alpha features. You need to be 
on a cluster that supports these features. 


If OpenDJ is deployed with more than one server, subsequent replicas
are configured to replicate to the first instance. You need to ensure
all replicas are up and stable before proceeding to deploy OpenAM.
If you don't, you may get into a situation where OpenAM deploys,
but a new replica comes online a "replicates" over top of the install -
wiping it out.  We need to fix this in the OpenDJ chart so that
replication is initiated from the master - but this is still a work
in progress. 

The shell scripts assign an explicit name to the helm release
using the --name argument on helm install. If you don't do this,
helm generates a unique release name. For scripting purposes a
fixed release name allows us to clean up the release by name. 


If you are using minikube take note that host path PVCs get deleted
everytime minikube is restarted.  The opendj/ chart is a StateFullSet,
and relies on auto provisioning.  If you restart minikube, you will
need to re-install openam.

# Docker Images 


These Charts uses the following ForgeRock Docker images:
* forgerock/openam  - OpenAM runtime image
* forgerock/opendj  - OpenDJ for the config / user store
* forgerock/openam-config - Configurator Image


If you are using minikube, the easiest way to use these images
is to docker build them directly into the docker instance running
inside minikube.   The docker source code for the images
is located at https://stash.forgerock.org/projects/DOCKER/repos/docker/browse



# Tips

To connect an ldap browser to OpenDJ running in the cluster, use
port forwarding:


kubectl port-forward opendj-configstore-0 1389:389

