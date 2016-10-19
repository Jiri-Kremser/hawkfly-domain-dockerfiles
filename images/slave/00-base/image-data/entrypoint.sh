#!/bin/bash
set -e

if [[ -z $HOST_CONTROLLER_NAME ]]; then
  HOST_CONTROLLER_NAME=`hostname`
fi

function createServers(){
  ind=0
  echo "crating servers.."
  for group_pair in $(echo $SERVERS | sed "s/,/ /g") ; do
    group_name=$(echo $group_pair | cut -f1 -d=)
    group_count=$(echo $group_pair | cut -f2 -d=)
    for i in $(seq 1 $group_count) ; do
      server_name=$HOST_CONTROLLER_NAME"-s"$ind
      echo "running: $JBOSS_HOME/bin/jboss-cli.sh --controller=$HOST:$PORT --connect --user=slave --password=123456 /host=$HOST_CONTROLLER_NAME/server-config=$server_name:add(auto-start=true, group=$group_name)"
      $JBOSS_HOME/bin/jboss-cli.sh --controller=$HOST:$PORT --connect --user=slave --password=123456 "/host="$HOST_CONTROLLER_NAME"/server-config="$server_name":add(auto-start=true, group="$group_name")"
      #/host=master/server-config=s:start()"
      ind=$((ind+1))
    done
  done
}

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

    #wait for the master to be available
    echo "waiting for the master to be up.."
    jjs $JBOSS_HOME/bin/wait_for_jboss_cli.js

    # add the servers in 10 seconds
    (sleep 10 && createServers)&

    # start the server
    echo "master="$HOST":"$PORT
    $JBOSS_HOME/bin/domain.sh -b 0.0.0.0 --host-config=host-slave.xml -Djboss.domain.master.address=$HOST -Djboss.domain.master.port=$PORT -Djboss.host.name=$HOST_CONTROLLER_NAME
else
    #docker run [COMMAND] is provided, execute it (e.g. bash)
    exec "$@"
fi
