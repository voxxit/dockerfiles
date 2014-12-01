FROM alpinelinux/base:latest

ENV GOPATH   /go
ENV GOGSPATH /go/src/github.com/gogits/gogs
ENV PATH     /go/bin:$PATH

# config values
ENV SSH_PORT 22022
ENV CACHE_ADAPTER memory

RUN  echo "http://repos.lax-noc.com/alpine/edge/main" | tee /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add go git openssh \
  && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
  && chmod +x /usr/local/bin/gosu \
  && mkdir -p /go/src /go/bin \
  && go get -u -tags "cert redis" github.com/gogits/gogs \
  && cd $GOGSPATH \
  && mkdir -p $GOGSPATH/repos \
  && go build -tags "cert redis" \
  && adduser -h $GOGSPATH -s /bin/bash -D -H gogs \
  && sed -i 's/nodaemon=false/nodaemon=true/g' $GOGSPATH/etc/supervisord.conf \
  && apk del go \
  && rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/gogits/gogs

COPY ./app.ini /go/src/github.com/gogits/gogs/conf/app.ini
COPY ./run.sh  /go/src/github.com/gogits/gogs/scripts/run.sh

VOLUME [ "/go/src/github.com/gogits/gogs", "/var/lib/repos" ]

EXPOSE 3000 22022

CMD [ "./scripts/run.sh" ]
