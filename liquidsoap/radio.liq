#!/usr/bin/liquidsoap

set("log.stdout", true)
set("harbor.bind_addr", "0.0.0.0")

live  = input.harbor("live", port=10000, password="clok-hif-Zen-Baj-ryk-haip-Jo")
files = playlist.safe("/playlist.txt.local", mime_type="audio/mpegurl", reload=300, reload_mode="seconds")
radio = fallback(track_sensitive=false, [ live, files ])

output.icecast(
  %mp3.cbr(bitrate=128),
  mount="/live",
  url="http://stream.gayrad.io/live",
  genre="Electronic",
  description="Listen & chat for free - 24/7/365!",
  name="gayrad.io",
  host="172.17.42.1", port=8000, password="hackme",
  radio)
