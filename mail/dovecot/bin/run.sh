#!/bin/bash

TMP_RECV=`mktemp` || exit 1
TMP_FOLD=`mktemp` || exit 1

# create virtual mailbox mappings from /etc/postfix/virtual
cat /etc/postfix/virtual | awk '{ print $2 }' | uniq > $TMP_RECV
sed -r 's,(.+)@(.+),\2/\1/,' $TMP_RECV > $TMP_FOLD
paste $TMP_RECV $TMP_FOLD > /etc/postfix/virtual-mailbox-maps
rm $TMP_RECV $TMP_FOLD

# build postfix dbs
postmap /etc/postfix/virtual
postmap /etc/postfix/virtual-mailbox-maps

# ensure proper permissions
chown -R postfix:postfix /etc/postfix
chown -R vmail:vmail /srv/mail

if [ ! -z $DEBUG ]; then
  echo "auth_verbose = yes" >> /etc/dovecot/dovecot.conf
  echo "auth_debug = yes" >> /etc/dovecot/dovecot.conf
fi

if [ ! -z $LOGGLY_TOKEN ]; then
  if [ ! -z $LOGGLY_UID ]; then
    mkdir -p /etc/rsyslog.d

    echo "\$template LogglyFormat, \"<%pri%>%protocol-version% %timestamp:::date-rfc3339% %HOSTNAME% %app-name% %procid% %msgid% [$LOGGLY_TOKEN@$LOGGLY_UID tag=\\\"mail\\\"] %msg%\n\"" > /etc/rsyslog.d/22-loggly.conf
    echo "*.* @@logs-01.loggly.com:514;LogglyFormat" >> /etc/rsyslog.d/22-loggly.conf
  fi
fi

if [ ! -z $MAILGUN_SMTP_PASSWORD ]; then
  if [ ! -z $MAILGUN_SMTP_USERNAME ]; then
    postconf -e \
      smtp_sasl_password_maps="static:$MAILGUN_SMTP_USERNAME:$MAILGUN_SMTP_PASSWORD" \
      relayhost="[smtp.mailgun.org]:587"
  fi
fi

# remove SSL config if no certificate or private key found
test -f /etc/ssl/certs/mail.crt   || rm -f /etc/dovecot/conf.d/10-ssl.conf
test -f /etc/ssl/private/mail.key || rm -f /etc/dovecot/conf.d/10-ssl.conf

exec /usr/bin/supervisord -c /etc/supervisord.conf
