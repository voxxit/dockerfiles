```
docker pull voxxit/icecast:latest
docker run \
  --detach \
  --publish 8000:8000 \
  --volume <icecast config>:/etc/icecast.xml:ro \
  --restart always \
  --name icecast \
  voxxit/icecast:latest
```
