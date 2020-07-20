#!/bin/sh

notify-send "NM Dispatcher" "HERE [$@]"
if [ "$1" = "LAN_interface" ]; then
    case "$2" in
        up)
            # nmcli radio wifi off
            notify-send "NM Dispatcher" "Radio OFF"
            ;;
        down)
            # nmcli radio wifi on
            notify-send "NM Dispatcher" "Radio OFF"
            ;;
    esac
fi
