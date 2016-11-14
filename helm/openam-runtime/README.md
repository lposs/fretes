# Helm Chart for OpenAM 


This chart installs OpenAM and
an external OpenDJ instance as the configuration and user store.

It has been tested using "minikube" on a mac, but should work on
any Kubernetes environment.


# Getting Started

Edit the values.yaml for your environment. You can use the provided defaults


If you have not already installed helm to your k8s cluster, do a
```
 helm init
 ```

Then install this chart using:
```
helm install openam-dev
```

If you want to see what will happen instead, use the --dry-run -debug option
for helm install. This will dump the expanded values

An ingress is defined for OpenAM.  You must have an ingress controller
deployed if you want to reach OpenAM via the external ingress route.  Otherwise,
you can use the nodeport (30080). The nginx script in this project (fretes/ingress)
will deploy an ingress controller.

After provisioning, put the IP address of your minikube or k8s cluster
in your /etc/hosts. For example
```
192.168.2.16 openam.test.com
```
