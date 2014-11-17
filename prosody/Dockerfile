FROM ubuntu:utopic

COPY bin/gosu /usr/local/bin/
COPY prosody-debian-packages.key /

VOLUME [ "/data" ]

RUN echo "deb http://packages.prosody.im/debian trusty main" | tee /etc/apt/sources.list.d/prosody.list \
  && apt-key add /prosody-debian-packages.key \
  && rm -rf /prosody-debian-packages.key \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    prosody \
    lua-event \
    lua-dbi-postgresql \
    lua-dbi-mysql \
    lua-dbi-sqlite3 \
  && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

COPY prosody.cfg.lua /etc/prosody/prosody.cfg.lua
COPY run.sh /run.sh

EXPOSE 5222 5269 5280 5281

CMD [ "/run.sh" ]
