FROM phusion/baseimage:latest

MAINTAINER @voxxit

ENV HOME /root
ENV PGDATA /var/lib/postgresql/9.3/main

EXPOSE 5432

ADD start /start

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 pwgen && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/postgresql/* && \
    chmod +x /start

VOLUME ["/var/lib/postgresql"]

CMD ["/start"]
