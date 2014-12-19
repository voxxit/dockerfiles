#!/bin/bash
set -e
set -x

URL=http://www.apache.org/dist/spamassassin/source/${RULES_FILE}

wget http://spamassassin.apache.org/updates/GPG.KEY ${URL} ${URL}.asc ${URL}.md5 ${URL}.sha1
sa-update --gpgkey GPG.KEY --install ${RULES_FILE}
rm -rf ${RULES_FILE}* GPG.KEY
