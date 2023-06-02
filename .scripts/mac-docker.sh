#!/bin/sh

# https://github.com/sickcodes/Docker-OSX

# sudo systemctl enable --now libvirtd
# sudo systemctl enable --now virtlogd

#echo 1 | sudo tee /sys/module/kvm/parameters/ignore_msrs
#sudo modprobe kvm

# docker run -i \
#     --device /dev/kvm \
#     -p 50922:10022 \
#     -p 5999:5999 \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -e "DISPLAY=${DISPLAY:-:0.0}" \
#     -e EXTRA="-display none -vnc 0.0.0.0:99,password=on" \
#     sickcodes/docker-osx:big-sur

# docker start -ai 880643c6958c -e RAM=8
