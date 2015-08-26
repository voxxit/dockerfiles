FROM alpine:latest

MAINTAINER Joshua Delsman <j@srv.im>

EXPOSE 443

ENV NGINX_VERSION 1.9.4

RUN  apk add --update openssl-dev pcre-dev zlib-dev build-base \
  && rm -rf /var/cache/apk/* \
  && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar -xzvf nginx-${NGINX_VERSION}.tar.gz \
  && cd nginx-${NGINX_VERSION} \
  && wget http://nginx.org/patches/http2/patch.http2.txt \
  && patch -p1 < patch.http2.txt \
  && ./configure --with-http_ssl_module --with-http_v2_module \
  && make \
  && make install \
  && apk del build-base \
  && rm -rf /nginx-*

COPY nginx.conf /usr/local/nginx/conf/nginx.conf

VOLUME [ "/usr/local/nginx/logs", "/usr/local/nginx/html", "/usr/local/nginx/conf" ]

ENTRYPOINT [ "/usr/local/nginx/sbin/nginx" ]
CMD [ "-c", "/usr/local/nginx/conf/nginx.conf" ]

# To build:
#
#    docker build --rm --no-cache -t nginx-http2 https://gist.github.com/48217044067bb859248e.git
#
# To run the nginx server with HTTP/2 support, you need to first grab a working
# SSL key/certificate bundle, along with a working HTTP/2 nginx.conf:
#
# https://gist.github.com/voxxit/17d305a8ed68e77d8271
#
# Then, you just run like so:
#
#    docker run -d --name nginx-http2 -p 443:443 \
#      -v "$PWD"/cert.pem:/usr/local/nginx/conf/cert.pem:ro \
#      -v "$PWD"/cert.key:/usr/local/nginx/conf/cert.key:ro \
#      -v "$PWD"/nginx.conf:/usr/local/nginx/conf/nginx.conf:ro \
#      -v "$PWD"/public:/usr/local/nginx/html nginx-http2
#
# Test in Chrome with:
# https://chrome.google.com/webstore/detail/http2-and-spdy-indicator/mpbpobfflnpcgagjijhmgnchggcjblin?hl=en
