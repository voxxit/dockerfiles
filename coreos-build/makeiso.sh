#!/bin/bash

# Creates a bootable ISO from CoreOS' PXE images.
# Also adds a run script to the OEM partition and converts the ISO so it can boot from USB media.
# Based heavily off https://github.com/nyarla/coreos-live-iso - Thanks Naoki!

set -e

# Default configurations
SYSLINUX_VERSION="6.02"
COREOS_VERSION="alpha"
BOOT_ENV="bios"
SSH_PUBKEY_PATH=/build/key.pub

# Initialze variables
SYSLINUX_BASE_URL="https://www.kernel.org/pub/linux/utils/boot/syslinux"
SYSLINUX_BASENAME="syslinux-$SYSLINUX_VERSION"
SYSLINUX_URL="${SYSLINUX_BASE_URL}/${SYSLINUX_BASENAME}.tar.gz"

COREOS_BASE_URL="http://storage.core-os.net/coreos/amd64-usr"
COREOS_KERN_BASENAME="coreos_production_pxe.vmlinuz"
COREOS_INITRD_BASENAME="coreos_production_pxe_image.cpio.gz"
COREOS_KERN_URL="${COREOS_BASE_URL}/${COREOS_VERSION}/${COREOS_KERN_BASENAME}"
COREOS_INITRD_URL="${COREOS_BASE_URL}/${COREOS_VERSION}/${COREOS_INITRD_BASENAME}"

SSH_PUBKEY=`cat ${SSH_PUBKEY_PATH}`

bindir=`cd $(dirname $0) && pwd`
workdir=$bindir/work

echo "-----> Initialize working directory"
if [ ! -d $workdir ]; then
  mkdir -p $workdir
fi

cd $workdir

mkdir -p iso/coreos
mkdir -p iso/syslinux
mkdir -p iso/isolinux

echo "-----> Download CoreOS's kernel"
if [ ! -e iso/coreos/vmlinuz ]; then
  curl -o iso/coreos/vmlinuz $COREOS_KERN_URL
fi

echo "-----> Download CoreOS's initrd"
if [ ! -e iso/coreos/cpio.gz ]; then
  curl -o iso/coreos/cpio.gz $COREOS_INITRD_URL
fi

echo "-----> Download syslinux and copy to iso directory"
if [ ! -e ${SYSLINUX_BASENAME} ]; then
  curl -O $SYSLINUX_URL
fi
tar zxf ${SYSLINUX_BASENAME}.tar.gz

cp ${SYSLINUX_BASENAME}/${BOOT_ENV}/com32/chain/chain.c32 iso/syslinux/
cp ${SYSLINUX_BASENAME}/${BOOT_ENV}/com32/lib/libcom32.c32 iso/syslinux/
cp ${SYSLINUX_BASENAME}/${BOOT_ENV}/com32/libutil/libutil.c32 iso/syslinux/
cp ${SYSLINUX_BASENAME}/${BOOT_ENV}/memdisk/memdisk iso/syslinux/

cp ${SYSLINUX_BASENAME}/${BOOT_ENV}/core/isolinux.bin iso/isolinux/
cp ${SYSLINUX_BASENAME}/${BOOT_ENV}/com32/elflink/ldlinux/ldlinux.c32 iso/isolinux/

echo "-----> Make isolinux.cfg file"
cat > iso/isolinux/isolinux.cfg <<EOF
INCLUDE /syslinux/syslinux.cfg
EOF

echo "-----> Make syslinux.cfg file"
cat > iso/syslinux/syslinux.cfg <<EOF
default coreos
prompt 1
timeout 15

label coreos
  kernel /coreos/vmlinuz
  append initrd=/coreos/cpio.gz root=squashfs: state=tmpfs: sshkey="${SSH_PUBKEY}"
EOF

echo "-----> Make ISO file"
cd iso
genisoimage -v -l -r -J -o ${bindir}/coreos.${COREOS_VERSION}.iso -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table .
isohybrid ${bindir}/coreos.${COREOS_VERSION}.iso

echo "-----> Cleanup"
cd $bindir
rm -rf $workdir

echo "-----> Finished"
