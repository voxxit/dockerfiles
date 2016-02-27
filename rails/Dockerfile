FROM voxxit/base:alpine

RUN  apk add --update \
    make nodejs gcc libc-dev git ruby libxml2-dev libxslt-dev \
    libffi-dev yaml-dev openssl-dev zlib-dev readline-dev \
  && mkdir -p /usr/src/app \
  && git clone https://github.com/postmodern/ruby-install /usr/src/ruby-install \
  && cd /usr/src/ruby-install \
  && make install \
  && ruby-install --system ruby 2.2.0-rc1 -- --disable-install-rdoc \
  && gem install bundler --no-ri --no-rdoc \
  && bundle config --global build.nokogiri --use-system-libraries \
  && apk del ruby \
  && rm -rf /usr/src/* /var/cache/apk/*

WORKDIR /usr/src/app

ONBUILD COPY ./Gemfile /usr/src/app/
ONBUILD COPY ./Gemfile.lock /usr/src/app/

ONBUILD RUN bundle install --system

ONBUILD COPY . /usr/src/app

EXPOSE 3000/tcp

# replace in your Dockerfile with another ruby server, etc.
CMD bundle exec rails server
