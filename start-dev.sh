#!/bin/bash

DOCKER_USER_HOME=/home/user
CACHED_VOLUMES="m2 gradle grails sdkman/candidates"

function get_cached_volumes() {
    volumes_str=""
    for v in $CACHED_VOLUMES; do
        volumes_str+="-v $HOME/.$v:$DOCKER_USER_HOME/.$v "
    done
    echo $volumes_str
}

docker run -it \
    -p 8080:8080 \
    -p 15672:15672 \
    -v `pwd`:$DOCKER_USER_HOME/work \
    `get_cached_volumes` \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    reverse-app/dev $*
