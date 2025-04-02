FROM scratch

LABEL org.opencontainers.image.authors="j@srv.im"

COPY swarm_linux_amd64 /bin/swarm
COPY ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 2375

ENTRYPOINT [ "/bin/swarm" ]
