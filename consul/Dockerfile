FROM alpine:edge

ENV CONSUL_VERSION 0.6.4

RUN  apk add --no-cache wget ca-certificates \
  && wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip \
  && unzip consul_${CONSUL_VERSION}_linux_amd64.zip \
  && mv consul /bin/ \
  && rm -rf consul_${CONSUL_VERSION}_linux_amd64.zip \
  && cd /tmp \
  && wget -O ui.zip https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip \
  && unzip ui.zip \
  && mkdir -p /ui \
  && mv * /ui \
  && rm -rf /ui/ui.zip /tmp/*

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp

VOLUME [ "/data" ]

ENTRYPOINT [ "/bin/consul" ]

CMD [ "agent", "-data-dir", "/data" ]
