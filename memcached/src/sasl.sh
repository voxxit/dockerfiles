#!/bin/bash

[ -f .password ] && exit 0

PASSWORD=${PASSWORD:-`pwgen -c -s -B -n -1 20`}

echo ${USERNAME} > .username
echo ${PASSWORD} > .password

echo ${PASSWORD} | saslpasswd2 -a memcached -f /etc/sasldb2 -c -p ${USERNAME}

chown memcached:memcached /etc/sasldb2 .username .password
chmod 0600 /etc/sasldb2 .username .password

echo "USERNAME=${USERNAME}"
echo "PASSWORD=${PASSWORD}"
