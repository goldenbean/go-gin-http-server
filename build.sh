#!/usr/bin/env bash

function build() {
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

}

function docker_build() {
    docker build -t my-server:alpine .
}

function docker_run() {

    docker run -d -p 8080:8080 --name my-server -v /data/transmission:/data my-server:alpine
}

function clean() {
    docker stop my-server
    docker rm my-server
}


clean
build
docker_build
docker_run