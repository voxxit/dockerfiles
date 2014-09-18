FROM phusion/baseimage:latest
MAINTAINER @voxxit

ENV HOME /root

RUN curl -sSL https://deb.nodesource.com/setup | bash - \
  && apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
    git-core \
    nodejs \
    libsqlite3-dev \
	  libmysqlclient-dev \
	  libpq-dev \
    make \
  && git clone --branch v0.4.3 --depth 1 https://github.com/postmodern/ruby-install.git /ruby-install \
  && cd ruby-install \
  && make install \
  && ruby-install -i /usr/local/ ruby -- --disable-install-rdoc \
  && gem update --system --no-document \
  && gem install bundler --no-document \
  && apt-get autoremove \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
