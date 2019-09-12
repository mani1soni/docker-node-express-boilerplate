#!/bin/bash 
cd /home/manish/savetest
mkdir -p Staging/backup
cd Staging/backup

docker save $1 > $1.tar 








