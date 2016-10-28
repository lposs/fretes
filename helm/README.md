
# Deployment using Helm


See https://github.com/kubernetes/helm

Helm is very early stage - so this is quite experimental

See the README in openam-dev



# Notes

If you are using minikube take note that host path PVCs get deleted
everytime minikube is restarted.  The opendj/ chart is a StateFullSet,
and relies on auto provisioning.  If you restart minikube, you will
need to re-install openam.

