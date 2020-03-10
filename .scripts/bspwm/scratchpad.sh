#!/bin/sh
#
# original source: https://www.reddit.com/r/bspwm/comments/3xnwdf/i3_like_scratch_for_any_window_possible/cy6i585/

send_to_scratchpad() {
    id=$(bspc query -N -n "focused");
    if [ -n "$id" ]; then
        xprop -id $id -f _SCRATCH 32ii -set _SCRATCH $(date +%s,%N)
	bspc node $id -t \~floating
        xdotool windowunmap $id
    fi
}

cycle_scratchpad() {
    i=$(bspc query -N -n "focused.floating")
    if [ -n "$i" ]; then
	xprop -id $i -f _SCRATCH 32ii -set _SCRATCH $(date +%s,%N)
	xdotool windowunmap $i
    else
	i=`for w in $(xwininfo -root -children | grep -e "^\s*0x[0-9a-f]\+" -o);do
		t=$(xprop -id $w _SCRATCH | grep ' = \(.*\)');
		if [ -n "$t" ]; then
			echo $t $w;
		fi;
	   done|sort -n|head -n1|cut -d" " -f 5`

	if [ -n "$i" ]; then
		xprop -id $i -remove _SCRATCH
		bspc rule -a \* state=floating center=true --one-shot
		xdotool windowmap $i
	fi
    fi
}

case $1 in
    send)  send_to_scratchpad;;
    cycle)  cycle_scratchpad;;
    *) echo "UNKOWN" && exit 1;;
esac
