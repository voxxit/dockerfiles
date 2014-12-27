#!/bin/sh

if [ ! -f /etc/salt/minion ]; then
  cat > /etc/salt/minion <<EOF
master: ${SALT_MINION_MASTER:-'salt'}
keysize: ${SALT_MINION_KEYSIZE:-'2048'}
mine_interval: ${SALT_MINION_MINE_INTERVAL:-'2'}
mine_functions:
  test.ping: []
  network.get_hostname: []
  network.ip_addrs: [eth0]
EOF
fi

exec salt-minion -l ${SALT_MINION_LOGLEVEL:-'warning'}
