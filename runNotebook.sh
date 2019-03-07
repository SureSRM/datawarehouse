#!/bin/bash
IMAGE_NAME=localhost:5000/jupyter-datawarehouse

if ! docker image inspect $IMAGE_NAME &>/dev/null; then
    docker build -t $IMAGE_NAME .
fi

docker run --rm \
--network host \
-e JUPYTER_ENABLE_LAB=yes \
-v $(pwd):/home/jovyan/work \
$IMAGE_NAME


if [[ $1 == '--rm' ]]; then
    docker rmi $IMAGE_NAME
fi
