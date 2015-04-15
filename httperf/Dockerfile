FROM ubuntu:latest

ENV VER 0.9.0

RUN  apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install --no-install-recommends \
    wget libtool autoconf make \
  && wget -O- ftp://ftp.hpl.hp.com/pub/httperf/httperf-$VER.tar.gz | tar -xz \
  && cd httperf-$VER \
  && ./configure \
  && make \
  && make install \
  && cd .. \
  && apt-get -y remove --purge wget libtool autoconf make \
  && apt-get -y autoremove \
  && rm -rf httperf-$VER /var/lib/apt/lists/*

ENTRYPOINT [ "httperf" ]
