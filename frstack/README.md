# Example showing openam, opendj, openidm



# Note: 

*** This is deprecated in favour of the projects under the helm/ directory ***




You need to setup persistent volumes
for this example. The easiest way to do this in a single node test cluster
is to use the "hostPath" volume type.  This can not be used in
production as the path only exists on a single node. 

This directory includes pv-host.yaml - which will create a hostPath PV
for testing. You may have to change this for your environment.

For GCE, see the scripts in misc/ to create a GCE Persistent Disk.



# Things you need to know

Config files are cloned from a git repo: https://github.com/ForgeRock/stack-config
The ssoconfig container waits for AM to come up, then plays the config files

the ssoadm container is a work in progress. You should be able to log in
to the container to execute commands.
kubectl get pods
- get the pod id
then
```
kubectl exec openam-xxxx -c ssoadm -it /bin/bash
```

Where openam-xxxx is the pod id. This will give you a bash shell in the
container where ssoadm is installed.

# Ingress

An ingress is defined (like a load balancer) - but you must launch
an ingress controller (the thing that does the actual Load Balancing)

For Kube-solo-osx, I use the command in ../ingress/nginx.sh to create
one.

If you are running on Google Container engine, or possibly AWS, an ingress
will already be present as part of the environment.

# Seeing the results
The example as is- assumes:
 
openam is at http://openam.example.com:80/openam

openidm at http://openam.example.com:80/idmselfservice 

(see the ingress for all of the paths)

Add the IP of your ingress to your /etc/hosts

If you are on Kube-solo-osx you can find your IP by bringing
up the "fleet-ui" in the menu - and looking at the IP.
You can also ssh into the VM and do an ifconfig -a to get eth0


# todo

