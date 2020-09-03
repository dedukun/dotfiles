#!/bin/sh
# Manage gbt scripts

notify_send_flags='--replaces-process "proj-manage"'
notify_send_title='Project Manage'

if [ "$1" = "gbt" ]; then
    config_file="$SCRIPTS/.config/.gbt_project"
    proj_folder="$GBT_PROJECTS"

    notify_send_title="GBT $notify_send_title"
    notify_send_flags='--replaces-process "gbt-proj-manage"'

    simlink_name="GBT_Project"
elif [ "$1" = "personal" ]; then
    config_file="$SCRIPTS/.config/.personal_project"
    proj_folder="$PERSONAL_PROJECTS"
    simlink_name="Personal_Project"

    notify_send_title="Personal $notify_send_title"
    notify_send_flags='--replaces-process "per-proj-manage"'
else
    #notify-send.py -u critical -t 1500 "$notify_send_title" "Not a supported project area" $notify_send_flags
    notify-send -u critical -t 1500 "$notify_send_title" "Not a supported project area"
    exit 1
fi

if [ "$2" = "--show" ]; then
    man_cmd="Show Project"
elif [ "$2" = "--get" ]; then
    man_cmd="Get Project"
else
    man_cmd=$(printf "Logs\nMove\nOutputs\nNew Project\nCreate Folders\nChoose Project\nShow Project" | rofi -dmenu -i -p "PROJ Command:" -l 7)
fi

case $man_cmd in
    "Logs")
        # $TERMINAL_OPEN $SCRIPTS/project/logs.sh
        #notify-send.py -u critical -t 1500 "$notify_send_title" "'Logs' not implemented" $notify_send_flags
        notify-send -u critical -t 1500 "$notify_send_title" "'Logs' not implemented"
        ;;
    "Move")
        #notify-send.py -u critical -t 1500 "$notify_send_title" "'Move' not implemented" $notify_send_flags
        notify-send -u critical -t 1500 "$notify_send_title" "'Move' not implemented"
        ;;
    "Outputs")
        #notify-send.py -u critical -t 1500 "$notify_send_title" "'Outputs' not implemented" $notify_send_flags
        notify-send -u critical -t 1500 "$notify_send_title" "'Outputs' not implemented"
        ;;
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
        #notify-send.py -u critical -t 1500 "$notify_send_title" "Unkown gbt choice '$MAN_CMD'" $notify_send_flags
        notify-send -u critical -t 1500 "$notify_send_title" "Unkown gbt choice '$MAN_CMD'"
        ;;
esac
