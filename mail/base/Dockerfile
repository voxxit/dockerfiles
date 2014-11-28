FROM alpinelinux/base:latest

RUN  echo "http://repos.lax-noc.com/alpine/edge/main" | tee /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && rm -rf /var/cache/apk/*

ADD ./domains /domains
ADD ./aliases /aliases
ADD ./passwords /passwords
