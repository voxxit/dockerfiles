Piwik-in-a-box
--------------

This Dockerfile builds the open-source web analytics platform [Piwik](http://piwik.org) (currently version 2.10.0-b3) into a standard PHP 5/Apache image. Link a MySQL container, embed the code in your site and you're off to the races!

### Running

```
docker run \
  --detach \
  -e MYSQL_ROOT_PASSWORD=secretpassword \
  --name piwik-mysql \
  mysql:latest

docker run \
  --detach \
  --publish 80:80 \
  --link piwik-mysql:mysql \
  --name piwik \
  voxxit/piwik
```

Go to http://your.container.ip and you'll be placed into the setup process. During the database setup portion:

|             |  Value   |
|-------------|----------|
|Hostname     |mysql     |
|Username     |root      |
|Password     |[anything]|
|Database Name|[anything]|
