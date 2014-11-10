FROM rovi/base:jessie

RUN apt-get update \
  && apt-get install -y build-essential libssl-dev libperl-dev \
  && cd /usr/local/src \
  && wget -O- http://znc.in/releases/znc-latest.tar.gz | tar xz \
  && cd znc-* \
  && ./configure --with-openssl \
  && make \
  && make install \
  && useradd -m -s /bin/bash -d /var/lib/znc znc \
  && apt-get -y remove build-essential \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /usr/local/src/*

# NOTE: some web browsers like chrome block port 6667,
# so I don't even bother exposing it. if you need to
# use the webadmin module, use -p flag at runtime to
# publish another desired port.

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
