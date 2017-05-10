FROM voxxit/base:debian

MAINTAINER @voxxit

ENV PGDATA /var/lib/postgresql/9.3/main

EXPOSE 5432

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y lsb-release curl && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
  curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 pwgen && \
  apt-get clean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/postgresql/*

VOLUME ["/var/lib/postgresql"]

ADD start /start

CMD ["/bin/bash", "/start"]
