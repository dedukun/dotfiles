#!/bin/sh
# Manage gbt scripts

if [ "$1" = "gbt" ]; then
    config_file="$SCRIPTS/.config/.gbt_project"
    proj_folder="$GBT_PROJECTS"
    simlink_name="GBT_Project"
elif [ "$1" = "personal" ]; then
    config_file="$SCRIPTS/.config/.personal_project"
    proj_folder="$PERSONAL_PROJECTS"
    simlink_name="Personal_Project"
else
    notify-send -u critical -t 1500 "Not a supported project area"
    exit 1
fi

if [ "$2" = "--show" ]; then
    man_cmd="Show Project"
elif [ "$2" = "--get" ]; then
    man_cmd="Get Project"
else
    man_cmd=$(printf "Logs\nMove\nOutputs\nNew Project\nCreate Folders\nChoose Project\nChoose 'All' Project\nShow Project" | rofi -dmenu -i -p "PROJ Command" -l 8)
fi

case $man_cmd in
    "Logs")
        # $TERMINAL_OPEN $SCRIPTS/project/logs.sh
        notify-send -u critical -t 1500 "'Logs' not implemented"
        ;;
    "Move")
        notify-send -u critical -t 1500 "'Move' not implemented"
        ;;
    "Outputs")
        notify-send -u critical -t 1500 "'Outputs' not implemented"
        ;;
    "New Project")
        $SCRIPTS/project/project.sh --config "$config_file"  --folder "$proj_folder"  --symlink "$simlink_name" --new
        ;;
    "Create Folders")
        $SCRIPTS/project/project.sh --config "$config_file"  --folder "$proj_folder"  --symlink "$simlink_name" --create-folders
        ;;
    "Choose Project")
        $SCRIPTS/project/project.sh --config "$config_file"  --folder "$proj_folder"  --symlink "$simlink_name" --choose
        ;;
    "Choose 'All' Project")
        $SCRIPTS/project/project.sh --config "$config_file"  --folder "$proj_folder"  --symlink "$simlink_name" --choose-all
        ;;
    "Show Project")
        $SCRIPTS/project/project.sh --config "$config_file"  --folder "$proj_folder"  --symlink "$simlink_name" --show
        ;;
    "Get Project")
        $SCRIPTS/project/project.sh --config "$config_file"  --folder "$proj_folder"  --symlink "$simlink_name" --get
        ;;
    "")
        # DO NOTHING
        ;;
    *)
        notify-send -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'"
        ;;
esac
