#!/bin/sh

SOURCE_PASSWORD=${SOURCE_PASSWORD-`pwgen -1 20`}
RELAY_PASSWORD=${RELAY_PASSWORD-`pwgen -1 20`}
ADMIN_PASSWORD=${ADMIN_PASSWORD-`pwgen -1 20`}

sed -i "s/HOSTNAME/${HOSTNAME}/g" /etc/icecast/icecast.xml
sed -i "s/SOURCE_PASSWORD/${SOURCE_PASSWORD}/g" /etc/icecast/icecast.xml
sed -i "s/RELAY_PASSWORD/${RELAY_PASSWORD}/g" /etc/icecast/icecast.xml
sed -i "s/ADMIN_PASSWORD/${ADMIN_PASSWORD}/g" /etc/icecast/icecast.xml

echo
icecast -v
echo
echo "Source Login:     source / ${SOURCE_PASSWORD}"
echo "Relay Login:      relay  / ${RELAY_PASSWORD}"
echo "Admin Login:      admin  / ${ADMIN_PASSWORD}"
echo

exec icecast -c /etc/icecast/icecast.xml
