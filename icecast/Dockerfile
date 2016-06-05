FROM voxxit/base:alpine

RUN apk add --update icecast pwgen \
  && rm -rf /var/cache/apk/*

COPY mime.types /etc/mime.types
COPY icecast.xml /etc/icecast.xml
COPY start-icecast.sh /usr/bin/start-icecast.sh

EXPOSE 80/tcp

CMD [ "/usr/bin/start-icecast.sh" ]
