#!/bin/bash
docker build -t $1-jenkins:$BUILD_ID .
docker run -d -p 5001:$2 -v /home/ubuntu/logs:/root/.pm2/logs --name $1-jenkins $1-jenkins:$BUILD_ID