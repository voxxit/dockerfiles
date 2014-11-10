### Configuration

```
mkdir -p <data-dir>
docker run --rm -it -v <data-dir>:/var/lib/znc voxxit/znc --makeconf
```

### Running

```
docker run -d -p 16667:16667 -v <data-dir>:/var/lib/znc --name znc voxxit/znc
```
