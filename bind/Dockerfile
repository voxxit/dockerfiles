FROM voxxit/base:alpine

RUN  apk update \
  && apk add bind \
  && rm -rf /var/cache/apk/* /etc/bind

VOLUME [ "/etc/bind" ]

ADD etc/ /etc/bind/

EXPOSE 53

CMD [ "/usr/sbin/named", "-c", "/etc/bind/named.conf", "-f" ]
