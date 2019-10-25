#!/bin/bash
# Move terminal to scratchpad when using GUI application
mark_name="$RANDOM"
i3-msg -q mark "$mark_name"
i3-msg -q move window to scratchpad
$(which "$1") ${*:2}
i3-msg -q '[con_mark="'"$mark_name"'"] focus'
i3-msg -q move window to workspace current
i3-msg -q '[con_mark="'"$mark_name"'"] focus'
i3-msg -q floating disable
i3-msg -q unmark "$mark_name"
