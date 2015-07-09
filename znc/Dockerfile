FROM debian:jessie

RUN  sed -i 's/httpredir.debian.org/mirrors.digitalocean.com/' /etc/apt/sources.list \
  && apt-get -y update \
  && apt-get -y install build-essential libssl-dev libperl-dev wget \
  && cd /usr/local/src \
  && wget -O- http://znc.in/releases/znc-latest.tar.gz | tar xz \
  && wget -O /usr/bin/gosu https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64 \
  && chmod +x /usr/bin/gosu \
  && cd znc-* \
  && ./configure --with-openssl \
  && make \
  && make install \
  && useradd -m -s /bin/bash -d /var/lib/znc znc \
  && apt-get -y remove build-essential wget \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /usr/local/src/*

EXPOSE 6667

COPY entrypoint.sh /entrypoint.sh

COPY zncstrap/webskins /usr/local/share/znc/
COPY zncstrap/modules /usr/local/share/znc/

ENTRYPOINT [ "/entrypoint.sh" ]
