FROM voxxit/base:alpine

ENV HOME /usr/local/gogs

COPY ./files/  $HOME

RUN  apk update \
  # install gogs dependencies & go
  && apk add libc-dev gcc go git openssh \
  # build gogs
  && export GOPATH=/go \
  && mkdir -p /go/src /go/bin \
  && go get -v -tags "sqlite redis memcache cert" github.com/gogits/gogs \
  && cd /go/src/github.com/gogits/gogs \
  && go install -v -tags "sqlite redis memcache cert" \
  && mv /go/bin/gogs ~/ \
  # add git user
  && adduser -h $HOME -s /bin/sh -D -H git \
  # cleanup
  && apk del libc-dev gcc go \
  && rm -rf /go/src /go/bin /var/cache/apk/*

WORKDIR $HOME

COPY ./run.sh  $HOME/scripts/run.sh

VOLUME [ "/usr/local/gogs/repos" ]

EXPOSE 22 3000

CMD [ "/usr/local/gogs/scripts/run.sh" ]
