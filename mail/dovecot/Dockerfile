FROM voxxit/mail-base

RUN  apk update \
  && apk add \
    postfix \
    dovecot \
    rsyslog \
    supervisor \
    cyrus-sasl \
    cyrus-sasl-digestmd5 \
  && rm -rf /var/cache/apk/* \
  && cp /aliases /etc/postfix/virtual \
  && cp /domains /etc/postfix/virtual-mailbox-domains \
  && cp /passwords /etc/dovecot/passwd \
  && deluser vmail \
  && addgroup -S -g 5000 vmail \
  && adduser -S -u 5000 -G vmail vmail

VOLUME [ "/srv/vmail" ]

ADD ./supervisord.conf  /etc/supervisor/conf.d/supervisord.conf

ADD ./rsyslog.conf      /etc/rsyslog.conf

ADD ./postfix.main.cf   /etc/postfix/main.cf
ADD ./postfix.master.cf /tmp/postfix/master.cf

ADD ./dovecot.mail      /etc/dovecot/conf.d/10-mail.conf
ADD ./dovecot.ssl       /etc/dovecot/conf.d/10-ssl.conf
ADD ./dovecot.auth      /etc/dovecot/conf.d/10-auth.conf
ADD ./dovecot.master    /etc/dovecot/conf.d/10-master.conf

COPY ./run.sh           /usr/local/bin/run.sh

RUN  mkdir /etc/postfix/tmp \
  && awk < /etc/postfix/virtual '{ print $2 }' > /etc/postfix/tmp/virtual-receivers \
  && sed -r 's,(.+)@(.+),\2/\1/,' /etc/postfix/tmp/virtual-receivers > /etc/postfix/tmp/virtual-receiver-folders \
  && paste \
    /etc/postfix/tmp/virtual-receivers \
    /etc/postfix/tmp/virtual-receiver-folders > /etc/postfix/virtual-mailbox-maps \
  && postmap /etc/postfix/virtual \
  && postmap /etc/postfix/virtual-mailbox-maps \
  && cat /tmp/postfix/master.cf >> /etc/postfix/master.cf \
  && rm -rf /tmp/postfix /etc/postfix/tmp

EXPOSE 25 465 587 993

CMD [ "/usr/local/bin/run.sh" ]
