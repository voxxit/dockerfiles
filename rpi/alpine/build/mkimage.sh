#!/bin/sh -ex
REPO=${MIRROR}/${VERSION}/main
ARCH=`uname -m`
CHROOT="/tmp/rootfs"

mkdir -p $CHROOT{/root,/etc/apk}

curl -sSL $REPO/$ARCH/apk-tools-static-$APK_VER.apk | \
  tar -xz -C /usr/local sbin/apk.static

apk.static -X $REPO -U --allow-untrusted --root $CHROOT --initdb add alpine-base

echo $REPO > $CHROOT/etc/apk/repositories

rm -rf $CHROOT/var/cache/apk/*

tar --numeric-owner -C $CHROOT -c . | gzip -9 > /rootfs.tar.gz

exit 0
