#!/bin/bash
print_help () { echo "This script helps to take and organize screenshots."
    echo "Calling it with no arguments will take a screenshot and save to the current date's folder."
    echo -e "\t -f, --folder       Specify the folder where the screenshots are saved (default: \$HOME/Pictures/screenshots)"
    echo -e "\t -s, --selected     Select the area of the screenshot"
    echo -e "\t-df, --date-folder  Save the screenshot in a subdirectory with the current date"
    echo -e "\t -t, --timer        Starts a countdown timer for the screenshot"
    echo -e "\t -h, --help         Prints this help menu"
}

SCREEN_BASE_FOLDER="$HOME/Pictures/screenshots"
SCREEN_TMP_NAME="/tmp/_screenshotTMP.png"

while [[ $# -gt 0 ]]
do
    SCREEN_KEY="$1"

    case $SCREEN_KEY in
        -f|--folder)
        SCREEN_BASE_FOLDER=$2
        shift # past argument
        shift # past value
        ;;
        -s|--selected)
        SCREEN_SELECTED=YES
        shift # past argument
        ;;
        -df|--date-folder)
        SCREEN_DATE_FOLDER=YES
        shift # past argument
        ;;
        -t|--timer)
        SCREEN_TIMER=$2
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
        echo "For more help use argument -h or --help."
        shift # past argument
        exit 1
        ;;
    esac
done

# Check if the base folder exists
if [ ! -d "$SCREEN_BASE_FOLDER" ]; then
    echo -e "'$SCREEN_BASE_FOLDER' doesn't exists.\nFor more information use argument -h or --help."
    exit 1
fi

if [[ -n $SCREEN_TIMER ]]; then
    timer_count=0
    while [[ "$timer_count" != "$SCREEN_TIMER" ]]
    do
        timer_count=$((timer_count+1))
        notify-send -t 1000 "Timer: $((SCREEN_TIMER-timer_count))"
        sleep 1
    done
fi

# take the screen shot now so its timing doesn't depend on the user input
if [[ -n $SCREEN_SELECTED ]]; then
    maim -s --hidecursor "$SCREEN_TMP_NAME"
else
    maim --hidecursor "$SCREEN_TMP_NAME"
fi

# Set a custom file name (uses current date/time if no input)
SCREEN_NAME=$(echo | dmenu -p "Enter file name:")

# If a custom name is defined, add a "_" before it
if [ ! -z "$SCREEN_NAME" ]; then
    SCREEN_NAME="_"$SCREEN_NAME
fi

# Using a sub-directory with the date to save the screenshot
if [[ -n $SCREEN_DATE_FOLDER ]]; then

    SCREEN_DATE_FOLDER=$(date '+%F')

    # Create the folder if it doesn't exists
    if [ ! -d "$SCREEN_BASE_FOLDER/$SCREEN_DATE_FOLDER" ]; then
        mkdir "$SCREEN_BASE_FOLDER/$SCREEN_DATE_FOLDER"
    fi

    # Add the sub-directory to the pre-name
    SCREEN_PRE_NAME=$SCREEN_DATE_FOLDER/$(date '+%H%M%S')
else
    # Add date to pre-name
    SCREEN_PRE_NAME=$(date '+%F-%H%M%S')
fi

# move screen shot to the correct folder and rename it
if [[ -n $SCREEN_SELECTED ]]; then
    mv "$SCREEN_TMP_NAME" "$SCREEN_BASE_FOLDER/$SCREEN_PRE_NAME$SCREEN_NAME-S.png"; notify-send -t 2000 "Screenshot selected taken" "A new screenshot was saved to \'$SCREEN_BASE_FOLDER\'"
else
    mv "$SCREEN_TMP_NAME" "$SCREEN_BASE_FOLDER/$SCREEN_PRE_NAME$SCREEN_NAME.png"; notify-send -t 2000 "Screenshot taken" "A new screenshot was saved to \'$SCREEN_BASE_FOLDER\'"
fi