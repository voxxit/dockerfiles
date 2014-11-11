```
cp <your-ssh-key> ./key.pub
docker build -t coreos-build .
BUILD_ID=$(docker run -it -v $PWD/key.pub:/build/key.pub:ro coreos-build) \
  && docker cp $BUILD_ID:/build/coreos.alpha.iso . \
  && docker rm -f $BUILD_ID
```
