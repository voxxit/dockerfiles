```
docker pull voxxit/icecast:latest
docker run -d -p 80:80 -v <icecast config>:/etc/icecast.xml:ro \
  --restart always --name icecast voxxit/icecast:latest
```
