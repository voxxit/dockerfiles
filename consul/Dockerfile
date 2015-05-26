FROM voxxit/base:alpine

RUN apk update \
  && apk add make wget go git gcc musl-dev openssl-dev \
  && export GOPATH=/go \
  && go get -u -v github.com/hashicorp/consul \
  && cd /go/src/github.com/hashicorp/consul \
  && git checkout v0.5.2 \
  && make \
  && mv bin/consul /bin/ \
  && rm -rf /go \
  && cd /tmp \
  && wget -O ui.zip http://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip \
  && unzip ui.zip \
  && mv dist /ui \
  && rm ui.zip \
  && apk del make wget go git gcc musl-dev openssl-dev \
  && rm -rf /var/cache/apk/*

ENV GOMAXPROCS 2

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

VOLUME [ "/data", "/config" ]

ENTRYPOINT [ "/bin/consul" ]

CMD []
