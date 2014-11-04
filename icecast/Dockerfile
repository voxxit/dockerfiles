#FROM voxxit/cached-base:debian
FROM voxxit/base:debian

MAINTAINER j@srv.im

EXPOSE 8000

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -y install icecast2 pwgen \
  && apt-get -y autoremove \
  && apt-get -y autoclean \
  && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

ENV SOURCE_LIMIT 5
ENV CLIENT_LIMIT 100

COPY ./bin/run.sh /usr/local/bin/
COPY ./icecast.xml /etc/icecast2/

CMD [ "/usr/local/bin/run.sh" ]
