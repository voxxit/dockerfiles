FROM phusion/baseimage:jammy-1.0.1

LABEL org.opencontainers.image.authors="j@srv.im"

ENV HOME /root

ADD start /start

RUN apt-get update && \
    apt-get install -y memcached sasl2-bin pwgen && \
    apt-get autoremove --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/postgresql/* && \
    chmod +x /start

EXPOSE 11211

CMD ["/start"]
