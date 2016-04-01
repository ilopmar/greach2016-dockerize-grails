#!/bin/bash

DOCKER_USER_HOME=/home/user
CACHED_VOLUMES="m2 groovy grails gradle"

function get_cached_volumes {
    volumes_str=""
    for v in $CACHED_VOLUMES; do
        volumes_str+="-v $HOME/.$v:$DOCKER_USER_HOME/.$v "
    done
    echo $volumes_str
}

docker run -it --rm \
    -v `pwd`:$DOCKER_USER_HOME/work \
    `get_cached_volumes` \
    --entrypoint /home/user/entrypoint.sh \
    -v /var/run/docker.sock:/var/run/docker.sock \
    reverse-app/builder $1
