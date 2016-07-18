# OpenDJ PetSet

Shows an example of bringing up two (or more) OpenDJ instances in a K8S "PetSet"
http://kubernetes.io/docs/user-guide/petset/ 


The instances will be configured to support an OpenAM CTS store. 

You will need to be running Kubernetes 1.3 or later to get PetSet support.

The first instance (opendj-0) is the "master". Subsequent instances 
will be replicated to the opendj-0 master. 
 
 
If you want persistence (i.e. data to survive container restarts) you need
to edit opendj.yaml and uncomment the persistent volume lines.  See
that file for details. 

See the Docker OpenDJ image https://stash.forgerock.org/projects/DOCKER/repos/docker/browse/opendj 
for more information on how to customize and bootstrap different 
OpenDJ configurations.  There are a number of environment variables that are used to
configure OpenDJ and setup replication.



# Running

```
kubectl create -f .

kubectl logs opendj-0 -f # To watch the logs
kubectl logs opendj-1 -f # watch the logs
```


# TODO

You can scale up OpenDJ servers by editing the petset and incrementing the replica count. We should
also support scaling it back down. This requires a hook on container shutdown to update
OpenDJ and remove the instance from the replication topology. If we do not do this, OpenDJ
will still try to replicate to the node that no longer exists. 



