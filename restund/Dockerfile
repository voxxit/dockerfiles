FROM ubuntu:latest

ADD http://creytiv.com/pub/re-0.4.10.tar.gz /usr/local/src/re.tar.gz
ADD http://creytiv.com/pub/restund-0.4.2.tar.gz /usr/local/src/restund.tar.gz

RUN apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install make gcc \
  && cd /usr/local/src \
  && tar zxf re.tar.gz \
  && tar zxf restund.tar.gz \
  && cd /usr/local/src/re-0.4.10 \
  && make \
  && make install \
  && ldconfig \
  && cd /usr/local/src/restund-0.4.2 \
  && make \
  && make install \
  && mkdir -p /etc/restund \
  && mv etc/restund.conf /etc/restund/restund.conf \
  && apt-get -y remove make gcc \
  && apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /usr/local/src/* /var/lib/apt/lists/* /tmp/*

VOLUME [ "/etc/restund" ]

EXPOSE 3478

CMD [ "restund", "-n", "-f", "/etc/restund/restund.conf" ]

