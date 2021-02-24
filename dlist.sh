#! /bin/sh

if [ -z "$1" ]; then
    docker ps
else
    docker ps | grep $1
fi