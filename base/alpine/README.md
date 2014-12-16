== Testing

Each Alpine Linux container comes with [bats](https://github.com/sstephenson/bats) to test them:

```
$ docker run --rm -it -v "$(pwd)"/test.bats:/test.bats:ro voxxit/base:alpine bats /test.bats
1..1
ok 1 container should have a bats binary
```
