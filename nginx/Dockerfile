FROM voxxit/base:alpine

MAINTAINER Joshua Delsman <j at srv.im>

RUN apk update && apk add nginx && mkdir /tmp/nginx

ADD nginx.conf /etc/nginx/nginx.conf

VOLUME [ "/etc/nginx" ]

EXPOSE 80 443

CMD [ "nginx", "-c", "/etc/nginx/nginx.conf" ]
