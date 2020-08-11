#!/bin/sh
# bspc config external_rules_command $0
notify-send "Window Informations" \
    "class=$2"$'\n'"instance=$3"$'\n'"$(xprop -id "$1" WM_NAME WM_COMMAND)"
