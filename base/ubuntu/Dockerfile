FROM ubuntu:latest

ENV MIRROR="mirrors.ocf.berkeley.edu"

RUN sed -i "s|archive.ubuntu.com|$MIRROR|g" /etc/apt/sources.list \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install wget \
  && arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
  && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-$arch" \
  && chmod +x /usr/local/bin/gosu \
  && apt-get -y remove --purge wget \
  && apt-get -y autoremove --purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
