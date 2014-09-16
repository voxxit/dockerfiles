FROM phusion/baseimage:latest

MAINTAINER @voxxit

ENV HOME /root

ADD start /start

RUN apt-get update && \
    apt-get install -y memcached sasl2-bin pwgen && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/postgresql/* && \
    chmod +x /start

EXPOSE 11211

CMD ["/start"]
