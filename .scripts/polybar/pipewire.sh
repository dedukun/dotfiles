#!/bin/sh

get_volume() {
    volume=$(pamixer --get-volume-human)
    echo "$volume"
}

increase_volume() {
    volume=$(pamixer --get-volume-human)

    if [ $volume != "muted" ]; then
        pamixer --increase 1
    fi
}

decrease_volume() {
    volume=$(pamixer --get-volume-human)

    if [ $volume != "muted" ]; then
        pamixer --decrease 1
    fi
}

listen() {
    get_volume

    LANG=EN; pactl subscribe | while read -r event; do
        if printf "%s\n" "${event}" | grep --quiet "source" || printf "%s\n" "${event}" | grep --quiet "server"; then
            get_volume
        fi
    done
}

case $1 in
    "--up")
        increase_volume
        ;;
    "--down")
        decrease_volume
        ;;
    "--mute")
        pamixer --toggle-mute
        ;;
    *)
        listen
esac

