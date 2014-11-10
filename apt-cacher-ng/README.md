### Running

```
docker run -d -v /var/cache/apt-cacher-ng --name apt-cache-data tianon/true
docker run -d -p 3142:3142 --volumes-from apt-cache-data --name apt-cache voxxit/apt-cacher-ng
```

### Using

```
FROM debian:jessie

RUN echo 'Acquire::http::Proxy "http://172.17.42.1:3142";' | tee /etc/apt/apt.conf.d/02proxy \
  && apt-get update \
  && apt-get -y upgrade
```
