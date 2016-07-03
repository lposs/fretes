#!/usr/bin/env bash
# setup.sh for DJ replication in a k8s "petset"

echo "Setting up  OpenDJ instance  - primary"

env


PASSWORD=`cat $DIR_MANAGER_PW_FILE`


echo "Hostname is $HOSTNAME"
echo "Password is $PASSWORD"

cd /opt/opendj


/opt/opendj/setup --cli -p 389 --ldapsPort 636 --enableStartTLS --generateSelfSignedCertificate \
  --sampleData 5 --baseDN "dc=example,dc=com" -h $HOSTNAME --rootUserPassword "$PASSWORD" \
  --acceptLicense --no-prompt \
  --doNotStart


# If DJ_REPLICA_HOST is set, configure replication
# This is the hostname of the other DJ instance we want to replicate.
# This only needs to be run once on the first master.

bash /var/tmp/config/replicate
