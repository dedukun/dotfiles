#!/bin/sh

get_layout() {
    current_layout=$(setxkbmap -query | grep layout | awk '{ print $2; }')
    echo "$current_layout"
}

toggle() {
    case "$current_layout" in
        pt)
            setxkbmap us
            ;;
        us)
            setxkbmap pt
            ;;
        *)
            setxkbmap pt
            ;;
    esac
}

trap "toggle" USR1

while true; do
    get_layout

    sleep 60 &
    wait
done
