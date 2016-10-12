#!/bin/sh

pushd .
for d in `ls -d  $PWD/*/`; do
  cd $d
  echo "building master images.."
  ./build.sh
done
popd
