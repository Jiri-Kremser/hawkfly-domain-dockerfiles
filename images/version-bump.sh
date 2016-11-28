#!/bin/sh
set -x

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters, this script takes the desired version."
    echo "example: ./version-bump.sh 0.24.2"
fi

VERSION=$1
sed -i "s;^IMAGE_VERSION=.*$;IMAGE_VERSION=$VERSION;" ./env.sh

for dockerfile in `find . -name Dockerfile` ; do
  sed -i "s;^\(FROM [^/]*/[^/]*:\).*$;\1$VERSION;" $dockerfile
done

git tag $VERSION
echo "Done. Don't forget to git push --tags"
