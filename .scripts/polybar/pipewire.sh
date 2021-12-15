#!/bin/sh

ICON_OFF=""
ICON_LOW=""
ICON_HIGH=""

update_sink() {
    sink=$(pw-play --list-targets | sed -n 's/^*[[:space:]]*\([[:digit:]]\+\):.*$/\1/p')
}

volume_up() {
    update_sink
    pactl set-sink-volume "$sink" +5%
}

volume_down() {
    update_sink
    pactl set-sink-volume "$sink" -5%
}

volume_mute() {
    update_sink
    pactl set-sink-mute "$sink" toggle
}

volume_print() {
    update_sink

    muted=$(pamixer --sink "$sink" --get-mute)

    if [ "$muted" = true ]; then
        echo "$ICON_OFF --"
    else
        volume=$(pamixer --sink "$sink" --get-volume)
        if [ $volume -eq 0 ]; then
            echo "$ICON_OFF $volume"
        elif [ $volume -lt 40 ]; then
            echo "$ICON_LOW $volume"
        else
            echo "$ICON_HIGH $volume"
        fi
    fi
}

listen() {
    volume_print

    pactl subscribe | while read -r event; do
        if echo "$event" | grep -qv "Client"; then
            volume_print
        fi
    done
}

case "$1" in
    --up)
        volume_up
        ;;
    --down)
        volume_down
        ;;
    --mute)
        volume_mute
        ;;
    *)
        listen
        ;;
esac
