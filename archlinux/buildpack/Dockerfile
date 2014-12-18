FROM voxxit/archlinux:latest

MAINTAINER Joshua Delsman <j (at) srv.im>

RUN pacman \
    --sync \
    --noprogressbar \
    --noconfirm \
    --needed base-devel \
  && useradd -m builder

WORKDIR /home/builder
