FROM base/archlinux:latest

RUN  pacman -Syu --noconfirm salt-raet python2-pip python2-pygit2 python2-redis \
  && pip2 install six

COPY ./minion.sh /usr/local/bin/minion
COPY ./master.sh /usr/local/bin/master

VOLUME [ "/etc/salt", "/var/cache/salt", "/var/log/salt", "/srv/salt" ]

# salt-master
EXPOSE 4505/tcp 4506/tcp

CMD [ "salt" ]
