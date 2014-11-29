#!/bin/bash

chown -R postfix:postfix /etc/postfix
chown -R vmail:vmail /srv/vmail

if [ ! -z $LOGGLY_TOKEN ]; then
  mkdir -p /etc/rsyslog.d
  tee /etc/rsyslog.d/22-loggly.conf <<EOF
$template LogglyFormat, "<%pri%>%protocol-version% %timestamp:::date-rfc3339% %HOSTNAME% %app-name% %procid% %msgid% [$LOGGLY_TOKEN@$LOGGLY_UID tag=\"mail\"] %msg%\n"
*.* @@logs-01.loggly.com:514;LogglyFormat
EOF
fi

if [ ! -z $MAILGUN_SMTP_PASSWORD ]; then
  postconf -e \
    smtp_sasl_password_maps="static:$MAILGUN_SMTP_USERNAME:$MAILGUN_SMTP_PASSWORD" \
    relayhost="[smtp.mailgun.org]:587"
fi

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
