Simply the latest `ubuntu` (or `debian`) base images preconfigured to use the Docker host as the APT proxy.

### Using

```
FROM voxxit/cached-base:ubuntu
```

or 

```
FROM voxxit/cached-base:debian
```

### Building Locally

```
git clone https://github.com/voxxit/dockerfiles.git
cd dockerfiles/cached-base
docker build -t voxxit/cached-base .
```
