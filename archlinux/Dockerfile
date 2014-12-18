FROM base/archlinux:latest

MAINTAINER Joshua Delsman <j (at) srv.im>

RUN curl -o /usr/local/bin/gosu -sSL https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64 \
  && chmod +x /usr/local/bin/gosu

ONBUILD RUN \
  pacman --sync \
    --refresh \
    --sysupgrade \
    --noprogressbar \
    --noconfirm

CMD [ "bash" ]
