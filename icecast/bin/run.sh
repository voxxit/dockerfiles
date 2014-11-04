#!/bin/bash
set -x

# ensure proper permissions on logs
chown -R icecast2 /var/log/icecast2

# set hostname
sed -i "s|<hostname>|<hostname>${HOSTNAME}|" /etc/icecast2/icecast.xml

# set/create passwords
sed -i "s|<source-password>|<source-password>${SOURCE_PASSWORD:-`pwgen -1s 20`}|" /etc/icecast2/icecast.xml
sed -i "s|<relay-password>|<relay-password>${RELAY_PASSWORD:-`pwgen -1s 20`}|" /etc/icecast2/icecast.xml
sed -i "s|<admin-password>|<admin-password>${ADMIN_PASSWORD:-`pwgen -1s 20`}|" /etc/icecast2/icecast.xml

gosu icecast2 /usr/bin/icecast2 -c /etc/icecast2/icecast.xml
