#!/bin/sh
set -x
source ../../env.sh
docker run jkremser/hawkfly-domain-slave-base:$IMAGE_VERSION
