#!/bin/sh

battery_threshold=25
battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')

[ $battery_level -lt $battery_threshold ] && notify-send --icon=battery-empty -u critical "Low Battery" "Battery level is at ${battery_level}%!"
