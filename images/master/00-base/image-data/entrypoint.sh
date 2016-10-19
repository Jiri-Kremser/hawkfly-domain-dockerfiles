#!/bin/sh
set -e

#docker run [COMMAND] not provided
if [ "$#" -eq 0 ]; then
    #/tmp/init directory exists and contain cli scripts
    if [ -d /tmp/init ] && [ $(find /tmp/init -name "*.cli" | wc -l) -gt 0 ]; then
        #start standalone server in admin only mode
        $JBOSS_HOME/bin/domain.sh --admin-only &
        #wait for cli to be available
        jjs $JBOSS_HOME/bin/wait_for_jboss_cli.js
        for s in /tmp/init/*.cli; do
            #execute cli script
            $JBOSS_HOME/bin/jboss-cli.sh --connect --file=$s
            mv $s $s"_initialized"
        done
        #shutdown admin only server
        $JBOSS_HOME/bin/jboss-cli.sh --connect --command=/host=master:shutdown
    fi
    $JBOSS_HOME/bin/add-user.sh --silent --user slave --password 123456

    # wait for hawkular server
    $JBOSS_HOME/bin/wait_for_hawkular.sh

    # start real server
    $JBOSS_HOME/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0
else
    #docker run [COMMAND] is provided, execute it (e.g. bash)
    exec "$@"
fi
