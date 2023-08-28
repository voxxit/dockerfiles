FROM debian:bullseye-slim

LABEL org.opencontainers.image.authors="j@srv.im"

ENV PG_VERSION="9.3"
ENV PGDATA="/var/lib/postgresql/${PG_VERSION}/main"

EXPOSE 5432/tcp

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y lsb-release curl gnupg && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
  curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends postgresql-${PG_VERSION} postgresql-client-${PG_VERSION} postgresql-contrib-${PG_VERSION} pwgen && \
  apt-get clean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/lib/postgresql/*

VOLUME ["/var/lib/postgresql"]

COPY --from=src start /start

CMD ["/start"]
