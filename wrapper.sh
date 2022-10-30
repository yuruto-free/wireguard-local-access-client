#!/bin/bash

function Usage() {
    echo $0 "build|start|down|stop|ps|logs|peers"
    echo "  Options:"
    echo "    * build"
    echo "            build docker image"
    echo "    * start"
    echo "            create containers and start them"
    echo "    * down"
    echo "            stop and destroy containers"
    echo "    * stop"
    echo "            stop containers"
    echo "    * ps"
    echo "            show process status for each containers"
    echo "    * logs"
    echo "            show log for each containers"
}

while [ -n "$1" ]; do
    case "$1" in
        help | -h )
            Usage
            exit 0
            ;;

        build )
            # build
            docker-compose build --no-cache
            # remove old images
            docker images | grep none | awk '{print $3;}' | xargs -I{} docker rmi {}
            shift
            ;;

        start )
            # create all containers
            docker-compose up -d
            shift
            ;;

        down | stop | ps )
            docker-compose "$1"
            shift
            ;;

        logs )
            docker-compose logs -t | sort -t "|" -k 1,+2d
            shift
            ;;

        * )
            shift
            ;;
    esac
done
