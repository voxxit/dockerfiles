FROM uggedal/alpine-3.0

MAINTAINER Joshua Delsman <j@voxxit.com>

ADD ./ruby-install-0.4.3.tar.gz .

ENV RUBY_VERSION 2.1.2
ENV DEFAULT_GEMS nokogiri bundler foreman pg
ENV PATH /opt/ruby/bin:$PATH
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1

# Use an Alpine repo local to me for my builds. More listed here:
# http://git.alpinelinux.org/cgit/aports/plain/main/alpine-mirrors/mirrors.yaml
RUN echo "http://repos.lax-noc.com/alpine/v3.0/main" > /etc/apk/repositories && \
# Update the source repositories
    apk update &&  \
# Add packages essential to build Ruby
    apk add \
      postgresql-dev    \
      libxml2-dev       \
      libxslt-dev       \
      automake          \
      bash              \
      build-base        \
      coreutils         \
      gdbm-dev          \
      libffi-dev        \
      openssl-dev       \
      readline-dev      \
      zlib-dev          \
      ruby-libs         \
# See GitHub for information on how to use $OPTIONAL_PKGS
      $OPTIONAL_PKGS && \
# Install ruby-install: https://github.com/postmodern/ruby-install
    cd /ruby-install-* && \
    make install && \
# Install Ruby
    ruby-install ruby $RUBY_VERSION -- --disable-install-rdoc && \
# Symlink Ruby binaries to /opt/ruby/bin
    ln -s /opt/rubies/ruby-$RUBY_VERSION /opt/ruby && \
# Install bundler + default gems
    gem update --system --no-document && \
    gem install $DEFAULT_GEMS --no-document && \
# Clean up the mess
    rm -rf /usr/local/src/* && \
    apk del \
      postgresql-dev    \
      libxml2-dev       \
      libxslt-dev       \
      automake          \
      bash              \
      build-base        \
      coreutils         \
      gdbm-dev          \
      libffi-dev        \
      openssl-dev       \
      readline-dev      \
      zlib-dev          \
      ruby-libs      && \
    rm -rf /var/cache/apk/* && \
    rm -rf /ruby-install-*

# Default command; easily overwritten in either a child Dockerfile or
# on the command line with `docker run voxxit/ruby rake test`
CMD ["sh"]
