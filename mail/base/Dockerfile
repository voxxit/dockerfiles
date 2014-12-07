FROM voxxit/base:alpine

RUN  apk update \
  && apk add ca-certificates \
  && rm -rf /var/cache/apk/*

ADD ./domains   /domains
ADD ./aliases   /aliases
ADD ./passwords /passwords
