#!/bin/sh
#based on: https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/updates-pacman-aurhelper/updates-pacman-aurhelper.sh

if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2>/dev/null | wc -l); then
    updates_aur=0
fi

updates=$((updates_arch + updates_aur))

echo "$updates"
