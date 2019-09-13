#!/bin/bash
#$(aws ecr get-login --no-include-email --region ap-south-1)

#tagging the image with registry name
docker tag $1:latest $2-${NODE_ENV}:latest
docker tag $1:latest $2-${NODE_ENV}:$BUILD_NUMBER

#pushing it on registry
docker push $2-${NODE_ENV}:latest && \
docker push $2-${NODE_ENV}:$BUILD_NUMBER && \

#removing from local server
docker rmi $2-${NODE_ENV}:latest $2-${NODE_ENV}:$BUILD_NUMBER
