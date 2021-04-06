#! /bin/bash

# Easy solution to quickly reload nginx conf files
# ./nginx_hot_reload.sh

# Now dev in ./containers/nginx and your changes 
# are reloaded every time you save a file

DIR="$(pwd)"
ENV_FILE="$DIR/containers_configs/env.config"
NGINX_DIR="$DIR/containers/nginx"
CONTAINER="$DOCKER_NAMESPACE"_nginx_1

[ ! -r "$ENV_FILE" ] && echo "$ENV_FILE does not exist. Please create it." && exit
source "$ENV_FILE"

inotifywait -m -r -e modify "$NGINX_DIR" | while read path action file; do
    INTERNAL=$(echo $path | sed -e "s;$NGINX_DIR;/etc/nginx;g")
    FROM="$path$file"
    TO="$INTERNAL$file"

    echo ""
    echo ""
    echo "============================="
    echo "FROM: $FROM"
    echo "TO: $TO"
    echo "Copying and reloading conf..."
    echo "============================="
    echo ""
    docker cp "$FROM" "$CONTAINER:$TO"
done