#!/bin/sh

if [ ! -f /etc/salt/master ]; then
  cat > /etc/salt/master <<EOF
transport: ${SALT_TRANSPORT:-'raet'}
interface: ${SALT_MASTER_BIND:-'0.0.0.0'}
state_verbose: ${SALT_MASTER_STATE_VERBOSE:-'False'}
EOF
fi

exec salt-master -l ${SALT_MASTER_LOGLEVEL:-'warning'}
