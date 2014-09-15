# voxxit/memcached

Docker image for [memcached 1.4.20](http://memcached.org), compiled from source with the latest security patches on Alpine Linux 3.0. This build also requires authenticated memcached calls using SASL.

### Getting Started

To use this container on its own:

```shell
$ docker run -d -p 11211:11211 --name memcached voxxit/memcached
```

### Username & Password

If you run the instance in the foreground (without `-d` or `--detach`) you'll be provided immediately with a username and password to connect using:

```shell
$ docker run --rm -it -p 11211:11211 voxxit/memcached
USERNAME=admin
PASSWORD=zf9bLafMTKmVedNHVYgR
```

You can also get this using `docker logs <container ID>` for detached instances.

Want to use your own username and/or password?

```shell
$ docker run -d -e USERNAME=voxxit PASSWORD=sos3cur3 voxxit/memcached
```

### Configuration

[All of memcached's options](https://code.google.com/p/memcached/wiki/NewConfiguringServer) are available to add on to the ENTRYPOINT:

```shell
$ docker run -d -e USERNAME=voxxit PASSWORD=sos3cur3 voxxit/memcached -m 512
```

### Custom ENTRYPOINT

Don't care about security and want to disable SASL? Want to use your own ENTRYPOINT, period? No problem!

```shell
docker run -it --entrypoint="sh" voxxit/memcached
```
