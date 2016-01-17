#!/bin/sh
set -x

install -d -o icecast -g icecast /var/log/ices

sed -i "s/SOURCE_PASSWORD/$2/g" /etc/ices.xml

exec ices /etc/ices.xml
