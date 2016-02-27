FROM voxxit/base:alpine

MAINTAINER Joshua Delsman <j (at) srv.im>

ENV GEM_HOME /gems
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLE_APP_CONFIG $GEM_HOME

RUN  apk add --update git ruby ruby-mysql2 ruby-sqlite ruby-pg nodejs \
  && echo 'gem: --no-rdoc --no-ri' | tee -a "/root/.gemrc" \
  && gem update --system \
  && gem install bundler \
  && bundle config --global path "$GEM_HOME" \
  && bundle config --global bin "$GEM_HOME/bin" \
  && bundle config --global frozen 1 \
  && mkdir -p /usr/src/app \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src/app

ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/

ONBUILD RUN bundle install

ONBUILD COPY . /usr/src/app

CMD [ "irb" ]
