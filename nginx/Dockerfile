FROM alpine

LABEL org.opencontainers.image.authors="j@srv.im"

RUN  apk add --no-cache nginx \
  && mkdir -p /tmp/nginx

VOLUME [ "/etc/nginx" ]

EXPOSE 80/tcp 443/tcp

COPY nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx"]
CMD ["-c", "/etc/nginx/nginx.conf"]
