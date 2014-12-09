FROM voxxit/base:alpine

RUN  apk update \
  && apk add haproxy \
  && rm -rf /var/cache/apk/*
  
EXPOSE 80 443 8000

# template for use with consul
ADD ./haproxy.ctmpl /etc/haproxy/haproxy.ctmpl

VOLUME [ "/etc/haproxy" ]

ENTRYPOINT [ "haproxy" ]

CMD [ "-f", "/etc/haproxy/haproxy.cfg" ]
