FROM pilhuhn/hawkular-services:latest

MAINTAINER Jirka Kremser <jkremser@redhat.com>

USER root
RUN sed -i 's;\(-bmanagement 0.0.0.0\) \\;\1 -Dactivemq.artemis.client.global.thread.pool.max.size=30 \\;g' /opt/hawkular/bin/startcmd.sh

EXPOSE 8080 9990

CMD ["/opt/hawkular/bin/startcmd.sh"]
