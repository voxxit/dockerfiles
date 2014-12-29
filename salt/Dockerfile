FROM base/archlinux:latest

RUN  pacman -Syu --noconfirm \
    git \
    python2 \
    python2-crypto \
    python2-jinja \
    python2-m2crypto \
    python2-msgpack \
    python2-pip \
    python2-pygit2 \
    python2-pyopenssl \
    python2-redis \
    python2-yaml \
    salt-zmq \
  && rm -rf /etc/salt /var/cache/salt /var/log/salt /run/salt /srv/salt \
  && useradd -d /salt -r -M -s /bin/nologin salt \
  && mkdir -p /salt \
  && chown -R salt /salt

VOLUME [ "/salt" ]

COPY ./etc/ /salt/etc/

ENV SALT_MASTER_CONFIG  /salt/etc/master
ENV SALT_MINION_CONFIG  /salt/etc/minion

EXPOSE 4505 4506

CMD chown -R salt /salt && salt
