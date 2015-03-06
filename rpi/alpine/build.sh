#!/bin/sh -ex
CIDFILE=".cidfile"

if [ -f $CIDFILE ]; then
  docker rm -f $(cat $CIDFILE)
  rm -f $CIDFILE
fi

docker build --tag alpine-mkimage ./build/
docker run --cidfile="$CIDFILE" alpine-mkimage

CID=$(cat $CIDFILE)

rm -f rootfs.tar.gz

docker cp $CID:/rootfs.tar.gz .
docker rm -f $CID

rm -f $CIDFILE
