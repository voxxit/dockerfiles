FROM ubuntu:latest

RUN  apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get -y install pdns-server pdns-backend-mysql dnsutils \
  && rm -rf /var/lib/apt/lists/*

COPY *.conf /etc/powerdns/pdns.d/

EXPOSE 53/tcp 53/udp
EXPOSE 8081/tcp

CMD [ "pdns_server" ]
