FROM voxxit/base:ubuntu

MAINTAINER Joshua Delsman <j (at) srv.im>

RUN apt-get -y update &&\
  apt-get -y install \
    liquidsoap \
    liquidsoap-plugin-icecast \
    liquidsoap-plugin-lame \
    liquidsoap-plugin-vorbis \
    liquidsoap-plugin-mad \
    liquidsoap-plugin-taglib \
    liquidsoap-plugin-ogg \
    liquidsoap-plugin-flac \
    liquidsoap-plugin-faad \
    liquidsoap-plugin-voaacenc &&\
  rm -rf /var/lib/apt/lists*

COPY ./radio.liq /
COPY ./playlist.txt /
COPY ./run.sh /

EXPOSE 10000

VOLUME [ "/media" ]

ENTRYPOINT [ "/run.sh" ]
