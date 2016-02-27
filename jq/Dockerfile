FROM voxxit/base:alpine

RUN  apk add --update build-base git automake autoconf flex bison libtool \
  && git clone https://github.com/stedolan/jq.git /usr/local/src/jq \
  && cd /usr/local/src/jq \
  && autoreconf -i \
  && ./configure \
  && make \
  && make install \
  && apk del build-base git automake autoconf flex bison libtool \
  && rm -rf /usr/local/src/* /var/cache/apk/*

CMD [ "jq" ]
