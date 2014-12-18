FROM scratch

MAINTAINER Joshua Delsman <j (at) srv.im>

ADD swarm_linux_amd64 /bin/swarm
ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 4243

ENTRYPOINT [ "/bin/swarm" ]
