FROM voxxit/base:alpine

RUN  apk add --update nodejs nodejs-dev git \
  && rm -rf /var/cache/apk/* \
  && npm install -g npm@latest \
  && npm install -g grunt-cli bower

CMD [ "bash" ]
