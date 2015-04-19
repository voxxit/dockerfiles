FROM voxxit/base:ubuntu

MAINTAINER Joshua Delsman <j@srv.im>

ENV MIRROR mirrors.digitalocean.com

RUN  sed -i "s/archive.ubuntu.com/$MIRROR/g" /etc/apt/sources.list \
  && apt-get -y update \
  && apt-get -y install wget \
  && cd /usr/local/bin \
  && wget -O- https://download-cdn.getsyncapp.com/stable/linux-x64/BitTorrent-Sync_x64.tar.gz | tar -xz \
  && apt-get -y remove --purge wget \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 8888 55555

VOLUME [ "/btsync" ]

ENTRYPOINT [ "/usr/local/bin/btsync" ]

CMD [ "--config", "/btsync/btsync.conf", "--nodaemon" ]
