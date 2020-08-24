#!/bin/bash
# source: https://www.reddit.com/r/bspwm/comments/gz5rt5/window_swallowing/ftl2lbf/

NODE_CURRENT=$(bspc query -N -n focused)
$@ &
WATCH=$(bspc subscribe -c 1 node_add)
NODE_NEW=${WATCH##* }
bspc node $NODE_CURRENT --flag hidden=on
while read EVENT; do
    [ "${EVENT##* }" = "$NODE_NEW" ] && break
done < <(bspc subscribe node_remove)
bspc node $NODE_CURRENT --flag hidden=off
bspc node $NODE_CURRENT --focus
