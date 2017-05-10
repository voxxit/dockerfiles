FROM ubuntu:latest

ENV MIRROR="mirrors.ocf.berkeley.edu"

RUN sed -i "s|archive.ubuntu.com|$MIRROR|g" /etc/apt/sources.list \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y autoremove --purge \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./bin/gosu /usr/local/bin/gosu
