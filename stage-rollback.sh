#!/bin/bash

cd /home/manish/savetest/Staging/backup

docker load < $1.tar

docker run -d -p $2:$2 -v /home/ubuntu/logs:/root/.pm2/logs --name $1 $1


