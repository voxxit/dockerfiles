#!/bin/bash -ex

cat > /etc/resolv.conf <<EOF
nameserver 8.8.8.8
nameserver 8.8.4.4
nameserver 2001:4860:4860::8888
nameserver 2001:4860:4860::8844
options rotate
EOF

# can we resolve hosts?
host yahoo.com >/dev/null || exit 1

# chroot jail exists?
pushd /var/spool/postfix/etc
  cp /etc/resolv.conf resolv.conf
popd

# Maildir
mkdir -p /srv/mail

# download servers for Pyzor checks
pyzor --homedir /etc/mail/spamassassin discover

# PostgreSQL credentials
sed -i "\
  s/PGSQL_HOST/${PGSQL_HOST}/; \
  s/PGSQL_USER/${PGSQL_USER}/; \
  s/PGSQL_PASSWORD/${PGSQL_PASSWORD}/; \
  s/PGSQL_DBNAME/${PGSQL_DBNAME}/" /etc/postfix/pgsql/* /etc/dovecot/dovecot-sql.conf.ext

# (re-)build postfix queue
pushd /var/spool/postfix
  for QUEUE in {active,bounce,corrupt,defer,deferred,flush,hold,incoming,private,saved,trace}; do
    install -d -o postfix -g postfix ./${QUEUE}
    chmod 700 ./${QUEUE}
  done

  chmod 730 ./maildrop
  chmod 710 ./public
  chown -R postfix .
  chgrp -R postdrop ./{maildrop,public}
  chown root: ./etc/resolv.conf
popd

# precompile sieve
sievec /var/lib/dovecot/sieve/default

chown -R root: /etc/postfix /usr/local/bin/spam_filter.sh
chown -R vmail: /srv/mail /var/lib/dovecot/sieve
chmod 755 /usr/local/bin/spam_filter.sh

# setup grossd
pushd /var
  mkdir -p ./{db,run}/gross
  chown -R gross: ./{db,run}/gross
popd

# create initial state file
if [ ! -f /var/db/gross/state ]; then
  /usr/sbin/grossd -u gross -C 2>/dev/null
fi

# mailgun support
if [ ! -z ${MAILGUN_SMTP_PASSWORD} ] && [ ! -z ${MAILGUN_SMTP_USERNAME} ]; then
  postconf -e \
    smtp_sasl_password_maps="static:${MAILGUN_SMTP_USERNAME}:${MAILGUN_SMTP_PASSWORD}" \
    relayhost="[smtp.mailgun.org]:587"
fi

# remove SSL config if certificate or private key missing
if [ ! -f /etc/ssl/certs/mail.crt ] || [ ! -f /etc/ssl/private/mail.key ]; then
  rm -f /etc/dovecot/conf.d/10-ssl.conf
fi

# build system aliases
/usr/bin/newaliases

exec /usr/bin/supervisord -c /etc/supervisord.conf
