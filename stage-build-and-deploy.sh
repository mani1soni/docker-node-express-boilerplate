#!/bin/bash

while [ "BUILD"="true" ]
do

    if [ ! "$(docker ps -a | grep ${NODE_ENV}-$1)" ]; then
	echo "container does not exist"
	CONTAINER=false
    else
	echo "container exists"
	CONTAINER=true
    fi

    if [ ! "$(docker images | grep ${NODE_ENV}-$1)" ]; then
        echo "image does not exist"
	    IMAGE=false
    else
        echo "image exists"
	    IMAGE=true
    fi

    if [[ $CONTAINER = "true" ]] && [[ $IMAGE = "true" ]]; then
        docker rm -f ${NODE_ENV}-$1
        docker rmi ${NODE_ENV}-$1
        BUILD=start

    elif [[ $CONTAINER = "false" ]] && [[ $IMAGE = "true" ]]; then
        docker rmi ${NODE_ENV}-$1
        BUILD=start

    elif [[ $CONTAINER = "true" ]] && [[ $IMAGE = "false" ]]; then
        echo "image tag is removed and container is still running first remove untagged image manualy then run jenkins job again"

    elif [[ $CONTAINER = "false" ]] && [[ $IMAGE = "false" ]]; then
        BUILD=start
    fi

    if [ $BUILD = "start" ]; then 
	echo "container and image removed run build steps"
    docker build -t ${NODE_ENV}-$1 .
    docker run -d -p $2:$2 -v /home/ubuntu/logs:/root/.pm2/logs --name ${NODE_ENV}-$1 ${NODE_ENV}-$1
    else
	echo "container or image does not removed build steps are not going to run"
    fi
    BUILD=true
done
