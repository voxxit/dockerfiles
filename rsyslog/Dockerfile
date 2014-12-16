FROM voxxit/base:alpine

MAINTAINER Joshua Delsman <j (at) srv.im>

RUN  apk update \
  && apk add rsyslog \
  && rm -rf /var/cache/apk/*

EXPOSE 514/tcp 514/udp

ENTRYPOINT [ "rsyslogd" ] 
CMD [ "-n" ]
