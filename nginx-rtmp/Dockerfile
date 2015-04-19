FROM ubuntu:latest

RUN  apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install wget build-essential git-core libssl-dev libpcre3-dev \
  && cd /usr/local/src \
  && git clone git://github.com/arut/nginx-rtmp-module.git \
  && wget -qO- http://nginx.org/download/nginx-1.7.12.tar.gz | tar -xz \
  && cd nginx-1.7.12 \
  && ./configure --prefix=/usr/local/nginx --add-module=/usr/local/src/nginx-rtmp-module \
  && make \
  && make install \
  && apt-get -y remove --purge wget build-essential git-core \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* /usr/local/src/*

# forward request and error logs to docker log collector
RUN  ln -sf /dev/stdout /usr/local/nginx/logs/access.log \
  && ln -sf /dev/stderr /usr/local/nginx/logs/error.log

COPY ./conf/nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 80 1935

CMD [ "/usr/local/nginx/sbin/nginx" ]
