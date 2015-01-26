#!/bin/bash
/usr/bin/spamc -d 127.0.0.1 -p 783 | /usr/sbin/sendmail "$@" && exit $?
