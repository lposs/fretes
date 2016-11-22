#!/usr/bin/env bash

# Script that configures DJ, runs the openam-install chart, then starts openam.

initialize() {

  # Set up environment variables used by this script

  # Helm -f option specifies a YAML values file
  # Callers should set $HELM_VALUES with the overriding chart's file name
  # to override the normal helm charts
  # Example:  export HELM_VALUES=gke.yaml
  OPT=""
  if [ ! -z ${HELM_VALUES+x} ]; then
    OPT="-f ${HELM_VALUES}"
  fi;

  # Helm --dry-run option shows you what helm will deploy
  # Uncomment if you want the dry run behavior
  # DRYRUN="--dry-run --debug"

}

installOpenDJ() {

  # Install OpenDJ
  helm install ${OPT} ${DRYRUN} --name opendj opendj

  echo "Waiting for OpenDJ to start and initialize replication"

  DJ_CONFIGURED=no
  while [[ ${DJ_CONFIGURED} == no ]]
  do
    # Iterate every ten seconds
    sleep 10

    # Test for configuration status. DJ is fully configured if
    # the script that triggers replication has started.
    if [[ `kubectl logs opendj-configstore-0 | grep "Setting up replication from"` ]]
    then
      DJ_CONFIGURED=yes
    fi
  done

  # If we're not, sleep until replication has completed
  # Todo: replace the sleep 30 with a routine that tests whether replication has completed.
  if [[ `kubectl logs opendj-configstore-0 | grep "We are the master"` ]]
  then
    :
  else
    sleep 30
  fi

}

configureOpenAM() {

  # Install the openam-install job, which runs the OpenAM configurator

  helm install ${OPT} ${DRYRUN} --name openam-install openam-install

  echo "Configuring OpenAM"
  CONFIGURED=no
  while [[ ${CONFIGURED} == no ]]
  do
    # Iterate every ten seconds
    sleep 10

    # Test for configuration status
    if [[ `kubectl logs openam-install -c config | grep "Dumping all configuration parameters"` ]]
    then
      CONFIGURED=failure
    elif [[ `kubectl logs openam-install -c config | grep "Configuration complete!"` ]]
    then
      CONFIGURED=success
    else
      printf "."
    fi
  done

  # Display the configuration log
  kubectl logs openam-install -c config

  # Exit if configuration failed
  if [[ ${CONFIGURED} == failure ]]
  then
    echo "Configuration failed, terminating."
    exit
  fi

  # Let the deployment settle down before proceeding
  sleep 10

}

runOpenAM() {

  # Install the openam-runtime job, which runs OpenAM after configuration
  # is complete.

  # A k8s service, openam, is still deployed from the openam-install job.
  # Remove it to avoid errors with the helm install openam-runtime command.
  kubectl delete svc openam

  echo "Installing the OpenAM runtime"
  helm install ${OPT} ${DRYRUN} --name openam openam-runtime

}

initialize
installOpenDJ
configureOpenAM
runOpenAM

