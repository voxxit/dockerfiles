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

if ! docker buildx ls | grep -q buildkite-builder > /dev/null; then 
    echo "Creating buildx builder ..."

    docker buildx create \
        --use \
        --name=buildkite-builder \
        --driver=docker-container
fi 

cachedir="/tmp/.buildx-cache"

for context in $dockerfile_dirs; do
    bname=$(basename "$context")
    image="voxxit/$bname:latest"
    
    echo "Building: $image ..."

    # Build the image:
    docker buildx build \
        --load \
        --pull \
        --tag "$image" \
        --cache-to type=local,dest="$cachedir" \
        --cache-from type=local,src="$cachedir" \
        "$context" && \
    # Run a quick test to make sure the image is secure:
    docker scout quickview "$image"

    echo "✅ $image"
done