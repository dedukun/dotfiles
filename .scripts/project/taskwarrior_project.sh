#!/bin/sh
# Wrapper of taskwarrior per project

notify_send_title='Project TaskWarrior'

_get_project() {
    proj_name=$(grep -e "^proj=" "$1" | sed 's/proj=\s*// g')

    echo "$proj_name"
}

if [ "$1" = "gbt" ]; then
    config_file="$SCRIPTS/.cache/.gbt_project"
elif [ "$1" = "per" ]; then
    config_file="$SCRIPTS/.cache/.personal_project"
else
    notify-send -u critical -t 1500 "$notify_send_title" "Not a supported project area"
    exit 1
fi

project="$(_get_project $config_file)"

# remove project selection
shift

# run taskwarrior
TASKDATA="$project/.tasks" task "$@"
