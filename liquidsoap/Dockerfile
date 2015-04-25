FROM voxxit/base:ubuntu

MAINTAINER j@srv.im

RUN  apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install mp3gain liquidsoap liquidsoap-plugin-all \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "liquidsoap" ]
