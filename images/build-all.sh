#!/bin/sh

pushd .
for d in `ls -d  $PWD/*/`; do
  cd $d
  ./build-all.sh
done
popd
