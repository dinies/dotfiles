#!/bin/bash
set -euo pipefail
NAME=dotfiles-staging
IMAGE=${NAME}-img

DOCKER_COMMAND="docker run --gpus all"

docker build -t "$IMAGE" .
docker run \
  --gpus all \
  -it \
  --name $NAME \
  $IMAGE
