#!/bin/sh -ex

[ ! -x /usr/bin/curl ] && echo "curl is required" && exit 1
[ ! -x /usr/bin/tar  ] && echo "tar is required"  && exit 1
[ ! -x /usr/bin/gzip ] && echo "gzip is required" && exit 1

MIRROR="http://repos.lax-noc.com/alpine"
VERSION="v3.1"
APK_VER="2.5.0_rc1-r0"
ARCH="armhf"
CHROOT="/tmp/rootfs"
REPO="${MIRROR}/${VERSION}/main"

rm -rf $CHROOT

mkdir -p $CHROOT{/root,/etc/apk}

curl -sSL $REPO/$ARCH/apk-tools-static-$APK_VER.apk | \
  tar -xz -C /usr/local sbin/apk.static

apk.static \
  --repository $REPO \
  --update-cache \
  --allow-untrusted \
  --root $CHROOT \
  --arch $ARCH \
  --initdb \
  add alpine-base

echo $REPO > $CHROOT/etc/apk/repositories

rm -rf $CHROOT/var/cache/apk/*

tar --numeric-owner -C $CHROOT -c . | gzip -9 > `dirname $0`/rootfs.tar.gz

exit 0
