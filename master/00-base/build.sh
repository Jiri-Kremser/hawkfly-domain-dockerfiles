#!/bin/sh
set -x
sudo docker build --no-cache=true -t jkremser/hawkfly-domain-base:latest .
