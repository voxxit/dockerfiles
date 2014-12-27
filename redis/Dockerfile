FROM voxxit/base:alpine

RUN apk update \
  && apk add redis \
  && rm -rf /var/cache/apk/lists/*

EXPOSE 6379

ENTRYPOINT [ "redis-server" ]
