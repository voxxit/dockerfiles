FROM phusion/baseimage:latest
MAINTAINER @voxxit

ENV HOME /root

RUN curl -sSL https://deb.nodesource.com/setup | bash - \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
    nodejs \
    libsqlite3-dev \
	  libmysqlclient-dev \
	  libpq-dev \
    make \
  && curl -sSL https://github.com/postmodern/ruby-install/archive/v0.4.3.tar.gz | tar -xz \
  && cd ruby-install-0.4.3 \
  && make install \
  && ruby-install -i /usr/local/ ruby -- --disable-install-rdoc \
  && gem update --system --no-document \
  && gem install bundler --no-document \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
