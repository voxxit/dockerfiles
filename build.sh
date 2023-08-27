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

echo "Building: $image ..."

# Build the image:
if ! docker buildx build \
    --load \
    --pull \
    --tag "$image" \
    --cache-to type=local,dest="$cachedir" \
    --cache-from type=local,src="$cachedir" \
    "$context"; then
    echo "🚨 $image failed to build!"
    exit 1
fi

# Run a quick test to make sure the image is secure:
if ! docker scout quickview "$image"; then
    echo "🚨 $image failed security audit!"
    exit 1
fi

echo "✅ $image"
