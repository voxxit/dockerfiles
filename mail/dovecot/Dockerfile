# To run:
#
#    make base
#    make dovecot
#    docker run -d -p 25:25 -p 143:143 -p 587:587 -p 993:993 -p 465:465 -h mail.srv.im --name mail/dovecot mail/dovecot
#
FROM mail/base

RUN  apk update \
  && apk add postfix dovecot coreutils \
  && rm -rf /var/cache/apk/* \
  && cp /aliases /etc/postfix/virtual \
  && cp /domains /etc/postfix/virtual-mailbox-domains \
  && cp /passwords /etc/dovecot/passwd \
  && deluser vmail \
  && addgroup -S -g 5000 vmail \
  && adduser -S -u 5000 -G vmail vmail

VOLUME [ "/srv/vmail" ]

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

EXPOSE 25 143 587 465 993

CMD \
  chown -R postfix:postfix /etc/postfix; \
  chown -R vmail:vmail /srv/vmail; \
  service postfix start; \
  dovecot -F
