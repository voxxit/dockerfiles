FROM voxxit/base:ubuntu

COPY . /

RUN  apt-get -y update \
  && apt-get -y install build-essential libpcre3-dev software-properties-common \
  && add-apt-repository ppa:maxmind/ppa \
  && apt-get -y update \
  && apt-get -y install libmaxminddb0 libmaxminddb-dev mmdb-bin \
  && cd zlib-1.2.8 \
  && ./configure && make && make install \
  && cd ../nginx-1.9.4 \
  && ./configure --add-module=/ngx_http_geoip2_module-1.0 && make && make install \
  && apt-get -y remove --purge build-essential \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /nginx-1.9.4 /ngx_http_geoip2_module-1.0 /zlib-1.2.8

RUN  echo "\ndaemon off;" >> /usr/local/nginx/conf/nginx.conf

WORKDIR /usr/local/nginx

CMD [ "/usr/local/nginx/sbin/nginx" ]

EXPOSE 80 443
