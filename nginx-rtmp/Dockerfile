FROM alpine

ARG NGINX_VERSION="1.10.1"

RUN  apk add --no-cache build-base git pcre-dev openssl-dev \
  && mkdir -p /usr/local/src \
  && cd /usr/local/src \
  && git clone git://github.com/arut/nginx-rtmp-module.git \
  && wget -qO- http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar -xz \
  && cd nginx-${NGINX_VERSION} \
  && ./configure --prefix=/usr/local/nginx --add-module=/usr/local/src/nginx-rtmp-module \
  && make \
  && make install \
  && cp /usr/local/src/nginx-rtmp-module/stat.xsl /usr/local/nginx/html/ \
  && apk del build-base git \
  && rm -rf /usr/local/src/*

# Forward request and error logs to Docker log collector
RUN  ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
  && ln -sf /dev/stderr /usr/local/nginx/logs/error.log

COPY conf/nginx.conf /usr/local/nginx/conf/

EXPOSE 80/tcp 1935/tcp

CMD [ "/usr/local/nginx/sbin/nginx" ]
