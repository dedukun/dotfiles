#!/bin/bash
# Manage gbt scripts

MAN_CMD=$(echo -e "Logs\nMove\nOutputs\nNew Project" | dmenu -i -p "GBT Command: ")

case $MAN_CMD in
    "Logs")
        st glbt_log
        ;;
    "Move")
        notify-send -u critical -t 1500 "Move not implemented"
        ;;
    "Outputs")
        notify-send -u critical -t 1500 "Outputs not implemented"
        ;;
    "New Project")
        glbt_proj
        ;;
    *)
        notify-send -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'"
        ;;
esac
