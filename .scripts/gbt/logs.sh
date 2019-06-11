#!/bin/sh
print_help () {
    echo "This script helps keeping logs organized and manage them"
    echo "Calling it with no arguments will open the log file of the day"
    printf "\t-b , --back        Open the nth previous log from today\n"
    printf "\t-f , --find        Search for the word in the logs\n"
    printf "\t-fi, --find-ins    Search for the word in the logs (case insensitive)\n"
    printf "\t-d , --destination Destination folder\n"
    printf "\t-h , --help        Prints help menu\n"
}

check_folder () {
    # Check if valid directory
    if [ ! -e "$1" ]; then
        mkdir -p "$1"
        notify-send -t 2000 "New Log Folder" "'$1' was created."
    elif [ ! -d "$1" ]; then
        notify-send -u critical -t 2000 "Invalid file type" "'$1' is not a directory."
        exit 1
    fi

    LOG_FOLDER="$1"
}

LOG_FOLDER="$HOME/Globaltronic/Logging/logs"
LOG_NAME="log_$(date +%y_%m_%d)"

while [ $# -gt 0 ]
do
    LOG_KEY="$1"

    case $LOG_KEY in
        -f|--find)
        LOG_FIND="$2"
        shift # past argument
        shift # past value
        ;;
        -fi|--find-ins)
        LOG_FIND="$2"
        LOG_FIND_IN=YES
        shift # past argument
        shift # past value
        ;;
        -b|--back)
        LOG_BACK="$2"
        shift # past argument
        shift # past value
        ;;
        -d|--destination)
        check_folder "$2"
        shift # past argument
        shift # past value
        ;;
        -h|--help)
        shift # past argument
        print_help
        exit 0
        ;;
        *)
        echo "Invalid argument '$1'."
        echo "For more help use argument -h or --help".
        shift # past argument
        exit 1
        ;;
    esac
done

# find word in logs
if [ -n "$LOG_FIND" ]; then
    if [ -n "$LOG_FIND_IN" ]; then
        grep --color "$LOG_FOLDER" -R -i -e "$LOG_FIND"
    else
        grep --color "$LOG_FOLDER" -R -e "$LOG_FIND"
    fi
# open previous log
elif [ -n "$LOG_BACK" ]; then
    # offset is different is the file for today already exists
    if [ ! -f "$LOG_FOLDER/$LOG_NAME" ]; then
        vim "$LOG_FOLDER/$(find "$LOG_FOLDER" | tail -n "$LOG_BACK" | head -n 1)"
    else
        vim "$LOG_FOLDER/$(find "$LOG_FOLDER" | tail -n $(("$LOG_BACK"+1)) | head -n 1)"
    fi
# open today's log
else
    vim "$LOG_FOLDER/$LOG_NAME"
fi
