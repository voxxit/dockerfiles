FROM uggedal/alpine-3.0

MAINTAINER Joshua Delsman <j@voxxit.com>

ENV USERNAME admin

ADD src/ /src/

# get ready to run
RUN chmod +x /src/run.sh /src/sasl.sh && \
# update source repos & install dependencies
    apk update && \
    apk add cyrus-sasl cyrus-sasl-dev libevent libevent-dev build-base pwgen && \
    adduser -H -s /sbin/nologin -D memcached && \
# install memcached
    cd /src/memcached-1.4.20-patched && \
    ./configure --prefix=/usr --enable-sasl && \
    make && \
    make install && \
# cleanup
    rm -rf /src/memcached-1.4.20-patched/ && \
    apk del cyrus-sasl-dev libevent-dev build-base --purge

EXPOSE 11211

WORKDIR /

CMD ["/src/run.sh"]
