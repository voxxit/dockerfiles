FROM voxxit/base:ubuntu

ENV RULES_FILE Mail-SpamAssassin-rules-3.4.0.r1565117.tgz

RUN  apt-get -y update \
  && apt-get -y install \
    ca-certificates \
    postfix \
    postfix-pgsql \
    postfix-policyd-spf-python \
    spamassassin \
    dovecot-common \
    dovecot-pgsql \
    dovecot-sieve \
    dovecot-lmtpd \
    dovecot-imapd \
    gross \
    supervisor \
    libsasl2-modules-sql \
    sasl2-bin \
  && addgroup --system --gid 5000 vmail \
  && adduser --system --home /srv/mail --no-create-home \
    --uid 5000 --gid 5000 --disabled-password \
    --disabled-login vmail \
  && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* /etc/dovecot/conf.d/*

VOLUME [ "/srv/mail" ]

COPY ./bin/       /usr/local/bin/
COPY ./etc/       /etc/
COPY ./var/       /var/

COPY ./dns.patch  /

COPY ./tests.bats /

# Patch for SpamAssassin's DNS Resolving to fix the
# issues with Net::DNS 0.76
# RUN cd /usr/share/perl5/vendor_perl/Mail/SpamAssassin \
#   && patch -p0 -i /dns.patch

EXPOSE 25 465 587 993

CMD [ "/usr/local/bin/run.sh" ]
