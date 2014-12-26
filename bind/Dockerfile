FROM voxxit/base:alpine

RUN  apk update \
  && apk add bind \
  && rm -rf /var/cache/apk/*

VOLUME [ "/etc/bind" ]

EXPOSE 53

CMD [ "/usr/sbin/named", "-4", "-f", "-c /etc/bind/named.conf" ]
