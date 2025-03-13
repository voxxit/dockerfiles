FROM alpine:3.21

RUN apk add --no-cache \
  bash make nodejs gcc libc-dev git ruby libxml2-dev libxslt-dev \
  libffi-dev yaml-dev openssl-dev zlib-dev readline-dev \
  && mkdir -p /usr/src/app \
  && git clone https://github.com/postmodern/ruby-install /usr/src/ruby-install \
  && cd /usr/src/ruby-install \
  && make install \
  && ruby-install --system ruby 3.0.6 -- --disable-install-rdoc \
  && gem install bundler rails -v 6.1.7.10 \
  && bundle config --global build.nokogiri --use-system-libraries \
  && apk del ruby \
  && rm -rf /usr/src/*

WORKDIR /usr/src/app

ONBUILD COPY ./Gemfile /usr/src/app/
ONBUILD COPY ./Gemfile.lock /usr/src/app/

ONBUILD RUN bundle install --system

ONBUILD COPY . /usr/src/app

EXPOSE 3000/tcp

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"] 