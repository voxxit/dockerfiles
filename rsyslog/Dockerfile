FROM alpine:3.18

LABEL org.opencontainers.image.authors="j@srv.im"

RUN apk add --no-cache rsyslog

EXPOSE 514 514/udp

VOLUME [ "/var/log", "/etc/rsyslog.d" ]

# for some reason, the apk comes built with a v5
# config file. using this one for v8:
COPY --from=src ./etc/rsyslog.conf /etc/rsyslog.conf

ENTRYPOINT [ "rsyslogd", "-n" ]
