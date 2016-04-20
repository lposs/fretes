
Experimental  "Multi Tenancy" light solution.

# Label / Host based 

Uses jsonnet to template out services and set up the ingress

OpenIDM instances are labelled with a tenant name. Service selection
uses the label to wire up the service to the right OpenIDM instance.

The Ingress resource uses host based routing and routes the hostname
${tenant}.example.com to the right backend service.

This is "psuedo" isolation, in the sense that IDM instances could
in theory talk to resources in the same Kubernetes name space. 


To run:

```
brew install jsonnet

./createMT.sh 

kubectl create -f out 
```


# Namespace based isolation

This uses k8s namespaces to run components in isolated namespaces. 
This ensures one OpenIDM tenant instance can not see resources that belong 
to another tenant

This is easy enough to create- but currently on GKE it creates
one HTTP LB per tenant - so starts to add up

To run:

```
./createMT-NS.sh

```

