FROM alpine:edge

MAINTAINER Joshua Delsman <j@srv.im>

RUN  apk add --update git curl bash \
  && curl -o /usr/bin/gosu -L https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 \
  && chmod +x /usr/bin/gosu \
  && git clone https://github.com/sstephenson/bats.git /usr/local/src/bats \
  && /usr/local/src/bats/install.sh /usr \
  && apk del git curl \
  && rm -r /var/cache/apk/* /usr/local/src/bats

CMD []
