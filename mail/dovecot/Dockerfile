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

COPY ./etc/ /etc/
COPY ./bin/ /usr/local/bin/

EXPOSE 25 465 587 993

CMD [ "/usr/local/bin/run.sh" ]
