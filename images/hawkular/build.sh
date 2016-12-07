#!/bin/sh
set -x
source ../env.sh
docker build --no-cache=true -t jkremser/hawkular-services-foo:$IMAGE_VERSION .
