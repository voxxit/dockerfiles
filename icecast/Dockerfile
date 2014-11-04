FROM alpinelinux/base:latest

MAINTAINER j@srv.im

EXPOSE 80

RUN apk add -U icecast \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /usr/share/icecast/log \
  && chown -R icecast: /usr/share/icecast

ADD ./icecast.xml /etc/

CMD [ "icecast", "-c", "/etc/icecast.xml" ]
