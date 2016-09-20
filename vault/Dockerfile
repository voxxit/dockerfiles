FROM voxxit/base:alpine

ARG VAULT_VERSION=0.6.1
ENV VAULT_VERSION ${VAULT_VERSION}

RUN  apk add --update wget openssl ca-certificates \
  && wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
  && unzip vault_${VAULT_VERSION}_linux_amd64.zip \
  && mv vault /usr/local/bin/ \
  && rm -f vault_${VAULT_VERSION}_linux_amd64.zip \
  && apk del wget openssl ca-certificates

EXPOSE 8200

ENTRYPOINT [ "vault" ]
CMD [ "server", "-dev" ]
