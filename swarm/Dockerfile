FROM scratch

LABEL org.opencontainers.image.authors="j@srv.im"

COPY --from=src swarm_linux_amd64 /bin/swarm
COPY --from=src ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 2375

ENTRYPOINT [ "/bin/swarm" ]
