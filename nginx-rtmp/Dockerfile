FROM voxxit/base:alpine

RUN  apk add --update build-base git pcre-dev openssl-dev \
  && cd /usr/local/src \
  && git clone git://github.com/arut/nginx-rtmp-module.git \
  && wget -qO- http://nginx.org/download/nginx-1.8.0.tar.gz | tar -xz \
  && cd nginx-1.8.0 \
  && ./configure --prefix=/usr/local/nginx --add-module=/usr/local/src/nginx-rtmp-module \
  && make \
  && make install \
  && cp /usr/local/src/nginx-rtmp-module/stat.xsl /usr/local/nginx/html/ \
  && apk del build-base git \
  && rm -rf /var/cache/apk/* /var/tmp/* /tmp/* /usr/local/src/*

# forward request and error logs to docker log collector
RUN  ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
  && ln -sf /dev/stderr /usr/local/nginx/logs/error.log

COPY ./conf/nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 80 1935

CMD [ "/usr/local/nginx/sbin/nginx" ]
