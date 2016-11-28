#!/bin/bash
set -e
set -x

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters, this script takes the desired tag as a param."
    echo "example: ./.travis.notify-dockerhub.sh 0.24.2"
fi

tag=$1


while read line; do
  linearray=($line)
  token=${linearray[0]}
  name=${linearray[1]}
  echo "Notifying $name..."
  curl -H "Content-Type: application/json" --data '{"source_type": "Tag", "source_name": "'$tag'"}' -X POST https://registry.hub.docker.com/u/jkremser/$name/trigger/$token/

done <./.travis.dockerhub-tokens.txt
