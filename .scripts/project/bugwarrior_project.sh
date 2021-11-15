#!/bin/bash
# Wrapper of taskwarrior per project

print_color=$'\e[0;30m'
print_color_bold=$'\e[1;30m'
color_reset=$'\e[0m'
notify_send_title='Project TaskWarrior'

_get_project() {
    proj_name=$(grep -e "^proj=" "$1" | sed 's/proj=\s*// g')

    echo "$proj_name"
}

if [ "$1" = "gbt" ]; then
    config_file="$SCRIPTS/.cache/.gbt_project"
    proj_folder="$GBT_PROJECTS"
elif [ "$1" = "per" ]; then
    config_file="$SCRIPTS/.cache/.personal_project"
    proj_folder="$PERSONAL_PROJECTS"
else
    notify-send -u critical -t 1500 "$notify_send_title" "Not a supported project area"
    exit 1
fi

project="$(_get_project $config_file)"

# remove project selection
shift

printf '%sProject: %s%s%s\n' "$print_color" "$print_color_bold" "$project" "$color_reset"

# run taskwarrior
TASKDATA="$proj_folder/$project/.tasks" task "$@"
