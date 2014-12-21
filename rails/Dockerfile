FROM voxxit/base:alpine

RUN  apk update \
  && apk add ruby ruby-dev openssl-dev nodejs ca-certificates git \
  && gem install bundler puma --no-ri --no-rdoc \
  && npm install -g gulp bower \
  && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app

ONBUILD COPY ./Gemfile /usr/src/app/
ONBUILD COPY ./Gemfile.lock /usr/src/app/

ONBUILD RUN bundle install --system

ONBUILD COPY ./packages.json /usr/src/app/
ONBUILD COPY ./bower.json

ONBUILD RUN npm install && bower install --allow-root

ONBUILD COPY . /usr/src/app

EXPOSE 9292/tcp

CMD [ "puma" ]
