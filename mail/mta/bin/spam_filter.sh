#!/bin/bash
#
# spamfilter.sh
#
# Simple filter to plug SpamAssassin into the Postfix MTA
#
# Modified by Jeremy Morton
#
# This script should probably live at /usr/local/bin/spamfilter.sh
# ... and have 'chown root:root' and 'chmod 755' applied to it.
#
# For use with:
#     Postfix 20010228 or later
#     SpamAssassin 2.42 or later

# File locations:
SENDMAIL=/usr/sbin/sendmail
SPAMASSASSIN=/usr/bin/spamc

logger <<<"Spam filter piping to SpamAssassin, then to: $SENDMAIL $@"
${SPAMASSASSIN} | ${SENDMAIL} "$@"

exit $?
