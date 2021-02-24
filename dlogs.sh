#! /bin/sh


if [ -z "$1" ]; then
    echo "Usage:  dlogs CONTAINER"
    return
fi

CONTAINER=$(docker ps --format "{{.Names}}" | grep $1)
if [ -z "$CONTAINER" ]; then
    echo "Unable to find any matching containers."
    return
fi

echo "$CONTAINER" | xargs -L 1 docker logs -f