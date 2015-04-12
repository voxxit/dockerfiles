FROM voxxit/base:ubuntu

MAINTAINER Joshua Delsman <j (at) srv.im>

RUN  apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install liquidsoap liquidsoap-plugin-all \
  && rm -rf /var/lib/apt/lists*

ENTRYPOINT [ "liquidsoap" ]
