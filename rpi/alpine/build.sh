#!/bin/sh -xe
IMAGE="voxxit/alpine-rpi:latest"

docker build --no-cache --tag $IMAGE `dirname $0`
docker push $IMAGE
