#!/bin/bash

hawkular_server=${HAWKULAR_SERVER:=http://hawkular:8080}
endpoint=$hawkular_server"/hawkular/status"
wait_seconds=${WAIT_SECONDS:=15}

echo "waiting for the hawkular server to be up"
until $(curl --output /dev/null --silent --head --fail $endpoint); do
    printf '.'
    sleep 1
done

echo $HAWKULAR_SERVER" is responding for GET requests, let's wait additional "$WAIT_SECONDS" seconds for other subsystems"
sleep $WAIT_SECONDS
