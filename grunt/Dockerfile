FROM voxxit/base:alpine

RUN  apk add --no-cache nodejs nodejs-dev npm git \
  && npm install -g npm@latest \
  && npm install -g grunt-cli bower

CMD [ "bash" ]
