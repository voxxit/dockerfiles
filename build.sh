#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <dir>"
    exit 1
fi

if ! command -v docker > /dev/null; then
    echo "Docker is not installed!"
    exit 1
fi

if ! docker buildx ls | grep -q buildkite-builder > /dev/null; then 
    echo "Creating buildx builder ..."

    docker buildx create \
        --use \
        --name=buildkite-builder \
        --driver=docker-container
fi 

cachedir="/tmp/.buildx-cache"
context="$1"
bname=$(basename "$context")
image="voxxit/$bname:latest"

echo
echo "----------------------------------------"
echo "🏗  $image"
echo

if ! docker buildx build \
    --pull \
    --progress=plain \
    --push \
    --tag "$image" \
    --cache-to type=local,dest="$cachedir" \
    --cache-from type=local,src="$cachedir" \
    "$context"
then
    echo "🚨 $image failed to build! 🚨"
    exit 1
fi

echo
echo "✅ $image built successfully! ✅"
echo
