#!/bin/bash

#pulling backup image from registry 
docker pull $2:latest

#tagged it as current project name and deploy it on server
docker tag $2:latest $1:latest
docker run -d -p $3:$3 -v /home/ubuntu/logs:/root/.pm2/logs --name $1 $1

echo "rollback done"
