#!/bin/bash
docker pull $1
docker build -t $1-jenkins new-deployment/