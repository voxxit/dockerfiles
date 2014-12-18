FROM r.srv.im/mail-base:latest

MAINTAINER Joshua Delsman <j (at) srv.im>

RUN  apk update \
  && apk add spamassassin \
  && wget \
    http://spamassassin.apache.org/updates/GPG.KEY \
    http://www.apache.org/dist/spamassassin/source/Mail-SpamAssassin-rules-3.4.0.r1565117.tgz \
    http://www.apache.org/dist/spamassassin/source/Mail-SpamAssassin-rules-3.4.0.r1565117.tgz.asc \
    http://www.apache.org/dist/spamassassin/source/Mail-SpamAssassin-rules-3.4.0.r1565117.tgz.md5 \
    http://www.apache.org/dist/spamassassin/source/Mail-SpamAssassin-rules-3.4.0.r1565117.tgz.sha1 \
  && sa-update --gpgkey GPG.KEY --install Mail-SpamAssassin-rules-3.4.0.r1565117.tgz \
  && rm -rf Mail-SpamAssassin-rules-3.4.0.r1565117.* GPG.KEY /var/cache/apk/*

EXPOSE 783

ENTRYPOINT [ "/usr/sbin/spamd" ]
CMD [ "--syslog-socket=none" ]
