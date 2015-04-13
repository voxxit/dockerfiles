FROM voxxit/base:ubuntu

MAINTAINER Joshua Delsman <j@srv.im>

ENV MIRROR mirrors.digitalocean.com

RUN  sed -i "s/archive.ubuntu.com/$MIRROR/g" /etc/apt/sources.list \
  && apt-get -y update \
  && apt-get -y install wget \
  && wget -O- http://download-new.utorrent.com/endpoint/btsync/os/linux-x64/track/stable | tar -xz \
  && apt-get -y remove --purge wget \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 8888 55555

ENTRYPOINT [ "btsync" ]

CMD [ "--config", "/btsync/btsync.conf", "--nodaemon" ]
