#!/bin/sh
#
# original source: https://github.com/turquoise-hexagon/dots/blob/master/wm/.local/bin/resize
# resize - resize window in a given direction

case $1 in
    east)
        dim=w
        dir=right
        falldir=left
        sign=+
        ;;
    west)
        dim=w
        dir=right
        falldir=left
        sign=-
        ;;
    north)
        dim=h
        dir=top
        falldir=bottom
        sign=-
        ;;
    south)
        dim=h
        dir=top
        falldir=bottom
        sign=+
        ;;
esac

case $2 in
    [0-9]*)
        percent=$2
        ;;

    *)
        percent=10
        # set a smaller percentage when floating
        bspc query -N -n focused.floating >/dev/null && percent=5
        ;;
esac

# get a percentage of the monitor resolution
var=$(($(wattr "$dim" "$(lsw -r)") * percent / 100))

case $dim in
    w)
        x=$sign$var
        y=0
        ;;
    h)
        y=$sign$var
        x=0
        ;;
esac

# try to resize in one direction
# fall back to the other if it fails
bspc node -z "$dir" "$x" "$y" || bspc node -z "$falldir" "$x" "$y"
