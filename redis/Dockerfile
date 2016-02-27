FROM voxxit/base:alpine

RUN  apk add --update redis \
  && rm -rf /var/cache/apk/*

EXPOSE 6379

ENTRYPOINT [ "redis-server" ]
