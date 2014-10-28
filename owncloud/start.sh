#!/bin/bash

chown -R www-data: $APP_DATA

service php5-fpm start
service nginx start