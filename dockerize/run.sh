#!/bin/bash
set -euo pipefail
NAME=dotfiles-staging
IMAGE=${NAME}-img

docker build -t "$IMAGE" .
docker run \
  --gpus all \
  -it \
  --name $NAME \
  $IMAGE
