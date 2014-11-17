#!/bin/sh

mkdir -p /data/certs/
mv /etc/prosody/certs/localhost.* /data/certs/
chown -R prosody /data

/usr/local/bin/gosu prosody /usr/bin/lua5.1 /usr/bin/prosody
