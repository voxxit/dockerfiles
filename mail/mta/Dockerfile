FROM debian:jessie

RUN  DEBIAN_FRONTEND=noninteractive apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get upgrade \
  && DEBIAN_FRONTEND=noninteractive apt-get -y install \
    bind9-host \
    ca-certificates \
    dovecot-common \
    dovecot-pgsql \
    dovecot-sieve \
    dovecot-lmtpd \
    dovecot-imapd \
    geoip-bin \
    gross \
    libgeo-ip-perl \
    libsasl2-modules-sql \
    postfix \
    postfix-pgsql \
    postfix-policyd-spf-python \
    sasl2-bin \
    spamassassin \
    supervisor \
    razor \
    pyzor \
  && addgroup --system --gid 5000 vmail \
  && adduser --system --home /srv/mail --no-create-home \
    --uid 5000 --gid 5000 --disabled-password \
    --disabled-login vmail \
  && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* /etc/dovecot/conf.d/*

VOLUME [ "/srv/mail" ]

COPY ./bin/ /usr/local/bin/
COPY ./etc/ /etc/
COPY ./var/ /var/

EXPOSE 25 465 587 993

CMD [ "/usr/local/bin/run.sh" ]
