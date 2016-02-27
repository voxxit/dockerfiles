FROM voxxit/base:alpine

RUN  apk add --update goaccess \
  && rm -rf /var/cache/apk/*

ENTRYPOINT [ "goaccess" ]
