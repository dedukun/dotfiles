#!/bin/bash
# This script toggles the touch pad and turns the cursor invisible if no external mouse is plugged.
# Requires unclutter, xinput

# Check if unclutter is running
if [[ ! $(pgrep unclutter) ]]; then

    notify-send -t 1000 "TouchPad -> off"

    # Turn touchpad off
    synclient TouchpadOff='1';

    # Check if external mouse is plugged
    if [[ ! $(xinput list | grep -i mouse) ]]; then
        unclutter -idle 1 &
    else
        unclutter -idle 3 &         # mouse plugged, unclutter with 3 sec delay
    fi

else

    notify-send -t 1000 "TouchPad -> on"

    # Turn touchpad on
    synclient TouchpadOff='0';

    pkill unclutter
fi
