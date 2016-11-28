FROM jkremser/hawkfly-domain-base:0.24.1

MAINTAINER Jirka Kremser <jkremser@redhat.com>

USER root
RUN echo "* hard  nofile 64000" >> /etc/security/limits.conf
USER jboss

EXPOSE 8080 8180 9990
