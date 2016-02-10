#!/usr/bin/env bash

if [ -z "$1" ]
  then
    exit
fi

VERSION=$1
TMPDIR=$(realpath tmp)

mkdir $TMPDIR

docker build -t alpine-builder builder
docker run -e "USERID=$UID" -v $TMPDIR:/data --rm alpine-builder $VERSION
docker rmi alpine-builder
cat $TMPDIR/rootfs.tar.gz | docker import - xsteadfastx/alpine-x86:$VERSION

rm -rf $TMPDIR
