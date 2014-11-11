FROM base/archlinux:latest

MAINTAINER Joshua Delsman <j@srv.im>

ONBUILD RUN \
  pacman --sync \
    --refresh \
    --sysupgrade \
    --noprogressbar \
    --noconfirm

COPY bin/gosu /usr/local/bin/

CMD [ "bash" ]
