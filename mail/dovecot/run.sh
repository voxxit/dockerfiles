#!/bin/bash

[ ! -z ${LOGGLY_UID} ]   && sed -i "s/LOGGLY_UID/${LOGGLY_UID}/"     /etc/rsyslog.conf
[ ! -z ${LOGGLY_TOKEN} ] && sed -i "s/LOGGLY_TOKEN/${LOGGLY_TOKEN}/" /etc/rsyslog.conf

chown -R postfix:postfix /etc/postfix
chown -R vmail:vmail /srv/vmail

exec /usr/bin/supervisord -c supervisord -c /etc/supervisor/conf.d/supervisord.conf
