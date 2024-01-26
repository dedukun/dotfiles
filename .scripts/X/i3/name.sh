#!/bin/sh
#returns focused windows' name
id=$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')
xprop -id "$id" | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2
