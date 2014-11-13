FROM ubuntu:14.04

MAINTAINER Joshua Delsman <j@srv.im>

RUN echo "deb http://ppa.launchpad.net/pritunl/ppa/ubuntu trusty main" \
    | tee /etc/apt/sources.list.d/pritunl.list \
  && gpg --keyserver keyserver.ubuntu.com --recv-keys C5B39158 \
  && gpg -a --export C5B39158 | apt-key add - \
  && apt-get update \
  && apt-get install -y pritunl \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 9700 1194 11194

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

CMD [ "/usr/bin/tail", "-f", "/var/log/pritunl.log" ]
