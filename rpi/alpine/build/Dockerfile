FROM ubuntu:latest

ENV MIRROR  http://repos.lax-noc.com/alpine
ENV VERSION v3.1
ENV APK_VER 2.5.0_rc1-r0

RUN  apt-get -y update \
  && apt-get -y install curl tar gzip \
  && rm -rf /var/lib/apt/lists/*

COPY mkimage.sh /

CMD [ "/mkimage.sh" ]
