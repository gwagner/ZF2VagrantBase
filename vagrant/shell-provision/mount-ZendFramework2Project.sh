#!/bin/sh

if [ ! -d /var/www/zf2 ]
then
    mkdir -p /var/www/zf2
fi

mount -t vboxsf ZendFramework2Project /var/www/zf2 -o dmode=775,fmode=775