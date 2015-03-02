#!/usr/bin/liquidsoap

set("log.stdout", true)
set("harbor.bind_addr", "0.0.0.0")

live  = input.harbor("/live", port=10000, password="clok-hif-Zen-Baj-ryk-haip-Jo")
files = playlist.safe("/media", reload=300, reload_mode="seconds")
radio = fallback(track_sensitive=false, [ live, files ])

output.icecast(
  %mp3.cbr(bitrate=128),
  mount="/",
  url="http://gayrad.io",
  genre="Electronic",
  description="Listen for free - 24/7/365!",
  name="gayrad.io",
  host="icecast", port=8000, password="yaT3bYlt3uM6kauC0oF3cyT1aX3",
  radio)
