#!/bin/sh
[ -z $WOWZA_LICENSE_KEY ] && echo "You must provide a Wowza license key to continue!" && exit 1

set -x

WOWZA_VERSION=${WOWZA_VERSION:-4.1.1}
WOWZA_INSTALLER="WowzaStreamingEngine-${WOWZA_VERSION}.deb.bin"
WOWZA_INSTALLER_URL="https://dl.dropboxusercontent.com/u/1051848/${WOWZA_INSTALLER}"

if [ ! -f .wowza-installed ]; then
  cd /usr/local/src

  [ ! -f /${WOWZA_INSTALLER} ] \
    && wget -o ${WOWZA_INSTALLER} ${WOWZA_INSTALLER_URL} \
    || mv /${WOWZA_INSTALLER} /usr/local/src/${WOWZA_INSTALLER}

  # disable user interaction during install
  sed 's/^more <<"EOF"$/cat <<"EOF"/'                               -i ./${WOWZA_INSTALLER}
  sed 's/^agreed=$/agreed=1/'                                       -i ./${WOWZA_INSTALLER}
  sed 's/^ADMINUSER=$/ADMINUSER=admin/'                             -i ./${WOWZA_INSTALLER}
  sed 's/\$ADMINUSER  \$ADMINPASS1 admin/\$ADMINUSER  admin admin/' -i ./${WOWZA_INSTALLER}
  sed 's/^PWMATCH=$/PWMATCH=1/'                                     -i ./${WOWZA_INSTALLER}
  sed 's/^VALIDLICKEY=$/VALIDLICKEY=1/'                             -i ./${WOWZA_INSTALLER}
  sed 's/STARTSERVICES=$/STARTSERVICES=0/'                          -i ./${WOWZA_INSTALLER}

  chmod +x ./${WOWZA_INSTALLER}
  ./${WOWZA_INSTALLER}
  rm -rf ./${WOWZA_INSTALLER}

  cd /usr/local/WowzaStreamingEngine/conf
  sed "s|<IPWhiteList>127.0.0.1</IPWhiteList>|<IPWhiteList>192.168.*.*</IPWhiteList>|" -i ./Server.xml

  touch /.wowza-installed
fi

cd /usr/local/WowzaStreamingEngine/bin
echo ${WOWZA_LICENSE_KEY} | tee /usr/local/WowzaStreamingEngine/conf/Server.license

exec ./startup.sh
