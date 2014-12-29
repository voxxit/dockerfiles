#!/bin/sh
config=/etc/salt/master

if [ -f $config ]; then
  sed "s/%interface%/${SALT_INTERFACE:-'0.0.0.0'}/g" -i $config
  sed "s/%state_verbose%/${SALT_STATE_VERBOSE:-'False'}/g" -i $config
fi

exec salt-master -l ${SALT_LOGLEVEL:-'warning'}
