#!/bin/sh
set -x
source ../../env.sh
_name="hawkfly-domain-small"
docker rm --force $_name 2> /dev/null
docker run -d -p 8080:8080 --name=$_name jkremser/$_name:$IMAGE_VERSION
docker ps
