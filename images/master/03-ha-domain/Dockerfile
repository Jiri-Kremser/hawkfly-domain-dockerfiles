FROM jkremser/hawkfly-domain-base:0.22.0

MAINTAINER Jirka Kremser <jkremser@redhat.com>

USER root
RUN echo "* hard  nofile 64000" >> /etc/security/limits.conf
USER jboss

EXPOSE 8080 8180 9990
