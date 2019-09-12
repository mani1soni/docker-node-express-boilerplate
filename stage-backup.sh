#!/bin bash 

mkdir -p ~/Staging/backup
cd ~/Staging/backup

docker save ${NODE_ENV}-$1 > ${NODE_ENV}-$1.tar








