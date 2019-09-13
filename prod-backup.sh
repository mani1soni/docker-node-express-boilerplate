#!/bin/bash

#tagging current image to backup image 
docker tag $1:latest $2:latest
docker tag $1:latest $2:$BUILD_NUMBER

#pushing images to registry
docker push $2:latest && /
docker push $2:$BUILD_NUMBER && /
#if push successfull then 
docker rmi $2:latest $2:$BUILD_NUMBER
echo "backup done"
