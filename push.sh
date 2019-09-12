#!/bin/bash

#tagging the image with registry name
docker tag $1:latest $2:latest
docker tag $1:latest $2:${BUILD_NUMBER}

#pushing it on registry
docker push $2:latest && /
docker push $2:${BUILD_NUMBER} && /

#removing from local server
docker rmi $2:latest $2:${BUILD_NUMBER}
