# OpenIG Sample helm chart


This uses an init container to git clone OpenIG's configuration,
and then starts up OpenIG, setting the OPENIG_BASE env variable
to the cloned configuration. 

This enables us to use a "generic" OpenIG container.

Another strategy is to use immutable OpenIG containers where
the configuration is baked into the container. See
the OpenIG DevOps guide for more information. 

Please have a look at the Values.yaml to understand how to configure
this.

