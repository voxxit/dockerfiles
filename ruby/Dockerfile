FROM debian:stable

MAINTAINER @voxxit

ENV HOME /root

# [optional] build a data-only container to share
# gems between projects which use this base image:
#
# docker run -d -v /gems/2.1 --name gems-2.1 tianon/true
#
ENV GEM_HOME /gems/2.1

# from: https://deb.nodesource.com/setup
ADD node-setup.sh /node-setup.sh

RUN bash /node-setup.sh \
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
