FROM voxxit/base:ubuntu

RUN  apt-get update \
  && apt-get -y install --no-install-recommends pdns-server pdns-backend-mysql dnsutils \
  && rm -rf /var/lib/apt/lists/*

COPY *.conf /etc/powerdns/pdns.d/

EXPOSE 53/tcp 53/udp 8081/tcp

CMD [ "pdns_server" ]
