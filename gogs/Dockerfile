FROM voxxit/base:alpine

ENV GOPATH   /go
ENV GOGSPATH $GOPATH/src/github.com/gogits/gogs
ENV PATH     $GOPATH/bin:$PATH

RUN  apk update \
  && apk add go git openssh \
  && curl -o /bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
  && chmod +x /bin/gosu \
  && mkdir -p $GOPATH/src $GOPATH/bin \
  && go get -u -tags "cert redis" github.com/gogits/gogs \
  && cd $GOGSPATH \
  && go build -tags "cert redis" \
  && adduser -h $GOGSPATH -s /bin/bash -D -H git \
  && apk del go \
  && rm -rf /var/cache/apk/*

WORKDIR $GOGSPATH

COPY ./app.ini $GOGSPATH/conf/app.ini
COPY ./run.sh  $GOGSPATH/scripts/run.sh

VOLUME [ "/go/src/github.com/gogits/gogs", "/var/lib/repos" ]

EXPOSE 22 3000

CMD [ "./scripts/run.sh" ]
