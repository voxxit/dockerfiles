#!/bin/sh
set -x

install -d -o icecast -g icecast /usr/share/icecast/log

sed -i "s/HOSTNAME/${HOSTNAME}/g" /etc/icecast.xml
sed -i "s/SOURCE_PASSWORD/${SOURCE_PASSWORD-`pwgen -1 20`}/g" /etc/icecast.xml
sed -i "s/RELAY_PASSWORD/${RELAY_PASSWORD-`pwgen -1 20`}/g" /etc/icecast.xml
sed -i "s/ADMIN_PASSWORD/${ADMIN_PASSWORD-`pwgen -1 20`}/g" /etc/icecast.xml

exec icecast -c /etc/icecast.xml
