#!/bin/bash

chown -R postfix:postfix /etc/postfix
chown -R vmail:vmail /srv/mail

if [ ! -z $LOGGLY_TOKEN ]; then
  if [ ! -z $LOGGLY_UID ]; then
    mkdir -p /etc/rsyslog.d

    echo "\$template LogglyFormat, \"<%pri%>%protocol-version% %timestamp:::date-rfc3339% %HOSTNAME% %app-name% %procid% %msgid% [$LOGGLY_TOKEN@$LOGGLY_UID tag=\"mail\"] %msg%\n\"" > /etc/rsyslog.d/22-loggly.conf
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

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
