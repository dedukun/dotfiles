#!/bin/sh
# SOURCE: https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/pulseaudio-microphone

status() {
    MUTED=$(pacmd list-sources | awk '/\*/,EOF {print}' | awk '/muted/ {print $2; exit}')

    if [ "$MUTED" = "yes" ]; then
        echo ""
    else
        echo ""
    fi
}

listen() {
    status

    LANG=en_GB.UTF-8
    pactl subscribe | while read -r event; do
        if echo "$event" | grep -q "source" || echo "$event" | grep -q "server"; then
            status
        fi
    done
}

mute() {
    DEFAULT_SOURCE=$(pacmd list-sources | awk '/\*/,EOF {print $3; exit}')

    pacmd set-source-mute "$DEFAULT_SOURCE" $1
}

toggle() {
    MUTED=$(pacmd list-sources | awk '/\*/,EOF {print}' | awk '/muted/ {print $2; exit}')

    if [ "$MUTED" = "yes" ]; then
        mute 0
    else
        mute 1
    fi
}

case "$1" in
    --mute)
        mute 1
        ;;
    --unmute)
        mute 0
        ;;
    --toggle)
        toggle
        ;;
    *)
        listen
        ;;
esac
