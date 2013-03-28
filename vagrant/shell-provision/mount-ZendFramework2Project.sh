#!/bin/sh

if [ ! -d /var/www/zf2 ]
then
    mkdir -p /var/www/zf2
fi

mountpoint -q /var/www/zf2 || mount -t vboxsf ZendFramework2Project /var/www/zf2 -o dmode=775,fmode=775