#!/bin/sh
# Manage gbt scripts

MAN_CMD=$(printf "Logs\nMove\nOutputs\nNew Project\nCreate Folders\nChoose Project\nChoose 'All' Project\nShow Project" | dmenu -i -p "PROJ Command: ")

[ "$#" -eq 1 ] && echo "OK"

# case $MAN_CMD in
#     "Logs")
#         $TERMINAL_OPEN $SCRIPTS/project/logs.sh
#         ;;
#     "Move")
#         notify-send -u critical -t 1500 "'Move' not implemented"
#         ;;
#     "Outputs")
#         notify-send -u critical -t 1500 "'Outputs' not implemented"
#         ;;
#     "New Project")
#         $SCRIPTS/project/project.sh --new
#         ;;
#     "Create Folders")
#         $SCRIPTS/project/project.sh --create-folders
#         ;;
#     "Choose Project")
#         $SCRIPTS/project/project.sh --choose
#         ;;
#     "Choose 'All' Project")
#         $SCRIPTS/project/project.sh --choose-all
#         ;;
#     "Show Project")
#         $SCRIPTS/project/project.sh --show
#         ;;
#     "")
#         # DO NOTHING
#         ;;
#     *)
#         notify-send -u critical -t 1500 "Unkown gbt choice '$MAN_CMD'"
#         ;;
# esac
