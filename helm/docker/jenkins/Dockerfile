FROM jenkins:2.7.2

COPY plugins.txt /usr/share/jenkins/ref/

RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt

# This should be fixed so we dont need root perms
# Right now the /var/jenkins_home gets mounted with root permission.
USER root

