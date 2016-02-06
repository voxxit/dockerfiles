FROM voxxit/base:alpine

MAINTAINER Joshua Delsman <j@srv.im>

EXPOSE 80 443

ENV NGINX_VERSION 1.9.4

RUN  apk add --update openssl-dev pcre-dev zlib-dev build-base \
  && rm -rf /var/cache/apk/* \
  && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar -xzvf nginx-${NGINX_VERSION}.tar.gz \
  && cd nginx-${NGINX_VERSION} \
  && wget http://hg.nginx.org/nginx/raw-rev/257b51c37c5a \
  && patch -p1 -i 257b51c37c5a \
  && ./configure \
    --with-http_v2_module \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --with-threads \
    --with-ipv6 \
  && make \
  && make install \
  && apk del build-base \
  && rm -rf /nginx-*

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

VOLUME [ "/usr/local/nginx/logs", "/usr/local/nginx/html", "/usr/local/nginx/conf" ]

ENTRYPOINT [ "/usr/local/nginx/sbin/nginx" ]
CMD [ "-c", "/usr/local/nginx/conf/nginx.conf" ]
