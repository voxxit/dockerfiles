FROM phusion/baseimage:latest

MAINTAINER @voxxit

ENV HOME /root

RUN sudo add-apt-repository ppa:brightbox/ruby-ng && \
  apt-get update && \
  apt-get -y install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev sqlite3 \
    libsqlite3-dev libxml2-dev libxslt1-dev libcurl4-openssl-dev ruby2.1 ruby2.1-dev postgresql-server-dev-9.3 && \
# Install bundler + default gems
  gem update --system --no-document && \
# Clean up the mess
  apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
