FROM ubuntu:14.04

RUN echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu trusty main" | \
    tee /etc/apt/sources.list.d/nginx.list \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C \
  && apt-get update \
  && apt-get install -y \
    nginx \
    php5-fpm \
    php5-gd \
    php5-json \
    php5-mysql \
    php5-curl \
    php5-intl \
    php5-mcrypt \
    php5-imagick \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/* \
  && echo "daemon off;" | tee -a /etc/nginx/nginx.conf \
  && sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php5/fpm/php.ini

ADD ./nginx.conf /etc/nginx/sites-available/default
ADD ./owncloud-7.0.2.tar.bz2 /

RUN rm -rf /usr/share/nginx/html \
  && mv /owncloud /usr/share/nginx/html \
  && chown -R www-data: /usr/share/nginx/html

COPY start.sh /start.sh

EXPOSE 80

CMD [ "/start.sh" ]
