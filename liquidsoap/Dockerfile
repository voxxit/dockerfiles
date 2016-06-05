FROM voxxit/base:ubuntu

MAINTAINER j@srv.im

RUN  apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install mp3gain liquidsoap liquidsoap-plugin-all \
  && rm -rf /var/lib/apt/lists/*

ENV LOG_NAME  "stream.log"

ENV PLAYLIST_DIR  "/media"

ENV LIVE_ENDPOINT "/live"
ENV LIVE_PORT     10000
ENV LIVE_PASSWORD "hackme"

ENV STREAM_URL    "http://example.com"
ENV STREAM_GENRE  "Various"
ENV STREAM_NAME   "Example Radio"

ENV ICECAST_HOSTNAME "stream.example.com"
ENV ICECAST_PORT     8000
ENV ICECAST_PASS     "hackme"

VOLUME [ "/media", "/var/log/liquidsoap" ]

EXPOSE 10000/tcp

COPY start-liquidsoap.sh /usr/bin/start-liquidsoap.sh

USER liquidsoap

ENTRYPOINT [ "/usr/bin/start-liquidsoap.sh" ]
