FROM voxxit/mail-base

RUN  apk update \
  && apk add \
    postfix \
    postgrey \
    dovecot \
    rsyslog \
    supervisor \
    cyrus-sasl \
    cyrus-sasl-digestmd5 \
    coreutils \
  && rm -rf /var/cache/apk/* \
  && cp /aliases /etc/postfix/virtual \
  && cp /domains /etc/postfix/virtual-mailbox-domains \
  && cp /passwords /etc/dovecot/passwd \
  && deluser vmail \
  && addgroup -S -g 5000 vmail \
  && adduser -S -u 5000 -G vmail vmail \
  && adduser postgrey -D -H -G postgrey \
  && mkdir -p /var/spool/postfix/postgrey \
  && chown -R postgrey: /var/spool/postfix/postgrey

VOLUME [ "/srv/mail" ]

ADD ./supervisord.conf  /etc/supervisord.conf

ADD ./postfix.main.cf   /etc/postfix/main.cf
ADD ./postfix.master.cf /etc/postfix/master.cf

ADD ./dovecot.mail      /etc/dovecot/conf.d/10-mail.conf
ADD ./dovecot.ssl       /etc/dovecot/conf.d/10-ssl.conf
ADD ./dovecot.auth      /etc/dovecot/conf.d/10-auth.conf
ADD ./dovecot.master    /etc/dovecot/conf.d/10-master.conf
ADD ./dovecot.plugins   /etc/dovecot/conf.d/90-quota.conf

COPY ./run.sh           /usr/local/bin/run.sh

EXPOSE 25 465 587 993

CMD [ "/usr/local/bin/run.sh" ]
