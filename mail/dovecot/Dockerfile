FROM voxxit/base:alpine

MAINTAINER Joshua Delsman <j (at) srv.im>

RUN  apk update \
  && apk add \
    ca-certificates \
    postfix \
    postfix-pgsql \
    postfix-policyd-spf-perl \
    dovecot \
    dovecot-pgsql \
    gross \
    supervisor \
    cyrus-sasl \
    cyrus-sasl-digestmd5 \
  && rm -rf /var/cache/apk/* \
  && deluser vmail \
  && addgroup -S -g 5000 vmail \
  && adduser -S -u 5000 -G vmail vmail

VOLUME [ "/srv/mail", "/var/spool/postfix" ]

COPY ./etc/ /etc/
COPY ./bin/ /usr/local/bin/

EXPOSE 25 465 587 993

CMD [ "/usr/local/bin/run.sh" ]
