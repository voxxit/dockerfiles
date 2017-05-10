FROM voxxit/base:ubuntu

ARG NGINX_VERSION="1.12.0"

RUN  apt-get update \
  && apt-get -y install --no-install-recommends wget build-essential libpcre3 libpcre3-dev libssl-dev git-core ca-certificates \
  && mkdir -p /usr/local/src \
  && cd /usr/local/src \
  && git clone https://github.com/sergey-dryabzhinsky/nginx-rtmp-module.git \
  && wget -qO- http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar -xz \
  && cd nginx-${NGINX_VERSION} \
  && ./configure \
       --with-http_ssl_module \
       --with-debug \
       --add-module=/usr/local/src/nginx-rtmp-module \
  && make -j`nproc` \
  && make install \
  && cp /usr/local/src/nginx-rtmp-module/stat.xsl /usr/local/nginx/html/ \
  && apt-get -y remove --purge build-essential git-core wget \
  && apt-get -y autoremove --purge \
  && rm -rf /usr/local/src/* /var/lib/apt/lists/*

# Forward request and error logs to Docker log collector
RUN  ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
  && ln -sf /dev/stderr /usr/local/nginx/logs/error.log

COPY conf/nginx.conf /usr/local/nginx/conf/

EXPOSE 80/tcp 1935/tcp

CMD [ "/usr/local/nginx/sbin/nginx" ]
