FROM voxxit/base:alpine

MAINTAINER Joshua Delsman <j@srv.im>

ENV HOME      /usr/local/gogs
ENV GOGS_REPO "github.com/gogits/gogs"
ENV GOGS_TAGS "sqlite redis memcache cert"

WORKDIR $HOME

# install gogs dependencies & go
RUN  apk add --update libc-dev gcc curl go git openssh \
  # gogs v0.5.11
  && curl -fsSL -o /usr/local/gogs.zip http://git.io/mAWxew \
  && unzip -o /usr/local/gogs.zip \
  # build gogs
  && export GOPATH="/go" \
  && go get -v -tags $GOGS_TAGS $GOGS_REPO \
  && go build -v -tags $GOGS_TAGS $GOGS_REPO \
  # add git user
  && adduser -h /usr/local/gogs -s /bin/bash -D -H git \
  # cleanup
  && apk del libc-dev gcc go curl \
  && rm -rf /usr/local/gogs.zip /go /var/cache/apk/*

COPY ./run.sh  /usr/local/gogs/scripts/

VOLUME [ "/usr/local/gogs/repos" ]

EXPOSE 22 3000

CMD [ "/usr/local/gogs/scripts/run.sh" ]
