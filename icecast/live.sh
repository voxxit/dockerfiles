#!/bin/sh

if [ -x $1 ]; then
  echo "usage: ./live.sh [--help] <device number>"
  exit 0
fi

if [ $1 = "--help" ]; then
  ffmpeg -f avfoundation -list_devices true -i ""
  exit 0
fi

NAME="${NAME-"tribal.FM"}"
GENRE="${GENRE-"Dance"}"
URL="${URL-"http://www.tribal.fm/"}"
HOSTNAME="${HOSTNAME-"192.168.99.100"}"
PASSWORD="${PASSWORD-"hackme"}"

ffmpeg -re -f avfoundation -i ":$1" \
  -c:a libopus -content_type "application/ogg" -b:a 48k -ice_name "${NAME} [LIVE] - OPUS 48K" -ice_genre $GENRE -ice_url $URL icecast://source:${PASSWORD}@${HOSTNAME}/stream.opus \
  -c:a libvorbis -content_type "application/ogg" -b:a 96k -ice_name "${NAME} [LIVE] - OGG 96K" -ice_genre $GENRE -ice_url $URL icecast://source:${PASSWORD}@${HOSTNAME}/stream.ogg \
  -c:a libmp3lame -b:a 128k -ice_name "${NAME} [LIVE] - MP3 128K" -ice_genre $GENRE -ice_url $URL icecast://source:${PASSWORD}@${HOSTNAME}/stream.mp3
