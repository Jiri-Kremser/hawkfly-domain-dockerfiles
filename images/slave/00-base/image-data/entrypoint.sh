#!/bin/bash
set -e

#docker run [COMMAND] not provided
if [ "$#" -eq 0 ]; then
    HOST=${DOMAIN_CONTROLLER_HOST:=localhost}
    PORT=${DOMAIN_CONTROLLER_PORT:=9990}
    #/tmp/init directory exists and contain cli scripts
    if [ -d /tmp/init ] && [ $(find /tmp/init -name "*.cli" | wc -l) -gt 0 ]; then
        #wait for cli to be available
        echo "Waiting for the domain controller on "$HOST":"$PORT".."
        jjs $JBOSS_HOME/bin/wait_for_jboss_cli.js
        for s in /tmp/init/*.cli; do
            #execute cli script
            $JBOSS_HOME/bin/jboss-cli.sh --controller=$HOST:$PORT --connect --file=$s
            mv $s $s"_initialized"
        done
    fi
    # replace the host controller name
    #sed -i "s;@@HOST_CONTROLLER_NAME@@;$HOST_CONTROLLER_NAME;" $JBOSS_HOME/domain/configuration/host-slave.xml

    # start the server
    echo "master="$HOST
    $JBOSS_HOME/bin/domain.sh -b 0.0.0.0 --host-config=host-slave.xml -Djboss.domain.master.address=$HOST -Djboss.host.name=$HOST_CONTROLLER_NAME
else
    #docker run [COMMAND] is provided, execute it (e.g. bash)
    exec "$@"
fi
