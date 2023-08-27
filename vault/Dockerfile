FROM alpine:3.18.3

ARG VAULT_VERSION=0.6.1
ENV VAULT_VERSION ${VAULT_VERSION}

RUN  apk add --no-cache wget openssl ca-certificates \
  && wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
  && unzip vault_${VAULT_VERSION}_linux_amd64.zip \
  && mv vault /usr/local/bin/ \
  && rm -f vault_${VAULT_VERSION}_linux_amd64.zip \
  && apk del wget openssl ca-certificates

EXPOSE 8200/tcp

ENTRYPOINT [ "vault" ]
CMD [ "server", "-dev" ]
