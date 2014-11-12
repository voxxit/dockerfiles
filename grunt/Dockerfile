FROM alpinelinux/base:latest

ENV ALPINE_MIRROR http://repos.lax-noc.com/alpine/v3.1/main

RUN echo "$ALPINE_MIRROR" | tee /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add nodejs nodejs-dev git \
  && rm -rf /var/cache/apk/* \
  && npm install -g npm@latest \
  && npm install -g grunt-cli bower

CMD [ "bash" ]
