#!/bin/bash
# https://wiki.archlinux.org/title/Screen_capture#Via_a_virtual_webcam_video_feed

sudo modprobe v4l2loopback exclusive_caps=1 card_label=VirtualVideoDevice
wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video3 -x yuv420p --force-yuv
