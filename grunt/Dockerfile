FROM alpine:3.18

LABEL org.opencontainers.image.authors="j@srv.im"

RUN  apk add --no-cache nodejs nodejs-dev npm git \
  && npm install -g npm@latest \
  && npm install -g grunt-cli bower

CMD [ "bash" ]
