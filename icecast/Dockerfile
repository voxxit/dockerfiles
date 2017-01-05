FROM alpine:edge

RUN apk add --no-cache icecast pwgen

COPY etc/* /etc/
COPY start-icecast.sh /start-icecast.sh

EXPOSE 80/tcp

CMD [ "/start-icecast.sh" ]
