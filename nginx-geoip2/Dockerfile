FROM ubuntu:22.04

COPY . /

RUN  export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get -y install build-essential libpcre3-dev software-properties-common \
  && add-apt-repository ppa:maxmind/ppa \
  && apt-get update \
  && apt-get -y install libmaxminddb0 libmaxminddb-dev mmdb-bin \
  && cd zlib-1.2.8 \
  && ./configure \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && make install \
  && cd ../nginx-1.15.12 \
  && ./configure --add-module=/ngx_http_geoip2_module-1.0 \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && make install \
  && apt-get -y remove --purge build-essential \
  && apt-get -y autoremove --purge \
  && rm -rf /var/lib/apt/lists/* /nginx-1.15.12 /ngx_http_geoip2_module-1.0 /zlib-1.2.8

RUN  echo "\ndaemon off;" >> /usr/local/nginx/conf/nginx.conf

WORKDIR /usr/local/nginx

CMD [ "/usr/local/nginx/sbin/nginx" ]

EXPOSE 80 443
