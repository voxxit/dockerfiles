FROM alpine:3.18

RUN  apk add --no-cache build-base git automake autoconf flex bison libtool oniguruma-dev \
  && git clone https://github.com/stedolan/jq.git /usr/local/src/jq \
  && cd /usr/local/src/jq \
  && autoreconf -i \
  && ./configure \
  && make -j$(getconf _NPROCESSORS_ONLN) \
  && make install \
  && apk del build-base git automake autoconf flex bison libtool oniguruma-dev \
  && rm -rf /usr/local/src/*

CMD [ "jq" ]
