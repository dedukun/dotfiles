#!/bin/sh
# Use mod+TAB to switch between the two most recent windows
# [WIP]
i3-msg -q mark --add lastWSTMP
i3-msg -q [con_mark="lastWS"] focus
exit 0
sleep 0.5
i3-msg -q mark --add lastWSTMP2
sleep 0.5
i3-msg -q [con_mark="lastWSTMP"] focus
sleep 0.5
i3-msg -q mark --add lastWS
sleep 0.5
i3-msg -q [con_mark="lastWSTMP2"] focus
