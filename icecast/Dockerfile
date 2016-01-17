FROM alpine:latest

RUN  echo "http://repos.lax-noc.com/alpine/v3.3/main" > /etc/apk/repositories \
  && apk add --update \
        icecast \
        pwgen \
        build-base \
        libxml2-dev \
        libshout-dev \
  && mkdir -p /usr/src \
  && cd /usr/src \
  && wget http://downloads.us.xiph.org/releases/ices/ices-2.0.2.tar.gz \
  && tar -xzf ices-2.0.2.tar.gz \
  && cd ices-2.0.2/ \
  && ./configure --prefix=/usr \
  && make \
  && make install \
  && apk del build-base \
  && rm -rf /var/cache/apk/* /usr/src/*

COPY mime.types /etc/mime.types
COPY icecast.xml /etc/icecast.xml
COPY ices.xml /etc/ices.xml
COPY start-icecast.sh /usr/bin/start-icecast.sh
COPY start-ices.sh /usr/bin/start-ices.sh

EXPOSE 80/tcp

CMD [ "/usr/bin/start-icecast.sh" ]
