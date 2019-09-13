#!/bin/bash 

if [ ! -d "/home/manish/savetest/Staging/backup/" ];
then
        cd /home/manish/savetest
        mkdir -p Staging/backup
        cd Staging/backup
        docker save $1 > $1.tar
else
        cd /home/manish/savetest/Staging/backup
        docker save $1 > $1.tar
fi









