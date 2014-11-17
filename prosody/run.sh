#!/bin/sh
chown -R prosody /data

/usr/local/bin/gosu prosody /usr/bin/lua5.1 /usr/bin/prosody
