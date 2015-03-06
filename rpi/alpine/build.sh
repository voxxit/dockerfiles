#!/bin/sh -xe

PWD=`dirname $0`
CIDFILE="$PWD/.cidfile"

if [ -f $CIDFILE ]; then
  docker rm -f `cat $CIDFILE`
  rm -f $CIDFILE
fi

docker build --tag alpine-mkimage $PWD/build/

docker run --cidfile=$CIDFILE alpine-mkimage

CID=`cat $CIDFILE`

docker cp $CID:/rootfs.tar.gz $PWD

docker rm -f $CID
rm -f $CIDFILE
