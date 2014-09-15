#!/bin/bash

[ ! -f /.password ] && sh /src/sasl.sh

exec memcached -S -u memcached -l 0.0.0.0 $@
