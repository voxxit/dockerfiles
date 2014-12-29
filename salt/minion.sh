#!/bin/sh
config=/etc/salt/minion

if [ -f $config ]; then
  sed "s/%master%/${SALT_MASTER:-'salt'}/g"            -i $config
  sed "s/%keysize%/${SALT_KEYSIZE:-'2048'}/g"          -i $config
  sed "s/%mine_interval%/${SALT_MINE_INTERVAL:-'2'}/g" -i $config
fi

exec salt-minion -l ${SALT_LOGLEVEL:-'warning'}
