FROM voxxit/base:alpine

RUN  apk update \
  && apk add goaccess \
  && rm -rf /var/cache/apk/*

ENTRYPOINT [ "goaccess" ]
