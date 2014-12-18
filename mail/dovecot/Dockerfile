FROM r.srv.im/mail-base:latest

RUN  apk update \
  && apk add \
    postfix \
    postfix-policyd-spf-perl \
    postgrey \
    dovecot \
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
  && adduser postgrey -D -H -G postgrey

VOLUME [ "/srv/mail", "/var/spool/postfix" ]

COPY ./etc/ /etc/
COPY ./bin/ /usr/local/bin/

EXPOSE 25 465 587 993

CMD [ "/usr/local/bin/run.sh" ]
