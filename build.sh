#!/bin/bash

# Find all directories containing a `Dockerfile*`, and return the
# directory name (excluding the ones with multiple layers):
dockerfile_dirs=$(find . -name "Dockerfile" -depth 2 -exec dirname {} \; | sort -u)

if [ -z "$dockerfile_dirs" ]; then
    echo "No Dockerfiles found!"
    exit 1
fi

if ! command -v docker > /dev/null; then
    echo "Docker is not installed!"
    exit 1
fi

docker buildx ls | grep -q buildkite-builder > /dev/null
if [ $? -ne 0 ]; then
    echo "Creating buildx builder ..."
    docker buildx create \
        --use \
        --name=buildkite-builder \
        --driver=docker-container
fi 

for dir in $dockerfile_dirs; do
    bname=$(basename "$dir")
    
    echo "Building: voxxit/$bname:latest ..."

    docker buildx build \
        --load \
        --pull \
        --tag "voxxit/$bname:latest" \
        --cache-to type=local,dest=/tmp/.buildx-cache \
        --cache-from type=local,src=/tmp/.buildx-cache \
        "$dir"
done