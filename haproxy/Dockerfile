FROM voxxit/base:alpine

RUN  apk update \
  && apk add haproxy \
  && rm -rf /var/cache/apk/*
  
EXPOSE 80 443

VOLUME [ "/etc/haproxy", "/var/lib/haproxy" ]

ENTRYPOINT [ "haproxy" ]

CMD [ "-f", "/etc/haproxy/haproxy.cfg" ]
