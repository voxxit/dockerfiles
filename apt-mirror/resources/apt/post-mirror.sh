#!/bin/sh -e

## Anything in this file gets run AFTER the mirror has been run...
##
## Put your custom post-mirror operations in here, e.g:
##
##   - rsync'ing the installer files
##   - running clean.sh automatically

#rsync \
#  --recursive \
#  --times \
#  --links \
#  --hard-links \
#  --delete \
#  --delete-after \
#  rsync://...
