#!/bin/bash

hawkular_server=${HAWKULAR_SERVER:=http://hawkular:8080}
endpoint=$hawkular_server"/hawkular/inventory/status"

echo "waiting for the hawkular server to be up"
until $(curl --output /dev/null --silent --head --fail $endpoint); do
    printf '.'
    sleep 1
done

sleep 40
