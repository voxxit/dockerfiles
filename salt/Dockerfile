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
  python2-redis \
  python2-yaml \
  salt-zmq

COPY minion.sh   /usr/local/bin/minion
COPY master.sh   /usr/local/bin/master

COPY minion.conf /etc/salt/minion
COPY master.conf /etc/salt/master

VOLUME [ "/etc/salt", "/var/cache/salt", "/var/log/salt", "/srv/salt" ]

EXPOSE 4505 4506

CMD [ "salt" ]
