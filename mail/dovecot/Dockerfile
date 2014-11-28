FROM voxxit/mail-base

RUN  apk update \
  && apk add postfix dovecot rsyslog coreutils \
  && rm -rf /var/cache/apk/* \
  && cp /aliases /etc/postfix/virtual \
  && cp /domains /etc/postfix/virtual-mailbox-domains \
  && cp /passwords /etc/dovecot/passwd \
  && deluser vmail \
  && addgroup -S -g 5000 vmail \
  && adduser -S -u 5000 -G vmail vmail

VOLUME [ "/srv/vmail" ]

ADD ./rsyslog.conf      /etc/rsyslog.conf

ADD ./postfix.main.cf   /etc/postfix/main.cf

ADD ./dovecot.mail      /etc/dovecot/conf.d/10-mail.conf
ADD ./dovecot.ssl       /etc/dovecot/conf.d/10-ssl.conf
ADD ./dovecot.auth      /etc/dovecot/conf.d/10-auth.conf
ADD ./dovecot.master    /etc/dovecot/conf.d/10-master.conf

RUN cat /etc/postfix/master-additional.cf | tee -a /etc/postfix/master.cf \
  && mkdir /etc/postfix/tmp \
  && awk < /etc/postfix/virtual '{ print $2 }' > /etc/postfix/tmp/virtual-receivers \
  && sed -r 's,(.+)@(.+),\2/\1/,' /etc/postfix/tmp/virtual-receivers > /etc/postfix/tmp/virtual-receiver-folders \
  && paste \
    /etc/postfix/tmp/virtual-receivers \
    /etc/postfix/tmp/virtual-receiver-folders > /etc/postfix/virtual-mailbox-maps \
  && postmap /etc/postfix/virtual \
  && postmap /etc/postfix/virtual-mailbox-maps

EXPOSE 465 587 993

CMD \
  sed -i "s/{LOGGLY_TOKEN}/${LOGGLY_TOKEN}/" /etc/rsyslog.conf; \
  chown -R postfix:postfix /etc/postfix; \
  chown -R vmail:vmail /srv/vmail; \
  service postfix start; \
  service rsyslog start; \
  dovecot -F
