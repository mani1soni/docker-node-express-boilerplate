#!/bin/bash

#tagging the image with registry name
docker tag ${NODE_ENV}-$1:latest ${NODE_ENV}-$2:latest
docker tag ${NODE_ENV}-$1:latest ${NODE_ENV}-$2:${BUILD_NUMBER}

#pushing it on registry
docker push ${NODE_ENV}-$2:latest && /
docker push ${NODE_ENV}-$2:${BUILD_NUMBER} && /

#removing from local server
docker rmi ${NODE_ENV}-$2:latest ${NODE_ENV}-$2:${BUILD_NUMBER}
