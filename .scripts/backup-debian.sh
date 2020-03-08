#!/bin/sh

backup_date=$(date --iso-8601)-debian
backup_mount="/mnt/mnt1/DiogoNAO_APAGAR/borgbackup-debian"

sudo borg create --stats \
                 --one-file-system \
                 --compression lz4 \
                 --checkpoint-interval 86400 \
                 "$backup_mount"::"$backup_date" \
                 /home/dedukun/Android \
                 /home/dedukun/AndroidStudioProjects \
                 /home/dedukun/Applications \
                 /home/dedukun/Arduino \
                 /home/dedukun/Desktop \
                 /home/dedukun/Documents \
                 /home/dedukun/Downloads \
                 /home/dedukun/Globaltronic \
                 /home/dedukun/Globaltronic_Remote \
                 /home/dedukun/ipe.key \
                 /home/dedukun/MPLABXProjects \
                 /home/dedukun/Music \
                 /home/dedukun/Other \
                 /home/dedukun/Pictures \
                 /home/dedukun/Projects \
                 /home/dedukun/Public \
                 /home/dedukun/Repositories \
                 /home/dedukun/Shared \
                 /home/dedukun/snap \
                 /home/dedukun/Steam \
                 "/home/dedukun/VirtualBox VMs" \
                 /home/dedukun/.scripts
