#!/bin/bash -x

REPO="http://repos.lax-noc.com/alpine/v3.1/main"
ARCH="armhf"

#[ "$(id -u)" = "0" ] || echo 'This script requires root' && exit 1

TMP=`mktemp -d ${TMPDIR:-/var/tmp}/alpine-docker-XXXXXXXXXX`
ROOTFS=`mktemp -d ${TMPDIR:-/var/tmp}/alpine-docker-rootfs-XXXXXXXXXX`

trap "rm -rf $TMP $ROOTFS" EXIT TERM INT

# get APK tools version
apkv() {
  curl -sSL $REPO/$ARCH/APKINDEX.tar.gz | tar -Oxz | grep '^P:apk-tools-static$' -a -A1 | tail -n1 | cut -d: -f2
}

curl -sSL $REPO/$ARCH/apk-tools-static-$(apkv).apk | tar -xz -C $TMP sbin/apk.static

$TMP/sbin/apk.static \
  --repository $REPO \
  --update-cache \
  --allow-untrusted \
  --root $ROOTFS \
  --initdb add alpine-base

echo $REPO > $ROOTFS/etc/apk/repositories

rm -rf $ROOTFS/var/cache/apk/*

tar --numeric-owner -C $ROOTFS -c . | xz > rootfs.tar.xz
