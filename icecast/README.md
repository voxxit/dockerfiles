```
docker run -d -v /var/log/icecast2 --name icecast-logs tianon/true
docker run -d -p 8000:8000 --volumes-from icecast-logs voxxit/icecast
```
