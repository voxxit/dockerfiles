FROM scratch

MAINTAINER Joshua Delsman <j@srv.im>

ADD swarm_linux_amd64 /bin/swarm
ADD ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

EXPOSE 2375

ENTRYPOINT [ "/bin/swarm" ]
