#!/bin/sh
# Depends on: xdotool, wmctrl

# SOURCE: https://faq.i3wm.org/question/4074/changing-window-title.1.html

FOCUSED=$(wmctrl -lp | grep $(xprop -root | grep _NET_ACTIVE_WINDOW | head -1 | awk '{print $5}' | sed 's/,//' | sed 's/^0x/0x0/'))
FPID=$(echo $FOCUSED | awk '{print $3}')
FNME=$(echo $FOCUSED | cut -f -4  -d ' ' --complement)
xdotool search -all --pid $FPID --name "$FNME" set_window -name "$*"
