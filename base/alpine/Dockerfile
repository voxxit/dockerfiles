FROM alpine:edge

MAINTAINER Joshua Delsman <j@srv.im>

RUN echo "http://repos.lax-noc.com/alpine/edge/main" | tee /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add git curl \
  && curl -o /usr/local/bin/gosu -sSL https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64 \
  && chmod +x /usr/local/bin/gosu \
  && git clone https://github.com/sstephenson/bats.git /usr/local/src/bats \
  && /usr/local/src/bats/install.sh /usr/local \
  && apk del git curl \
  && rm -rf /var/cache/apk/* /usr/local/src/*

CMD []
