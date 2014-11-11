FROM alpinelinux/base:latest

MAINTAINER Joshua Delsman <j@srv.im>

ENV ALPINE_MIRROR http://repos.lax-noc.com/alpine/latest-stable/main

RUN echo "$ALPINE_MIRROR" > /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add lame icecast \
  && rm -rf /var/cache/apk/*

EXPOSE 8000

CMD [ "icecast", "-c", "/etc/icecast.xml" ]
