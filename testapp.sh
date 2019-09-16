#!/bin/bash
docker build -t $1-jenkins:${BUILD_ID} .
docker run -d  -v /home/ubuntu/logs:/root/.pm2/logs --name $1-jenkins $1-jenkins:$BUILD_ID
#docker exec $1-jenkins npm test /home/nodejs/app
