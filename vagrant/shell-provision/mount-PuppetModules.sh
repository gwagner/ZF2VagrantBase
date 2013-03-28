#!/bin/sh

if [ ! -d /media/PuppetModules ]
then
    mkdir -p /media/PuppetModules
fi

mountpoint -q /media/PuppetModules || mount -t vboxsf PuppetModules /media/PuppetModules -o dmode=775,fmode=775