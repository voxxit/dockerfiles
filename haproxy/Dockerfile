FROM alpine:3.21

LABEL org.opencontainers.image.authors="j@srv.im"

RUN apk add --no-cache haproxy

EXPOSE 80/tcp 443/tcp

VOLUME [ "/etc/haproxy", "/var/lib/haproxy" ]

ENTRYPOINT [ "haproxy" ]
CMD [ "-f", "/etc/haproxy/haproxy.cfg" ]
