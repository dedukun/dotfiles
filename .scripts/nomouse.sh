#!/bin/sh
# This script toggles the touch pad and turns the cursor invisible if no external mouse is plugged.
# Requires unclutter, xinput

notify_send_flags='--replaces-process "no-mouse"'
notify_send_title='Mouse Control'

if [ $# = 1 ]; then
    if [ ! "$1" = "--no-delay" ]; then
        echo "Invalid command '$1'."
        exit 1
    fi
elif [ $# -gt 1 ]; then
    echo "Too many arguments"
    exit 1
fi

# Check if unclutter is running
if [ ! "$(pgrep unclutter)" ]; then

    # no delay
    if [ "$1" ]; then
        notify-send -t 1000 "$notify_send_title" "TouchPad -> off" "(no delay)"
    else
        notify-send -t 1000 "$notify_send_title" "TouchPad -> off"
    fi

    # Turn touchpad off
    xinput set-prop "ETPS/2 Elantech Touchpad" "Device Enabled" 0

    # make sure another instance of unclutter isn't running
    killall unclutter

    # Check if external mouse is plugged
    if [ ! "$(xinput list | grep -i mouse)" ]; then
        sleep 1

        unclutter -idle 0 &
    else
        sleep 1 # mouse plugged, unclutter with 3 sec delay

        # no delay
        if [ "$1" ]; then
            unclutter -idle 0 &
        else
            unclutter -idle 6 &
        fi
    fi
else

    notify-send -t 1000 "$notify_send_title" "TouchPad -> on"

    # Turn touchpad on
    xinput set-prop "ETPS/2 Elantech Touchpad" "Device Enabled" 1

    killall unclutter
fi
