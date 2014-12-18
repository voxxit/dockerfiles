FROM voxxit/base:alpine

MAINTAINER Joshua Delsman <j (at) srv.im>

RUN apk update \
  && apk add lame icecast \
  && rm -rf /var/cache/apk/*

EXPOSE 8000

CMD [ "icecast", "-c", "/etc/icecast.xml" ]
