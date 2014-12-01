FROM alpinelinux/base:latest

ENV GOPATH   /go
ENV GOGSPATH /go/src/github.com/gogits/gogs
ENV PATH     /go/bin:$PATH
ENV SSH_PORT 22022

RUN  echo "http://repos.lax-noc.com/alpine/edge/main" | tee /etc/apk/repositories \
  && apk update \
  && apk upgrade \
  && apk add go git openssh \
  && ssh-keygen -q -N '' -b 4096 -t rsa -f /etc/ssh/ssh_host_rsa_key \
  && ssh-keygen -q -N '' -b 1024 -t dsa -f /etc/ssh/ssh_host_dsa_key \
  && ssh-keygen -q -N '' -b 521 -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key \
  && ssh-keygen -q -N '' -b 256 -t ed25519 -f /etc/ssh/ssh_host_ed25519_key \
  && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
  && chmod +x /usr/local/bin/gosu \
  && mkdir -p /go/src /go/bin \
  && go get -u -tags "cert" github.com/gogits/gogs \
  && cd /go/src/github.com/gogits/gogs \
  && go build -tags "cert" \
  && adduser -h /repos -g "gogs user" -s /bin/bash -D gogs \
  && sed -i 's/nodaemon=false/nodaemon=true/g' /go/src/github.com/gogits/gogs/etc/supervisord.conf \
  && chown -R gogs:gogs /go/src/github.com/gogits/gogs \
  && apk del go \
  && rm -rf /var/cache/apk/*

WORKDIR /go/src/github.com/gogits/gogs

COPY ./app.ini /go/src/github.com/gogits/gogs/conf/app.ini
COPY ./run.sh  /go/src/github.com/gogits/gogs/scripts/run.sh

VOLUME [ "/go/src/github.com/gogits/gogs", "/repos" ]

EXPOSE 3000 22022

CMD [ "./scripts/run.sh" ]
