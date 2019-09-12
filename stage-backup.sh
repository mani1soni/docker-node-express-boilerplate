#!/bin/bash 
cd ~/savetest
mkdir -p Staging/backup
cd Staging/backup

docker save $1 > $1.tar 








