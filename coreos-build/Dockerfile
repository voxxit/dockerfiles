FROM debian:jessie

COPY . /build/

RUN apt-get update \
  && apt-get -y install curl genisoimage syslinux-utils

WORKDIR /build

CMD [ "/build/makeiso.sh" ]
