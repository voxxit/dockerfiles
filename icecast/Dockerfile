FROM alpine:3.16

ENV ICECAST_VERSION 2.5-beta3

RUN apk add --no-cache tar build-base pwgen libxslt-dev libvorbis-dev curl-dev libressl-dev libtheora-dev speex-dev opus-dev \
  && cd /tmp \
  && wget http://downloads.xiph.org/releases/icecast/icecast-${ICECAST_VERSION}.tar.gz -O- | tar -zx --strip-components=1 \
  && ./configure --prefix=/usr \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && make install \
  && rm -rf /tmp/* \
  && apk del --purge build-base

EXPOSE 80/tcp

RUN  addgroup -g 1000 icecast \
  && adduser -s /bin/false -G icecast -D -H -u 1000 icecast \
  && install -d -o icecast -g icecast /var/log/icecast \
  && install -d -o icecast -g icecast /etc/icecast \
  && chown -R icecast:icecast /usr/share/icecast

COPY --from=src etc/mime.types /etc/

USER icecast:icecast

COPY --from=src etc/icecast.xml /etc/icecast/
COPY --from=src docker-entrypoint.sh /

CMD [ "/docker-entrypoint.sh" ]
