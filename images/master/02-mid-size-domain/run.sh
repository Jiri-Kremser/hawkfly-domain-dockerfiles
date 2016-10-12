#!/bin/sh
set -x
_name="hawkfly-domain-middle"
docker rm --force $_name 2> /dev/null
docker run -d -p 8080:8080 -p 8180:8180 -p 8280:8280 --name=$_name jkremser/$_name
docker ps
