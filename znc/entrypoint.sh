#!/bin/sh

chown -R znc /var/lib/znc

/usr/local/bin/gosu znc /usr/local/bin/znc --datadir /var/lib/znc --foreground "$@"
