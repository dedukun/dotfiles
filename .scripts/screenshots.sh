#!/bin/bash
print_help () { echo "This script helps to take and organize screenshots."
    echo "Calling it with no arguments will take a screenshot and save to the current date's folder."
    echo -e "\t -f, --folder       Specify the folder where the screenshots are saved (default: \$HOME/Pictures/screenshots)"
    echo -e "\t -s, --selected     Select the area of the screenshot"
    echo -e "\t-df, --date-folder  Save the screenshot in a subdirectory with the current date"
    echo -e "\t -h, --help         Prints this help menu"
}

SCREEN_BASE_FOLDER="$HOME/Pictures/screenshots"
SCREEN_DATE="$(date +%H%M%S)"

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
        -h|--help)
        shift # past argument
        print_help
        exit
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
    exit 0
fi

# Set a custom file name (put current date/time if no input)
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
        mkdir $SCREEN_BASE_FOLDER/$SCREEN_DATE_FOLDER
    fi

    # Add the sub-directory to the pre-name
    SCREEN_PRE_NAME=$SCREEN_DATE_FOLDER/$(date '+%H%M%S')
else
    # Add date to pre-name
    SCREEN_PRE_NAME=$(date '+%F-%H%M%S')
fi

# take screen shot of a selected region and move it to the correct folder
if [[ -n $SCREEN_SELECTED ]]; then
    maim -s --hidecursor "$SCREEN_BASE_FOLDER/$SCREEN_PRE_NAME$SCREEN_NAME-S.png"; notify-send -t 2000 "Screenshot selected taken" "A new screenshot was saved to \'$SCREEN_BASE_FOLDER\'"
else
    maim --hidecursor "$SCREEN_BASE_FOLDER/$SCREEN_PRE_NAME$SCREEN_NAME.png"; notify-send -t 2000 "Screenshot taken" "A new screenshot was saved to \'$SCREEN_BASE_FOLDER\'"
fi
