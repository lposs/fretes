#!/usr/bin/env bash

source env.sh


openam="${SERVER_URL}/openam"

ssoToken=$(curl -s -X POST -H "Content-Type: application/json" -H "X-OpenAM-Username: amadmin" \
   -H "X-OpenAM-Password: ${ADMIN_PWD}" -d '{}' "${openam}/json/authenticate")

TOKEN_SPLIT=`echo ${ssoToken} | sed -e 's/[{}:,\"]/ /g'`
ssoToken=`echo "$TOKEN_SPLIT" | cut -d " " -f 6`

function post {
   echo "post: $2"
   echo "data: $1"

  curl -s -X POST -H "Content-Type: application/json" -H "iPlanetDirectoryPro: ${ssoToken}" -d "$1" "$2"
}

function put {
   echo "post: $2"
   echo "data: $1"

  curl -s -X PUT -H "Content-Type: application/json" -H "iPlanetDirectoryPro: ${ssoToken}" -d "$1" "$2"
}

put "@setupcts.json" "${openam}/json/global-config/servers/01/properties/cts"

post "@setupPolicy.json" "${openam}/json/policies?_action=create"

post "@setupAgent.json" "${openam}/json/agents?_action=create"


