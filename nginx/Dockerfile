FROM alpine

MAINTAINER Josh Delsman <j@srv.im>

RUN  apk add --no-cache nginx \
  && mkdir -p /tmp/nginx

VOLUME [ "/etc/nginx" ]

EXPOSE 80/tcp 443/tcp

ADD nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx"]
CMD ["-c", "/etc/nginx/nginx.conf"]
