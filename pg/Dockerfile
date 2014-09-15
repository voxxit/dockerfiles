FROM uggedal/alpine-3.0

MAINTAINER Joshua Delsman <j@voxxit.com>

EXPOSE 5432

ENV PGDATA /var/lib/postgresql/9.3/main

ADD ./start /start

# Use an Alpine repo local to me for my builds. More listed here:
# http://git.alpinelinux.org/cgit/aports/plain/main/alpine-mirrors/mirrors.yaml
RUN echo "http://repos.lax-noc.com/alpine/v3.0/main" > /etc/apk/repositories && \
    apk update && \
# install postgresql
    apk add postgresql postgresql-client postgresql-contrib pwgen && \
# make the postgresql data directory & assign it to the 'postgres' user for future volume sanity
    mkdir -p "${PGDATA}" && \
	  chown -Rf postgres:postgres "${PGDATA}" && \
	  chmod 0700 "${PGDATA}" && \
# setup the run script
    chmod +x /start

VOLUME ["/var/lib/postgresql"]

CMD ["/start"]
