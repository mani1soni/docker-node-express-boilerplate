#!/bin/bash

cd ~/Staging/backup

docker load < ${NODE_ENV}-$1.tar

docker run -d -p $2:$2 -v /home/ubuntu/logs:/root/.pm2/logs --name ${NODE_ENV}-$1 ${NODE_ENV}-$1


