FROM alpinelinux/base:latest

MAINTAINER Joshua Delsman <j@srv.im>

RUN echo "http://repos.lax-noc.com/alpine/edge/main" | tee /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add git \ 
  && git clone https://github.com/sstephenson/bats.git /usr/local/src/bats \
  && /usr/local/src/bats/install.sh /usr/local \
  && apk del git \
  && rm -rf /var/cache/apk/* /usr/local/src/*

CMD []
