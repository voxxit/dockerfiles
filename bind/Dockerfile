FROM voxxit/base:alpine

RUN apk add --update bind \
  && rm -rf /var/cache/apk/*

ADD . /etc/bind/

EXPOSE 53/udp

CMD [ "named", "-g" ]
