#!/bin/sh
pushd .
for d in */; do
  cd $d
  ./build.sh
done
popd
