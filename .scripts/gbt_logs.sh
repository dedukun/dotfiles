#!/bin/bash
print_help () { echo "This script helps keeping logs organized and manage them"
    echo "Calling it with no arguments will open the log file of the day"
    echo -e "\t-b, --back      Open the nth previous log from today"
    echo -e "\t-f, --find      Search for the word in the logs"
    echo -e "\t-h, --help      Prints help menu"
}

LOG_FOLDER="$HOME/Globaltronic/Logging/logs"
LOG_NAME="log_$(date +%y_%m_%d)"

while [[ $# -gt 0 ]]
do
    LOG_KEY="$1"

    case $LOG_KEY in
        -f|--find)
        LOG_FIND="$2"
        shift # past argument
        shift # past value
        ;;
        -b|--back)
        LOG_BACK="$2"
        shift # past argument
        shift # past value
        ;;
        -h|--help)
        shift # past argument
        print_help
        exit
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
if [[ -n $LOG_FIND ]]; then
    grep --color $LOG_FOLDER -R -i -e $LOG_FIND
# open previous log
elif [[ -n $LOG_BACK ]]; then
    # offset is different is the file for today already exists
    if [[ ! -f $LOG_FOLDER/$LOG_NAME ]]; then
        vim $LOG_FOLDER/$(ls $LOG_FOLDER | tail -n $LOG_BACK | head -n 1)
    else
        vim $LOG_FOLDER/$(ls $LOG_FOLDER | tail -n $(echo "$LOG_BACK+1" | bc) | head -n 1)
    fi
# open today's log
else
    vim $LOG_FOLDER/$LOG_NAME
fi
