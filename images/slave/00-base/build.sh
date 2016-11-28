#!/bin/sh
set -x
source ../../env.sh
docker build --no-cache=true -t jkremser/hawkfly-domain-slave-base:$IMAGE_VERSION .
