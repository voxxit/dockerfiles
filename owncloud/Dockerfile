FROM ubuntu:12.04

MAINTAINER Joshua Delsman <j@srv.im>

ENV APP_DATA /var/www/owncloud/data

ADD http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_12.04/Release.key /Release.key

COPY ./nginx.conf /etc/nginx/sites-available/owncloud
COPY ./start.sh start.sh

RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_12.04/ /' | tee /etc/apt/sources.list.d/owncloud.list && \
  apt-key add - < Release.key && \
  apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y nginx owncloud php5-common php5-cli php5-fpm && \
  ln -s /etc/nginx/sites-available/owncloud /etc/nginx/sites-enabled/ && \
  echo "daemon off;" | tee -a /etc/nginx/nginx.conf && \
  sed -i -e "s/listen\ \=\ 127.0.0.1:9000/listen\ =\ \/var\/run\/php5-fpm.sock/g" /etc/php5/fpm/pool.d/www.conf

VOLUME [ "/var/www/owncloud/data" ]

EXPOSE 80

CMD [ "/start.sh" ]
