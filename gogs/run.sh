#!/bin/bash

export HOME="$GOGSPATH"

mkdir -p $GOGSPATH/custom/https
cd $GOGSPATH/custom/https

# unless cert.pem & key.pem exist, generate a self-signed certificate
# for the server's hostname
test ! -f ./cert.pem && test ! -f ./key.pem && $GOGSPATH/gogs cert --host $HOSTNAME --ca true

cd $GOGSPATH

# ensure correct permissions
chown -R gogs:gogs . /repos

# start sshd
/usr/sbin/sshd -p $SSH_PORT

# start gogs
/usr/local/bin/gosu gogs:gogs ./gogs web
