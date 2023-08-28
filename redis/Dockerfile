FROM alpine:3.18

RUN apk add --no-cache redis

EXPOSE 6379/tcp

ENTRYPOINT [ "redis-server" ]
