FROM ubuntu:jammy

LABEL org.opencontainers.image.authors="j@srv.im"

ENV LIQUIDSOAP_VERSION="2.2.0"

COPY install.sh /tmp/install.sh

RUN chmod +x /tmp/install.sh \
  && /tmp/install.sh "${LIQUIDSOAP_VERSION}" \
  && rm /tmp/install.sh

ENV LOG_NAME "stream.log"
ENV PLAYLIST_DIR "/media"
ENV LIVE_ENDPOINT "/live"
ENV LIVE_PORT 10000
ENV LIVE_PASSWORD "hackme"

ENV STREAM_URL "http://example.com"
ENV STREAM_GENRE "Various"
ENV STREAM_NAME "Example Radio"

ENV ICECAST_HOSTNAME "stream.example.com"
ENV ICECAST_PORT 8000
ENV ICECAST_PASS "hackme"

VOLUME [ "/media", "/var/log/liquidsoap" ]

EXPOSE 10000/tcp

COPY --chown=1001:1001 start-liquidsoap.sh /usr/bin/start-liquidsoap.sh
USER 1001:1001

ENTRYPOINT [ "/usr/bin/start-liquidsoap.sh" ]
