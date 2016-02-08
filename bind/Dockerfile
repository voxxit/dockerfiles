FROM voxxit/base:alpine

RUN apk add --update bind bind-doc bind-tools && rm -rf /var/cache/apk/*

COPY etc/bind/ /etc/bind/
COPY entrypoint.sh /sbin/entrypoint.sh

EXPOSE 53 53/udp

VOLUME ["/data"]

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["/usr/sbin/named", "-f", "-g"]
