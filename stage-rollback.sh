#!/bin/bash
if [ ! "$(docker ps -a | grep $1)" ]; then
echo "container does not exist"
cd /home/manish/savetest/Staging/backup
docker load < $1.tar
docker run -d -p $2:$2 -v /home/ubuntu/logs:/root/.pm2/logs --name $1 $1
else
cd /home/manish/savetest/Staging/backup
docker load < $1.tar
docker start $1
fi



