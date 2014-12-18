#!/bin/sh

# Download the playlist
cd /media
wget -i /playlist.txt -nc --no-check-certificate

# Create the local playlist file
cp /playlist.txt /playlist.txt.local
sed -i "s|^https://www.dropbox.com/s/.*/|/media/|g" /playlist.txt.local

# Start liquidsoap
gosu liquidsoap /radio.liq
