#!/bin/bash
$(aws ecr get-login --no-include-email --region ap-south-1)

#tagging the image with registry name
docker tag $1:latest $2-stage:latest


#pushing it on registry
docker push $2-stage:latest

#removing from local server
docker rmi $2-stage:latest 
