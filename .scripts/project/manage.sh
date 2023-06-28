#!/bin/sh
# Manage gbt scripts

notify_send_flags='--replaces-process "proj-manage"'
notify_send_title='Project Manage'

if [ "$1" = "gbt" ]; then
    config_file="$SCRIPTS/.cache/.gbt_project"
    proj_folder="$GBT_PROJECTS"
    simlink_name="GBT_Project"

    notify_send_title="GBT $notify_send_title"
    notify_send_flags='--replaces-process "gbt-proj-manage"'
elif [ "$1" = "per" ]; then
    config_file="$SCRIPTS/.cache/.personal_project"
    proj_folder="$PERSONAL_PROJECTS"
    simlink_name="Personal_Project"

    notify_send_title="Personal $notify_send_title"
    notify_send_flags='--replaces-process "per-proj-manage"'
else
    notify-send -u critical -t 1500 "$notify_send_title" "Not a supported project area"
    exit 1
fi

if [ "$2" = "--show" ]; then
    man_cmd="Show Project"
elif [ "$2" = "--get" ]; then
    man_cmd="Get Project"
else
    man_cmd=$(printf "New Project\nCreate Folders\nChoose Project\nShow Project" | rofi -dmenu -i -p "PROJ Command:" -l 5)
fi

case $man_cmd in
    "New Project")
        $SCRIPTS/project/project.sh --config "$config_file" --folder "$proj_folder" --symlink "$simlink_name" --new
        ;;
    "Create Folders")
        $SCRIPTS/project/project.sh --config "$config_file" --folder "$proj_folder" --symlink "$simlink_name" --create-folders
        ;;
    "Choose Project")
        $SCRIPTS/project/project.sh --config "$config_file" --folder "$proj_folder" --symlink "$simlink_name" --choose
        ;;
    "Show Project")
        $SCRIPTS/project/project.sh --config "$config_file" --folder "$proj_folder" --symlink "$simlink_name" --show
        ;;
    "Get Project")
        $SCRIPTS/project/project.sh --config "$config_file" --folder "$proj_folder" --symlink "$simlink_name" --get
        ;;
    "")
        # DO NOTHING
        ;;
    *)
        notify-send -u critical -t 1500 "$notify_send_title" "Unkown gbt choice '$man_cmd'"
        ;;
esac
