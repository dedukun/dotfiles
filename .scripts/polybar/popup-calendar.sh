#!/bin/sh
# Source: https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/popup-calendar/popup-calendar.sh

BAR_HEIGHT=23 # polybar height
BORDER_SIZE=1 # border size from your wm settings
YAD_WIDTH=241
YAD_HEIGHT=257
DATE="$(date +"%a, %d %b %H:%M:%S")"

case "$1" in
    --popup)
        if [ "$(xdotool getwindowfocus getwindowname)" = "yad-calendar" ]; then
            # on toggle, kill the calendar
            xdotool getwindowfocus windowkill
            exit 0
        fi

        eval "$(xdotool getmouselocation --shell)"
        WIDTH="$(xdpyinfo | awk '/dimensions/ {print $2}' | cut -d 'x' -f 1)"
        HEIGHT="$(xdpyinfo | awk '/dimensions/ {print $2}' | cut -d 'x' -f 2)"

        # X
        if [ "$((X + (YAD_WIDTH / 2) + BORDER_SIZE))" -gt "$WIDTH" ]; then #Right side
            : $((pos_x = WIDTH - YAD_WIDTH - BORDER_SIZE))
        elif [ "$((X - (YAD_WIDTH / 2) - BORDER_SIZE))" -lt 0 ]; then #Left side
            : $((pos_x = BORDER_SIZE))
        else #Center
            : $((pos_x = X - (YAD_WIDTH / 2)))
        fi

        # Y
        if [ "$Y" -gt "$((HEIGHT / 2))" ]; then #Bottom
            : $((pos_y = HEIGHT - YAD_HEIGHT - BAR_HEIGHT - BORDER_SIZE))
        else #Top
            : $((pos_y = BAR_HEIGHT + BORDER_SIZE))
        fi

        yad --calendar --undecorated --fixed --close-on-unfocus --no-buttons \
            --width="$YAD_WIDTH" --height="$YAD_HEIGHT" --posx="$pos_x" --posy="$pos_y" \
            --title="yad-calendar" --borders=0 >/dev/null &
        ;;
    *)
        echo "$DATE"
        ;;
esac
