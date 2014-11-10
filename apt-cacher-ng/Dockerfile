FROM rovi/base:jessie

EXPOSE 3142
 
VOLUME [ "/var/cache/apt-cacher-ng" ]
 
RUN apt-get update \
  && apt-get install -y apt-cacher-ng --no-install-recommends \
  && echo "Acquire::http { Proxy \"http://127.0.0.1:3142\"; };" | tee /etc/apt/apt.conf.d/01proxy \
  && rm -rf /var/lib/apt/lists/*

CMD [ "/usr/sbin/apt-cacher-ng", "ForeGround=1" ]
