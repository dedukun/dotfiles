#!/bin/sh

battery_lock_threshold=15
battery_cache_file="$SCRIPTS/.cache/check_battery"

battery_noti_threshold=25
battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
battery_discharging=$(acpi -b | grep -P -o 'Discharging')

# Auxiliar function

_check_cache_and_notify() {
    # get the value in cache
    cache_value="$(cat $battery_cache_file)"

    # check if the current battery level is bellow the threshold
    if [ "$battery_level" -ge "$1" ]; then

        # check if the last check if different that the current value
        if [ "$cache_value" -ne "$1" ]; then
            echo "$1" >"$battery_cache_file"

            notify-send --icon=battery-empty -u critical "Low Battery" "Battery level is at ${battery_level}%!"

            if [ "$battery_level" -lt "$battery_lock_threshold" ]; then
                sleep 5s
                timeout 1s playerctl -a stop
                slock
                bspc wm -O eDP1 HDMI2
            fi
            return 0
        fi
    fi

    return 1
}

if [ -n "$battery_discharging" ]; then
    if [ $battery_level -lt $battery_noti_threshold ]; then
        _check_cache_and_notify 20 && exit 0
        _check_cache_and_notify 15 && exit 0
        _check_cache_and_notify 10 && exit 0
        _check_cache_and_notify 5 && exit 0

        notify-send --icon=battery-empty -u critical "Low Battery" "Battery level is at ${battery_level}%!"
    fi
fi
