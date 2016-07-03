#!/usr/bin/env bash
# replicate to the primary host

cd /opt/opendj

PASSWORD=`cat $DIR_MANAGER_PW_FILE`



regex="([a-z]+)-([0-9]+)"

if [[ $HOSTNAME =~ $regex ]]; then

   svc="${BASH_REMATCH[1]}"
   primary="${svc}-0"
   PRIMARY_SERVER="${svc}-0.${svc}.default.svc.cluster.local"

      if [ $HOSTNAME != ${primary} ]; then
         echo "Setting up replication from $HOSTNAME to $PRIMARY_SERVER"
         bin/start-ds
         bin/dsreplication enable --host1 $HOSTNAME --port1 4444 \
        --bindDN1 "cn=directory manager" \
        --bindPassword1 $PASSWORD --replicationPort1 8989 \
        --host2 $PRIMARY_SERVER --port2 4444 --bindDN2 "cn=directory manager" \
        --bindPassword2 $PASSWORD --replicationPort2 8989 \
        --adminUID admin --adminPassword $PASSWORD --baseDN "dc=example,dc=com" -X -n

      echo "initializing replication"

      bin/dsreplication initialize --baseDN "dc=example,dc=com" \
        --adminUID admin --adminPassword $PASSWORD \
        --hostSource $HOSTNAME --portSource 4444 \
        --hostDestination $PRIMARY_SERVER --portDestination 4444 -X -n

      # run.sh expects it will be stopped
      bin/stop-ds

      fi
fi
