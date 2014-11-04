FROM ubuntu:latest

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && echo 'Acquire::http::Proxy "http://172.17.42.1:3142";' | tee /etc/apt/apt.conf.d/02proxy
