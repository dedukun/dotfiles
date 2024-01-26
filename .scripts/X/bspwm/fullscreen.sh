#!/bin/sh
# Simple script to toggle a node to fullscreen mode in bspwm
# from: https://github.com/BrodieRobertson/scripts/blob/master/bspwm/bspfullscreen
if [ -z "$(bspc query -N -n .focused.fullscreen -d focused)" ]; then
    bspc node focused.tiled -t fullscreen
else
    bspc node focused.fullscreen -t tiled
fi
