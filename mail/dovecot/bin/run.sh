#!/bin/bash
set -x

# for postgresql mapping
sed -i "s/PGSQL_HOST/${PGSQL_HOST}/" /etc/postfix/pgsql/* /etc/dovecot/dovecot-sql.conf
sed -i "s/PGSQL_USER/${PGSQL_USER}/" /etc/postfix/pgsql/* /etc/dovecot/dovecot-sql.conf
sed -i "s/PGSQL_PASSWORD/${PGSQL_PASSWORD}/" /etc/postfix/pgsql/* /etc/dovecot/dovecot-sql.conf
sed -i "s/PGSQL_DBNAME/${PGSQL_DBNAME}/" /etc/postfix/pgsql/* /etc/dovecot/dovecot-sql.conf

# (re-)build postfix queue
for queue in {active,bounce,corrupt,defer,deferred,flush,hold,incoming,private,saved,trace}; do
  install -d -o postfix -g postfix /var/spool/postfix/$queue
  chmod 700 /var/spool/postfix/$queue
done

# ensure proper permissions
chmod 730 /var/spool/postfix/maildrop
chmod 710 /var/spool/postfix/public
chown -R root /etc/postfix
chown -R vmail:vmail /srv/mail

# setup grossd
mkdir -p /var/db/gross
chown -R gross: /var/run/gross /var/db/gross
/usr/sbin/grossd -u gross -C 2>/dev/null

if [ ! -z $DEBUG ]; then
  echo "auth_verbose = yes" >> /etc/dovecot/dovecot.conf
  echo "auth_debug = yes" >> /etc/dovecot/dovecot.conf
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
