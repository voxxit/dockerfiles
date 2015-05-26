FROM alpine:edge

MAINTAINER Joshua Delsman <j@srv.im>

RUN  apk add --update git curl bash \
  && curl -o /usr/local/bin/gosu -L https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64 \
  && chmod +x /usr/local/bin/gosu \
  && git clone https://github.com/sstephenson/bats.git /usr/local/src/bats \
  && /usr/local/src/bats/install.sh /usr/local \
  && apk del git curl \
  && rm -rf /var/cache/apk/* /usr/local/src/*

CMD []
