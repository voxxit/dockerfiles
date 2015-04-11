FROM voxxit/base:alpine

ENV BUILD_DEPS build-base automake autoconf libtool git
ENV RUN_DEPS   libxslt-dev libxml2-dev libogg-dev libtheora-dev libvorbis-dev speex-dev

RUN  apk update \
  && apk upgrade \
  && apk add $BUILD_DEPS $RUN_DEPS \
  && cd /usr/local/src \
    && wget -O- http://downloads.xiph.org/releases/icecast/icecast-2.5-beta1.tar.gz | tar -xz \
    && cd icecast* \
    && ./configure \
    && make \
    && adduser -h /var/log/icecast -s /sbin/nologin -D icecast \
    && install -d -D -o icecast -g icecast /var/log/icecast \
    && touch /etc/mime.types \
    && make install \
  && apk del $BUILD_DEPS \
  && rm -rf /var/cache/apk/* /usr/local/src/*

COPY icecast.xml /etc/icecast.xml

EXPOSE 80

CMD [ "icecast", "-c", "/etc/icecast.xml" ]
