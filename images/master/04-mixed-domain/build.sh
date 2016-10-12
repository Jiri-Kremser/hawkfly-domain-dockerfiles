#!/bin/sh
set -x
docker build --no-cache=true -t jkremser/hawkfly-domain-mixed:latest .
