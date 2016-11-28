FROM jkremser/hawkfly-domain-base:0.24.2

MAINTAINER Jirka Kremser <jkremser@redhat.com>

USER root
RUN echo "* hard  nofile 64000" >> /etc/security/limits.conf
USER jboss

EXPOSE 8080 8180 18080 18180 9990
