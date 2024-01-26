#!/bin/bash
#
# original source: https://www.reddit.com/r/bspwm/comments/3xnwdf/i3_like_scratch_for_any_window_possible/cy6i585/

#***********************************************
#**==== P R I V A T E   F U N C T I O N S ====**
#***********************************************

_add_to_scratchpad() {
    xprop -id $1 -remove _SCRATCH_OUT
    xprop -id $1 -f _SCRATCH_IN 32ii -set _SCRATCH_IN $(date +%s,%N)
    [ -n "$2" ] && bspc node $1 -t \~floating
    xdotool windowunmap $1
}

_remove_to_scratchpad() {
    xprop -id $1 -remove _SCRATCH_IN
    xprop -id $1 -f _SCRATCH_OUT 32ii -set _SCRATCH_OUT $(date +%s,%N)
    bspc rule -a \* state=floating center=true --one-shot
    xdotool windowmap $1
}

#***********************************************
#**===== P U B L I C   F U N C T I O N S =====**
#***********************************************

send_to_scratchpad() {
    id=$(bspc query -N -n "focused")
    if [ -n "$id" ]; then
        _add_to_scratchpad "$id" "yes"
    fi
}

cycle_scratchpad() {
    ids=$(bspc query -N -n ".floating")
    added=0
    if [ -n "$ids" ]; then
        while read -r i; do
            t=$(xprop -id $i _SCRATCH_OUT | grep ' = \(.*\)')
            if [ -n "$t" ]; then
                _add_to_scratchpad "$i"
                added=$((added+1))
            fi
        done < <(echo "$ids")
    fi

    if [ \( -z "$ids" \) -o \( -n "$ids" -a "$added" -eq 0 \) ]; then
        i=$(for w in $(xwininfo -root -children | grep -e "^\s*0x[0-9a-f]\+" -o); do
            t=$(xprop -id $w _SCRATCH_IN | grep ' = \(.*\)')
            if [ -n "$t" ]; then
                echo $t $w
            fi
        done | sort -n | head -n1 | cut -d" " -f 5)

        if [ -n "$i" ]; then
            _remove_to_scratchpad $i
        fi
    fi
}

case $1 in
    send) send_to_scratchpad ;;
    cycle) cycle_scratchpad ;;
    *) echo "UNKOWN" && exit 1 ;;
esac
