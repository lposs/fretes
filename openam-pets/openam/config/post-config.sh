#!/usr/bin/env bash

source env.sh


openam="${SERVER_URL}/openam"


# Nice little script courtesy of Andy Hall to get the SSO token
ssoToken=$(curl -s -X POST -H "Content-Type: application/json" -H "X-OpenAM-Username: amadmin" \
   -H "X-OpenAM-Password: ${ADMIN_PWD}" -d '{}' "${openam}/json/authenticate")

firstCut=${ssoToken#*:}
secondCut=${firstCut%,*}
length=${#secondCut}-2
finalCut=${secondCut:1:$length}
ssoToken=$finalCut


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

# Test OAuth2
# Not working - todo: find out why
#post 'grant_type=password&username=demo&password=changeit&client_id='${client}'&client_secret=password&scope=openid' \
#     "${openam}/oauth2/access_token"

