# Docker image for Apache + OpenAM HTTP agent
FROM httpd:2.4

WORKDIR /opt

ENV MVN_REPO=http://maven.forgerock.org/repo/repo/org/forgerock/openam
ENV DOWNLOADS_REPO=http://download.forgerock.org/downloads
ENV AGENTS_VERSION=5.0.0-SNAPSHOT

RUN apt-get update \
     && apt-get install --no-install-recommends  -y unzip curl \
     && curl $DOWNLOADS_REPO/openam/webagents/nightly/Linux/Apache_v24_Linux_64bit_$AGENTS_VERSION.zip \
         -o /var/tmp/agent.zip \
     && unzip /var/tmp/agent.zip -d /opt/ \
     && chmod +x /opt/web_agents/apache24_agent/bin/agentadmin \
     && rm /var/tmp/agent.zip \
     && echo "password" > /var/tmp/pw.txt \
     && chmod 0400 /var/tmp/pw.txt

# Format of agentadmin command:
# agentadmin --s "web-server configuration file, directory or site parameter" \
#                "OpenAM URL" "Agent URL" "realm" "agent user id" \
#                "path to the agent password file" [--changeOwner] [--acceptLicence] [--forceInstall]
#

# Because we are running this before OpenAM is up and running we need to use the forceinstall option
# We are using some defaults here (openam service name) that are not going to exist in most environments
# They will need to be overridden at runtime by updating the bootstrap files
# A possible option is to have Docker create a host entry for openam-svc - but that seems kludgy...

RUN /opt/web_agents/apache24_agent/bin/agentadmin --s /usr/local/apache2/conf/httpd.conf \
        "http://openam.test.com:30080/openam/" \
        "http://openam.test.com:30090/" \
        "/" \
        "apacheagent" \
        /var/tmp/pw.txt \
        --changeOwner --acceptLicence --forceInstall

# todo: We should let above command create the conf file
#COPY agent.conf /opt/web_agents/apache24_agent/instances/agent_1/config/agent.conf
#COPY run.sh /var/tmp/

# Inherit CMD from Parent httpd:2.4
#CMD ["httpd-foreground"]

#CMD ["/var/tmp/run.sh"]
