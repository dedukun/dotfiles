#!/bin/sh
# Adapted from this post
# https://forum.armbian.com/topic/2925-shrink-boot-partition-on-sd-card/

if [ $(id -u) -ne 0 ]; then
    echo "You need to be root to run this script"
    exit
fi

modprobe loop
losetup -f
# losetup /dev/loop0 myimage.img
# partprobe /dev/loop0
# gparted /dev/loop0
# losetup -d /dev/loop0
# fdisk -l myimage.img
# truncate --size=$[(endsect+1)*512] myimage.img
