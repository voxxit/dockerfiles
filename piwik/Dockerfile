FROM php:apache

ENV PIWIK_VERSION 2.10.0-b3

RUN  apt-get update \
  && apt-get install -y libjpeg9-dev libpng-dev libfreetype6-dev --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && cd /var/www/html \
  && curl http://builds.piwik.org/piwik-$PIWIK_VERSION.tar.gz | tar xz --strip-components=1 \
  && chown -R www-data:www-data /var/www/html \
  && echo "always_populate_raw_post_data=-1" | tee -a /usr/local/etc/php/conf.d/security.ini \
  && docker-php-ext-configure gd --with-jpeg-dir --with-png-dir --with-freetype-dir \
  && docker-php-ext-install gd pdo pdo_mysql mysqli mbstring
