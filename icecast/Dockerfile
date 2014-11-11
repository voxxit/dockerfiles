FROM alpinelinux/base:latest

MAINTAINER j@srv.im

EXPOSE 8000

RUN apk update \
  && apk add lame icecast

CMD [ "icecast", "-c", "/etc/icecast.xml" ]
