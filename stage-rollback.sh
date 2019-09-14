#!/bin/bash
if [ ! "$(docker ps -a | grep $1)" ]; then
cd /home/manish/savetest/Staging/backup
docker load < $1.tar
docker run -d -p $2:$2 -v /home/ubuntu/logs:/root/.pm2/logs --name $1 $1
else
cd /home/manish/savetest/Staging/backup
docker load < $1.tar
docker start $1
fi

if [ ! "$(docker ps -a | grep $1-jenkins )" ]; then
echo "container does not exist"
else
echo "container exists"
docker rm -f $1-jenkins
fi

if [ ! "$(docker images | grep $1-jenkins:$BUILD_ID )" ]; then
    echo "image does not exist"
else
    echo "image exists"
	docker rmi $1-jenkins:$BUILD_ID
fi


