FROM alpine:3.18

RUN apk add --no-cache bind bind-doc bind-tools

COPY --from=src etc/bind/ /etc/bind/
COPY --from=src entrypoint.sh /sbin/entrypoint.sh

EXPOSE 53/tcp 53/udp

VOLUME ["/data"]

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/sbin/named", "-f", "-g"]
