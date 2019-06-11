#!/bin/sh
# Manage gbt scripts

MAN_CMD=$(printf "Logs\nMove\nOutputs\nNew Project\nCreate Folders\nChoose Project\nChoose 'All' Project\nShow Project" | dmenu -i -p "GBT Command: ")

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
        glbt_proj --new
        ;;
    "Create Folders")
        glbt_proj --create-folders
        ;;
    "Choose Project")
        glbt_proj --choose
        ;;
    "Choose 'All' Project")
        glbt_proj --choose-all
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
