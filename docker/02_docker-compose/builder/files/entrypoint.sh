#!/bin/bash

function build-postgresql {
    echo "##########################"
    echo "# Building postgresql... #"
    echo "##########################"
    sudo docker build -t reverse-app/postgresql ./postgresql/
}

function build-rabbitmq {
    echo "########################"
    echo "# Building rabbitmq... #"
    echo "########################"
    sudo docker build -t reverse-app/rabbitmq ./rabbitmq/
}


function build-producer {
    echo "########################"
    echo "# Building producer... #"
    echo "########################"
    (cd work/producer && ./gradlew clean build prepareDocker && \
        sudo docker build -t reverse-app/producer ./build/docker/)
}

function build-consumer {
    echo "########################"
    echo "# Building consumer... #"
    echo "########################"
    (cd work/consumer && ./gradlew clean build prepareDocker && \
        sudo docker build -t reverse-app/consumer ./build/docker/)
}


case $1 in
    postgresql)
        build-postgresql
        ;;
    rabbitmq)
        build-rabbitmq
        ;;
    producer)
        build-producer
        ;;
    consumer)
        build-consumer
        ;;
    all)
        build-postgresql
        build-rabbitmq
        build-producer
        build-consumer
        ;;
    *)
        echo "USAGE: $0 [ postgresql | rabbitmq | producer | consumer | all ]"
        exit 1
        ;;
esac
