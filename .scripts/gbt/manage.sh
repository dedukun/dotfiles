#!/bin/bash
# Manage gbt scripts

MAN_CMD=$(echo -e "Logs\nMove\nOutputs\nCreate Project\nChoose Project\nShow Project" | dmenu -i -p "GBT Command: ")

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
    "Create Project")
        glbt_proj --new
        ;;
    "Choose Project")
        glbt_proj --choose
        ;;
    "Show Project")
        glbt_proj --show
        ;;
    "")
        # DO NOTHING
        ;;
    *)
        notify-send -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'"
        ;;
esac
