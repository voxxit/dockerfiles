FROM voxxit/base:alpine

RUN apk update \
  && apk add redis \
  && rm -rf /var/cache/apk/lists/*

ENTRYPOINT [ "redis-server" ]
