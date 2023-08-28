FROM alpine:3.16

LABEL org.opencontainers.image.authors="j@srv.im"

EXPOSE 80/tcp 443/tcp

ENV NGINX_VERSION 1.15.12

RUN  apk add --no-cache openssl-dev pcre-dev zlib-dev build-base \
  && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar -xzvf nginx-${NGINX_VERSION}.tar.gz \
  && cd nginx-${NGINX_VERSION} \
  && ./configure \
    --with-http_v2_module \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_stub_status_module \
    --with-threads \
    --with-ipv6 \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && make install \
  && apk del build-base \
  && rm -rf /nginx-*

COPY --from=src nginx.conf /usr/local/nginx/conf/nginx.conf

VOLUME [ "/usr/local/nginx/logs", "/usr/local/nginx/html", "/usr/local/nginx/conf" ]

ENTRYPOINT [ "/usr/local/nginx/sbin/nginx" ]
CMD [ "-c", "/usr/local/nginx/conf/nginx.conf" ]
